--need to make a teleport function that moves player to next room depending on the active teleport object
--need to add isOn to furnace

local tilesetData = require "TilesetDataGenerator"
local inOb = require "Interactable animation"

local imageSets = {}

local Table = {}

for _, tilesetRange in ipairs(tilesetData.tilesetRanges) do
    local imagePath = tilesetRange.imagePath
    local newImage = love.graphics.newImage(imagePath)
    table.insert(imageSets, {path = imagePath, image = newImage})
end

local Background = {}

function Background:New(path, speed, world, gameObjects)
    local background = {}
    setmetatable(background, self)
    self.__index = self
    
    background.map = require(path)
    background.gameobjects = gameObjects

    background.timer = 0
    background.scale = 5

    background.walls = {}
    background.movingWalls = {}
    background.collisionRegions = {}
    background.interactableObjects = {}
    background.activeObject = nil
    background.enteredColliders = {}
    background.enteredCollider = nil
    background.speed = speed
    for _,layer in ipairs(background.map.layers) do
        if(layer.type == "objectgroup") then
            for i, obj in pairs(layer.objects)do
                if obj.type == "wall" then
                    local wall = world:newRectangleCollider(obj.x*background.scale, obj.y*background.scale, obj.width*background.scale, obj.height*background.scale)
                    wall:setType('static')
                    wall:setCollisionClass('Wall')
                    table.insert(background.walls, wall)
                elseif obj.type == "detect" then
                    local collisionRegion = world:newRectangleCollider(obj.x*background.scale, obj.y*background.scale, obj.width*background.scale, obj.height*background.scale)
                    collisionRegion:setType('static')
                    collisionRegion:setCollisionClass('Detector')
                    table.insert(background.collisionRegions, {object = collisionRegion, name = obj.name})
                elseif obj.type == "movingWall" then
                    local wall = world:newRectangleCollider(obj.x*background.scale, obj.y*background.scale, obj.width*background.scale, obj.height*background.scale)
                    wall:setType('static')
                    wall:setCollisionClass('Wall')
                    table.insert(background.movingWalls, {collider = wall, name = obj.name, class = "Wall"})
                elseif obj.type == "draw" then
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
    return background
end

function Background:Update(dt)
    self.timer = (self.timer + self.speed*dt) % tilesetData.timeLimit
    for _, collider in ipairs(self.collisionRegions) do
        if collider.object:enter('Player') then
            table.insert(self.enteredColliders, 1, collider)
        end
    end
    Table = {}
    for _,enteredCollider in ipairs(self.enteredColliders) do
        if not enteredCollider.object:exit('Player') then
            table.insert(Table, enteredCollider)
        end
    end
    self.enteredColliders = Table
    self.activeObject = nil
    if #self.enteredColliders ~= 0 then
        self.enteredCollider = self.enteredColliders[1]
    else
        self.enteredCollider = nil
    end
    if self.enteredCollider then
        for _, interactableObject in ipairs(self.interactableObjects) do
            if  interactableObject.name == self.enteredCollider.name then
                self.activeObject = interactableObject
            end
        end
    end
    gameObjects:Update(self.enteredColliders, self.activeObject)
    if self.activeObject then
        if love.keyboard.isDown("o") or self.activeObject.object.isOpening then
            self.activeObject.object:Open(dt)
        elseif love.keyboard.isDown("c") or self.activeObject.object.isClosing then
            self.activeObject.object:Close(dt)
        end
        if self.activeObject.object.isClosed then
            for _, movingWall in ipairs(self.movingWalls) do
                if self.activeObject.name == movingWall.name then
                    if movingWall.class ~= "Wall" then
                        movingWall.collider:setCollisionClass('Wall')
                        movingWall.class = "Wall"
                    end
                end
            end
        else
            for _, movingWall in ipairs(self.movingWalls) do
                if self.activeObject.name == movingWall.name then
                    if movingWall.class ~= "Open Wall" then
                        movingWall.collider:setCollisionClass('Open Wall')
                        movingWall.class = "Open Wall"
                    end
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
            --layer, self.map.tilewidth, self.map.tileheight, tilesetData.animatedTiles, tilesetData.quads, tilesetData.tilesetRanges, self.timer
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
                        if tilesetData.animatedTiles[tid - 1] ~= nil then
                            local anim = tilesetData.animatedTiles[tid - 1].animation
                            local i = (self.timer - self.timer%1) % #anim
                            tid = anim[i + 1].tileid + 1
                        end
                        local quad = tilesetData.quads[tid]
                        local imagePath
                        for i,tilesetRange in ipairs(tilesetData.tilesetRanges) do
                            if tid>=tilesetRange.start and tid<tilesetRange.finish then
                                imagePath = tilesetRange.imagePath
                            end
                        end
                        local imageToDrawFrom
                        for _, imageSet in ipairs(imageSets) do
                            if imageSet.path == imagePath then
                                imageToDrawFrom = imageSet.image
                            end
                        end
                        love.graphics.draw(
                            imageToDrawFrom,
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
                if obj.type == "draw" then
                    for _, interactableObject in ipairs(self.interactableObjects) do
                        if obj.name == interactableObject.name then
                            object = interactableObject.object
                            local imageToDrawFrom
                            for _, imageSet in ipairs(imageSets) do
                                if imageSet.path == object.imagePath then
                                    imageToDrawFrom = imageSet.image
                                end
                            end
                            quad = object.quads[object.frame + 1]
                            love.graphics.draw(
                                imageToDrawFrom,
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
    if show_debugging then
        if self.activeObject then
            love.graphics.print("activeObject:"..self.activeObject.name)
        end
        if self.enteredCollider then
            love.graphics.print("\nenteredColliders:")
            t = "\n\n                           "
            for _, enteredCollider in ipairs(self.enteredColliders) do
                love.graphics.print(t..enteredCollider.name)
                t = "\n"..t
            end
        end
    end
end

return Background