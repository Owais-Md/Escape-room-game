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
    love.graphics.push()
    love.graphics.scale(love.graphics.getWidth()/800, love.graphics.getHeight()/560)
    background:Draw(show_debugging)
    player:Draw(show_debugging)
    love.graphics.pop()
end