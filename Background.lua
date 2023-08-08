local wf = require "libraries.windfield" --FOSS library for game physics
--local sti = require "libraries/sti" --FOSS library for implementing Tiled

local Background = {}

function Background:New(scale, world)
    local background = {}
    setmetatable(background, self)
    self.__index = self
    --background.map = sti('Maps/Map 1.lua')
    background.map = require "Room 1-animated"
    background.walls = {}
    background.timer = 0
    background.timelimit = 0.2
    for _,layer in ipairs(background.map.layers) do
        if(layer.name == "Game Walls") then
            for i, obj in pairs(layer.objects)do
                local wall = world:newRectangleCollider(obj.x*scale, obj.y*scale, obj.width*scale, obj.height*scale)
                wall:setType('static')
                table.insert(background.walls, wall)
            end
        end
    end
    background.quads = {}
    background.tilesetRanges = {}
    background.images = {}
    background.tilecount = 0
    for _, tileset in ipairs(background.map.tilesets) do
        for y = 0, tileset.imageheight/tileset.tileheight -1 do
            for x = 0, tileset.imagewidth/tileset.tilewidth -1 do
                local quad = love.graphics.newQuad(
                x * tileset.tilewidth,
                y * tileset.tileheight,
                tileset.tilewidth,
                tileset.tileheight,
                tileset.imagewidth,
                tileset.imageheight
                )
                table.insert(background.quads, quad)
            end
        end
        local tilesetRange = {
            start = background.tilecount,
            finish = background.tilecount + tileset.tilecount - 1,
            name = tileset.name
        }
        local image = love.graphics.newImage(tileset.image)
        table.insert(background.tilesetRanges, tilesetRange)
        local imageTable = {
            name = tileset.name,
            image = image
        }
        table.insert(background.images, imageTable)
        background.tilecount = background.tilecount + tileset.tilecount
    end
    background.animatedTiles = {}
    background.tilecount = 0
    for _,tileset in ipairs(background.map.tilesets) do
        for _,tile in ipairs(tileset.tiles)do
            for _,animationTile in ipairs(tile.animation) do
                animationTile.tileid = animationTile.tileid + background.tilecount
            end
            background.animatedTiles[background.tilecount + tile.id] = tile
            table.insert(background.animatedTiles, background.tilecount + tile.id, tile)
        end
        background.tilecount = background.tilecount + tileset.tilecount
    end
    return background
end

function Background:Update(dt, animationSpeed)
    self.timer = self.timer + animationSpeed*dt
end

function Background:Draw()
    for _, layer in ipairs(self.map.layers) do
        if layer.name ~= "Game Walls" then
            for y = 0, layer.height - 1 do
                for x = 0, layer.width - 1 do
                    local index = (x + y * layer.width) + 1
                    local tid = layer.data[index]
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
                            image,
                            quad,
                            x*self.map.tilewidth,
                            y*self.map.tileheight
                        )
                        love.graphics.pop()
                    end
                end
            end
        end
    end
end

return Background