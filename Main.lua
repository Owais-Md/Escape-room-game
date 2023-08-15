love.graphics.setDefaultFilter("nearest","nearest")
local stateStack = require "State Stack"
local Player = require "Player"
local Background = require "Background"
local Dialog = require "Dialog"
local Menu = require "Menu"

function love.load()
    love.mouse.setVisible(false)
    speed = 8
    show_debugging = false
    player = Player:New()
    roomPath = "Room 1"
    background = Background:New(roomPath, player.world)
    dialogBox = Dialog:getDialogBox()
    --menu = Menu:getMenu()
    ActivityStack = {}
    playerActive = true
    dialogBoxActive = false
    menuActive = false
    dialogBox:pushDialog('The chest is not locked, press "o" to open or "c" to close the chest. The door is locked, try to find its key. There also appears to be a fireplace in the room that is pretty warm.')
end

function love.keypressed(key)
    if key == "escape" then
        playerActive = not playerActive
        dialogBoxActive = not dialogBoxActive
    end
    if key == "f10" then
        show_debugging = not show_debugging
    end
    if dialogBoxActive then
        dialogBox:UpdateLine(key)
    end
end

function love.update(dt)
    background:Update(dt, speed)
    if playerActive then
        player:Update(dt)
    end
end

function love.draw()
    love.graphics.push()
    love.graphics.scale(love.graphics.getWidth()/800, love.graphics.getHeight()/560)
    background:Draw(show_debugging)
    player:Draw(show_debugging)
    if dialogBoxActive then
        dialogBox:PrintDialog()
    end
    love.graphics.pop()
end