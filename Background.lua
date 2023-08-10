local wf = require "libraries.windfield" --FOSS library for game physics
local tilesetData = require "TilesetDataGenerator"
local inOb = require "Interactable animation"

local Background = {}

function Background:New(path, scale, world)
    local background = {}
    setmetatable(background, self)
    self.__index = self
    
    background.map = require(path)

    background.timer = 0
    background.scale = scale

    background.walls = {}
    background.movingWalls = {}
    background.collisionRegions = {}
    background.interactableObjects = {}
    background.enteredCollider = nil
    for _,layer in ipairs(background.map.layers) do
        if(layer.type == "objectgroup") then
            for i, obj in pairs(layer.objects)do
                if obj.type == "Wall" then
                    local wall = world:newRectangleCollider(obj.x*scale, obj.y*scale, obj.width*scale, obj.height*scale)
                    wall:setType('static')
                    wall:setCollisionClass('Wall')
                    table.insert(background.walls, wall)
                elseif obj.type == "Detect" then
                    local collisionRegion = world:newRectangleCollider(obj.x*scale, obj.y*scale, obj.width*scale, obj.height*scale)
                    local name = obj.name
                    collisionRegion:setType('static')
                    collisionRegion:setCollisionClass('Detector')
                    table.insert(background.collisionRegions, {object = collisionRegion, name = name})
                elseif obj.type == "Moving-wall" then
                    local wall = world:newRectangleCollider(obj.x*scale, obj.y*scale, obj.width*scale, obj.height*scale)
                    wall:setType('static')
                    wall:setCollisionClass('Wall')
                    table.insert(background.movingWalls, {collider = wall, name = obj.name})
                elseif obj.type == "Draw" then
                    beginClosed = true
                    flipped_horizontal = true
                    flipped_vertical = false
                    animationSpeed = 5
                    local interactableObject = inOb:NewObject(beginClosed, flipped_horizontal, flipped_vertical, animationSpeed, obj.name)
                    table.insert(background.interactableObjects, {object = interactableObject, name = obj.name})
                end
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
    if self.enteredCollider and self.enteredCollider.object:stay('Player') then
        for _, movingWall in ipairs(self.movingWalls) do
            if movingWall.name == self.enteredCollider.name and love.keyboard.isDown('o') then
                movingWall.collider:setCollisionClass('Open Wall')
            end
            if movingWall.name == self.enteredCollider.name and love.keyboard.isDown('c') then
                movingWall.collider:setCollisionClass('Wall')
            end
        end
    end
end

function Background:Draw(show_debugging)
    love.graphics.push()
    love.graphics.scale(self.scale)
    for _, layer in ipairs(self.map.layers) do
        if layer.type ~= "objectgroup" then
            for y = 0, layer.height - 1 do
                for x = 0, layer.width - 1 do
                    local index = (x + y * layer.width) + 1
                    local tid = layer.data[index]
                    flipped_horizontal = bit.band(0x80000000, tid)
                    flipped_vertical = bit.band(0x40000000, tid)
                    x_offset, y_offset, x_scale, y_scale = 0, 0, 1, 1
                    if flipped_horizontal ~= 0 then
                        x_offset = 1
                        x_scale = -1
                    end
                    if flipped_vertical ~= 0 then
                        y_offset = 1
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
                        love.graphics.draw(
                            love.graphics.newImage(image),
                            quad,
                            (x + x_offset)*self.map.tilewidth,
                            (y + y_offset)*self.map.tileheight,
                            0,
                            x_scale,
                            y_scale
                        )
                    end
                end
            end
        else
            for _, obj in ipairs(layer.objects) do
                if obj.type == "Draw" then
                    for _, interactableObject in ipairs(self.interactableObjects) do
                        if obj.name == interactableObject.name then
                            object = interactableObject.object
                            Image = love.graphics.newImage(object.imagePath)
                            love.graphics.draw(
                                Image,
                                object.quads[object.frame + 1],
                                obj.x + object.x_offset*object.tileWidth,
                                obj.y + object.y_offset*object.tileHeight,
                                0,
                                object.x_scale,
                                object.y_scale
                            )
                        end
                    end
                end
            end
        end
    end
    love.graphics.pop()
    if self.enteredCollider and show_debugging then
        love.graphics.print(self.enteredCollider.name)
    end
end

return Background