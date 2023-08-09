local wf = require "libraries.windfield" --FOSS library for game physics
local tilesetData = require "TilesetDataGenerator"

local Background = {}

function Background:New(path, scale, world)
    local background = {}
    setmetatable(background, self)
    self.__index = self
    
    background.map = require(path)

    background.timer = 0

    background.walls = {}
    background.collisionRegions = {}
    background.enteredCollider = nil
    for _,layer in ipairs(background.map.layers) do
        if(layer.name == "Game Walls") then
            for i, obj in pairs(layer.objects)do
                local wall = world:newRectangleCollider(obj.x*scale, obj.y*scale, obj.width*scale, obj.height*scale)
                wall:setType('static')
                table.insert(background.walls, wall)
            end
        end
    end
    for _,layer in ipairs(background.map.layers) do
        if(layer.name == "Collision Regions") then
            for i, obj in pairs(layer.objects)do
                local collisionRegion = world:newRectangleCollider(obj.x*scale, obj.y*scale, obj.width*scale, obj.height*scale)
                local name = obj.name
                collisionRegion:setType('static')
                collisionRegion:setCollisionClass('Detector')
                table.insert(background.collisionRegions, {object = collisionRegion, name = name})
            end
        end
    end
    
    background.quads = tilesetData.quads
    background.tilesetRanges = tilesetData.tilesetRanges
    background.animatedTiles = tilesetData.animatedTiles
    background.timelimit = tilesetData.timeLimit
    background.images = tilesetData.images
    return background
end

function Background:Update(dt, animationSpeed)
    self.timer = (self.timer + animationSpeed*dt)
    for _, collider in ipairs(self.collisionRegions) do
        if collider.object:enter('Player') then
            self.enteredCollider = collider
        end
    end
    if self.enteredCollider and self.enteredCollider.object:exit('Player') then
        self.enteredCollider = nil
    end
end

function Background:Draw(show_debugging)
    for _, layer in ipairs(self.map.layers) do
        if layer.type ~= "objectgroup" then
            for y = 0, layer.height - 1 do
                for x = 0, layer.width - 1 do
                    local index = (x + y * layer.width) + 1
                    local tid = layer.data[index]
                    flipped_horizontal = bit.band(0x80000000, tid)
                    flipped_vertical = bit.band(0x40000000, tid)
                    x_offset, y_offset, x_scale, y_scale = 0, 0, 1, 1
                    if flipped_vertical ~= 0 then
                        y_offset = 1
                        x_scale = -1
                    end
                    if flipped_horizontal ~= 0 then
                        x_offset = 1
                        y_scale = -1
                    end
                    tid = tid + bit.band(0x80000000, tid) - bit.band(0x40000000, tid)
                    if tid ~= 0 then
                        if self.animatedTiles[tid - 1] ~= nil then
                            local anim = self.animatedTiles[tid - 1].animation
                            local i = (self.timer - self.timer%1) % #anim
                            tid = anim[i + 1].tileid + 1
                        end
                        for i,tileset in ipairs(self.tilesetRanges) do
                            if tid>=tileset.start and tid<tileset.finish then
                                tilesetname = tileset.name
                            end
                        end
                        local quad = self.quads[tid]
                        local image
                        for _, imageset in ipairs(self.images) do
                            if imageset.name == tilesetname then
                                image = imageset.image
                            end
                        end
                        love.graphics.push()
                        love.graphics.scale(scale)
                        love.graphics.draw(
                            love.graphics.newImage(image),
                            quad,
                            (x + x_offset)*self.map.tilewidth,
                            (y + y_offset)*self.map.tileheight,
                            0,
                            y_scale,
                            x_scale
                        )
                        love.graphics.pop()
                    end
                end
            end
        end
    end
    if self.enteredCollider ~= nil and show_debugging then
        love.graphics.print(self.enteredCollider.name)
    end
end

return Background