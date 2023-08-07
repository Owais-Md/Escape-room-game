local love = require "love"
local Player = require "Player"
local anim8 = require "libraries/anim8" --FOSS library for animations
local sti = require "libraries/sti" --FOSS library for implementing Tiled

function love.load()
    love.mouse.setVisible(false)
    _G.player = Player:new()
    Map = sti('Maps/Map 1.lua')
end

function love.update(dt)
    player:Update(dt)
end

function love.draw()
    Map:draw(0, 0, 5)
    player:Draw()
end