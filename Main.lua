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
    stateStack = StateStack:getStateStack() --need to initiate stateStack before everything as all files use this global stateStack
    menu = Menu:getMenu() -- need to initate menu before gameObjects, as gameObjects uses menuStack:MenuPop()
    dialogBox = Dialog:getDialogBox()
    gameObjects = Game:getGameObjects()
    player = Player:New() --need to initiate player before background as player.world is passed in background
    background = Background:New(roomPath, speed, player.world)
    stateStack:Push("menu")
    --stateStack:Push("background", "player")
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
    menu:Update(dt)
end

function love.draw()
    background:Draw() -- contains the scale and origin offset for screen resizing
    menu:Draw()
    player:Draw()
    dialogBox:PrintDialog()

    --love.graphics.print(love.timer.getFPS())
    --love.graphics.print(#menu.menuStack)
end