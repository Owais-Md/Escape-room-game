local wf = require "libraries.windfield" --FOSS library for game physics
local sti = require "libraries/sti" --FOSS library for implementing Tiled

local Background = {}

function Background:New(scale, world)
    local background = {}
    setmetatable(background, self)
    self.__index = self
    --background.map = sti('Maps/Map 1.lua')
    background.map = sti('Tiled/Room 1.lua')
    background.walls = {}
    if background.map.layers["Game Walls"] then
        for i, obj in pairs(background.map.layers["Game Walls"].objects)do
            local wall = world:newRectangleCollider(obj.x*scale, obj.y*scale, obj.width*scale, obj.height*scale)
            wall:setType('static')
            table.insert(background.walls, wall)
        end
    end
    return background
end
--[[
function Background:drawLayer(layer)
    background.map:drawLayer(layer)
end
]]
function Background:Draw()love.graphics.push() -- Save the current transformation state
    love.graphics.scale(5) -- Scale the drawing by a factor of 5
    for _, layer in ipairs(self.map.layers) do
        if layer.name ~= "Game Walls" then
            self.map:drawLayer(layer)
        end
    end
    love.graphics.pop() -- Restore the previous transformation state
    --self.map:draw(0, 0, scale)
end

return Background