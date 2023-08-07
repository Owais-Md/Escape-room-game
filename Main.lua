local Player = require "Player"
local Background = require "Background"

function love.load()
    love.mouse.setVisible(false)
    _G.scale = 5
    _G.player = Player:New(scale)
    _G.background = Background:New(scale, player.world)
end

function love.update(dt)
    player:Update(dt)
end

function love.draw()
    background:Draw()
    player:Draw()
end