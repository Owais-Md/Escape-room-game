local Player = require "Player"
local Background = require "Background"

function love.load()
    love.mouse.setVisible(false)
    scale = 5
    show_debugging = false
    player = Player:New(scale)
    background = Background:New(scale, player.world)
end

function love.update(dt)
    player:Update(dt)
end

function love.draw()
    background:Draw()
    player:Draw(show_debugging)
end