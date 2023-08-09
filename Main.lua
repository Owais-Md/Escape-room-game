local Player = require "Player"
local Background = require "Background"

function love.load()
    love.mouse.setVisible(false)
    scale = 5
    animationSpeed = 5
    show_debugging = false
    player = Player:New(scale)
    roomPath = "Room"
    background = Background:New(roomPath, scale, player.world)
end

function love.update(dt)
    background:Update(dt, animationSpeed)
    player:Update(dt)
end

function love.draw()
    background:Draw()
    player:Draw(show_debugging)
end