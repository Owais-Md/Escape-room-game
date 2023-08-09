local Player = require "Player"
local Background = require "Background"

function love.load()
    love.mouse.setVisible(false)
    scale = 5
    animationSpeed = 7
    show_debugging = true
    player = Player:New(scale)
    roomPath = "Room"
    background = Background:New(roomPath, scale, player.world)
end

function love.update(dt)
    background:Update(dt, animationSpeed)
    player:Update(dt)
end

function love.draw()
    background:Draw(show_debugging)
    player:Draw(show_debugging)
end