love.graphics.setDefaultFilter("nearest","nearest")
local Game = require "Game_Data"
local StateStack = require "State Stack"
local Player = require "Player"
local Background = require "Background"
local Dialog = require "Dialog"
local Menu = require "Menu"

show_debugging = false

function love.load()
    love.mouse.setVisible(false)
    local speed = 8
    local roomPath = "Room 1"
    stateStack = StateStack:getStateStack()
    dialogBox = Dialog:getDialogBox()
    gameObjects = Game:getGameObjects()
    player = Player:New()
    background = Background:New(roomPath, speed ,player.world)
    --menu = Menu:getMenu()
    playerActive = true
    dialogBoxActive = false
    menuActive = false
    stateStack:Push("background", "player")
end

function love.keypressed(key)
    if key == "f10" then
        show_debugging = not show_debugging
    end
    gameObjects:takeInput(key)
end

function love.update(dt)
    gameObjects:Update(dt)
    background:Update(dt)
    player:Update(dt)
end

function love.draw()
    background:Draw()
    player:Draw()
    if stateStack:Top() == "dialogBox" then
        dialogBox:PrintDialog()
    end
    -- love.graphics.print(love.timer.getFPS())
end