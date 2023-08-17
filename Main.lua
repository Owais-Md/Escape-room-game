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
    background = Background:New(roomPath, speed ,player.world, gameObjects)
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
    if key == "escape" then
        playerActive = not playerActive
    end
end

function love.update(dt)
    background:Update(dt)
    player:Update(dt)
end

function love.draw()
    width = love.graphics.getWidth()
    height = love.graphics.getHeight()
    scale = math.min(width/800, height/560)
    love.graphics.translate((width-800*scale)/2,(height-560*scale)/2)
    love.graphics.scale(scale)
    love.graphics.push()
    background:Draw()
    player:Draw()
    if stateStack:Top() == "dialogBox" then
        dialogBox:PrintDialog()
    end
    love.graphics.pop()
    -- love.graphics.print(love.timer.getFPS())
    -- love.graphics.print(stateStack:Top())
end