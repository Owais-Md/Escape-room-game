love.graphics.setDefaultFilter("nearest","nearest")
local Game = require "Game_Data"
local StateStack = require "State Stack"
local Player = require "Player"
local Background = require "Background"
local Dialog = require "Dialog"
local Menu = require "Menu"

function love.load()
    love.mouse.setVisible(false)
    local speed = 8
    local show_debugging = false
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
end

function love.keypressed(key)
    gameObjects:takeInput(key)
    if dialogBoxActive then
        dialogBox:UpdateLine(key)
    end
    if key == "escape" then
        playerActive = not playerActive
        dialogBoxActive = not dialogBoxActive
    end
    if key == "f10" then
        show_debugging = not show_debugging
    end
end

function love.update(dt)
    background:Update(dt, speed)
    if playerActive then
        player:Update(dt)
    end
end

function love.draw()
    width = love.graphics.getWidth()
    height = love.graphics.getHeight()
    scale = math.min(width/800, height/560)
    love.graphics.translate((width-800*scale)/2,(height-560*scale)/2)
    love.graphics.scale(scale)
    love.graphics.push()
    background:Draw(show_debugging)
    player:Draw(show_debugging)
    if dialogBoxActive then
        dialogBox:PrintDialog()
    end
    love.graphics.pop()
    -- love.graphics.print(love.timer.getFPS())
end