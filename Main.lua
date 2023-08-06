local love = require "love"
local Player = require "Player"
local anim8 = require 'libraries/anim8' --FOSS library for animations


function love.load()
    love.mouse.setVisible(false)
    _G.player = Player:new()
end

function love.update(dt)
    player:Update(dt)
end

function love.draw()
    player:Draw()
end