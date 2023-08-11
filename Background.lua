local wf = require "libraries.windfield" --FOSS library for game physics
local tilesetData = require "TilesetDataGenerator"
local inOb = require "Interactable animation"

local Background = {}

function Background:New(path, world)
    local background = {}
    setmetatable(background, self)
    self.__index = self
    
    background.map = require(path)

    background.timer = 0
    background.scale = 5

    background.walls = {}
    background.movingWalls = {}
    background.collisionRegions = {}
    background.interactableObjects = {}
    background.activeObject = nil
    background.enteredColliders = {}
    background.enteredCollider = nil
    background.flag = 0
    for _,layer in ipairs(background.map.layers) do
        if(layer.type == "objectgroup") then
            for i, obj in pairs(layer.objects)do
                if obj.type == "Wall" then
                    local wall = world:newRectangleCollider(obj.x*background.scale, obj.y*background.scale, obj.width*background.scale, obj.height*background.scale)
                    wall:setType('static')
                    wall:setCollisionClass('Wall')
                    table.insert(background.walls, wall)
                elseif obj.type == "Detect" then
                    local collisionRegion = world:newRectangleCollider(obj.x*background.scale, obj.y*background.scale, obj.width*background.scale, obj.height*background.scale)
                    local name = obj.name
                    collisionRegion:setType('static')
                    collisionRegion:setCollisionClass('Detector')
                    table.insert(background.collisionRegions, {object = collisionRegion, name = name})
                elseif obj.type == "Moving-wall" then
                    local wall = world:newRectangleCollider(obj.x*background.scale, obj.y*background.scale, obj.width*background.scale, obj.height*background.scale)
                    wall:setType('static')
                    wall:setCollisionClass('Wall')
                    table.insert(background.movingWalls, {collider = wall, name = obj.name})
                elseif obj.type == "Draw" then
                    beginClosed = true
                    flipped_horizontal = true
                    flipped_vertical = false
                    animationSpeed = 15
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
            table.insert(self.enteredColliders, 1, collider)
            self.enteredCollider = self.enteredColliders[1]
        end
    end
    for _,enteredCollider in ipairs(self.enteredColliders) do
        if enteredCollider.object:exit('Player') then
            for _,colliderToDelete in ipairs(self.enteredColliders) do
                if enteredCollider.name == colliderToDelete.name then
                    table.remove(self.enteredColliders, _)
                    break
                end
            end
            if #self.enteredColliders ~= 0 then
                self.enteredCollider = self.enteredColliders[1]
            else
                self.enteredCollider = nil
                self.activeObject = nil
            end
        end
    end
    if self.enteredCollider then
        for _, interactableObject in ipairs(self.interactableObjects) do
            if  interactableObject.name == self.enteredCollider.name then
                self.activeObject = interactableObject.object
            end
        end
    end
    if self.activeObject then
        if love.keyboard.isDown("o") or self.activeObject.isOpening then
            self.activeObject:Open(dt)
        elseif love.keyboard.isDown("c") or self.activeObject.isClosing then
            self.activeObject:Close(dt)
        end
        if self.activeObject.isClosed then
            for _, movingWall in ipairs(self.movingWalls) do
                if movingWall.name == self.activeObject.name then
                    movingWall:setCollisionClass('Wall')
                end
            end
        else
            for _, movingWall in ipairs(self.movingWalls) do
                if movingWall.name == self.activeObject.name then
                    movingWall:setCollisionClass('Open Wall')
                end
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
                            quad = object.quads[object.frame + 1]
                            love.graphics.draw(
                                Image,
                                quad,
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
        love.graphics.print(self.enteredCollider.name..self.flag)
        if self.activeObject ~= nil then
            love.graphics.print("\n"..self.activeObject.frame)
            if self.activeObject.isClosed then
                love.graphics.print("\n\nClosed")
            else
                love.graphics.print("\n\nOpened")
            end
        end
    end
end

return Background