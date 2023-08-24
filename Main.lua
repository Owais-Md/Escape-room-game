local Game = require "Game_Data"
local StateStack = require "State Stack"
local Player = require "Player"
local Background = require "Background"
local Dialog = require "Dialog"
local Menu = require "Menu"

show_debugging = false

function love.load()
    stateStack = StateStack:getStateStack() --need to initiate stateStack before everything as all files use this global stateStack
    menu = Menu:getMenu() -- need to initate menu before gameObjects, as gameObjects uses menuStack:MenuPop()
    dialogBox = Dialog:getDialogBox()
    gameObjects = Game:getGameObjects()
    player = Player:New() --need to initiate player before background as player.world is passed in background
    background = Background:New(gameObjects.Progress.currentRoomName, player.world)
    stateStack:Push("menu")
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
    player:Draw()
    dialogBox:PrintDialog()
    menu:Draw()
    if show_debugging then
        love.graphics.push()
        love.graphics.print(love.timer.getFPS(), smallFont:getHeight(), 560-2*smallFont:getHeight())
        love.graphics.pop()
    end
end