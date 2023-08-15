love.graphics.setDefaultFilter("nearest","nearest")
local Player = require "Player"
local Background = require "Background"
local Dialog = require "Dialog"

function love.load()
    love.mouse.setVisible(false)
    speed = 8
    show_debugging = false
    player = Player:New()
    roomPath = "Room 1"
    background = Background:New(roomPath, player.world)
    playerActive = true
end

function love.keypressed(key)
    if key == "escape" then
        playerActive = not playerActive
    end
    if key == "f10" then
        show_debugging = not show_debugging
    end
end

function love.update(dt)
    background:Update(dt, speed, player.x, player.y, player.width, player.height)
    if playerActive then
        player:Update(dt)
    end
end

function love.draw()
    love.graphics.push()
    love.graphics.scale(love.graphics.getWidth()/800, love.graphics.getHeight()/560)
    background:Draw(show_debugging)
    player:Draw(show_debugging)
    love.graphics.pop()
    Dialog()
end