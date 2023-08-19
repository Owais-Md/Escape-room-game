love.graphics.setDefaultFilter("nearest","nearest")
love.mouse.setVisible(false)
local Game = require "Game_Data"
local StateStack = require "State Stack"
local Player = require "Player"
local Background = require "Background"
local Dialog = require "Dialog"
local Menu = require "Menu"

show_debugging = false

function love.load()
    local speed = 8 -- need to put this in background.lua
    local roomPath = "Room 1" -- need to put this in background.lua too, where it takes info from Game_Data:loadGame()
    stateStack = StateStack:getStateStack()
    dialogBox = Dialog:getDialogBox()
    gameObjects = Game:getGameObjects()
    player = Player:New()
    background = Background:New(roomPath, speed, player.world)
    --menu = Menu:getMenu()
    --stateStack:Push("Menu")
    stateStack:Push("background", "player")
end

function love.keypressed(key)
    if key == "f10" then
        show_debugging = not show_debugging
    end
    gameObjects:takeInput(key)
end

function love.update(dt)
    --menu:Update(dt)
    background:Update(dt)
    gameObjects:Update(dt)
    player:Update(dt)
end

function love.draw()
    background:Draw()
    player:Draw()
    if stateStack:Top() == "dialogBox" then -- could move condition to PrintDialog itself
        dialogBox:PrintDialog()
    end
    -- menu:Draw()

    -- love.graphics.print(love.timer.getFPS())
end