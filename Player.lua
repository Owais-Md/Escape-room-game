local anim8 = require 'libraries/anim8'

local Player = {}

function Player:new()
    local player = {}
    setmetatable(player, self)
    self.__index = self

    love.graphics.setDefaultFilter("nearest", "nearest")
    
    player.x = love.graphics.getWidth() / 2 - 40
    player.y = love.graphics.getHeight() / 2 - 40
    player.speed = 5
    player.spriteSheet = love.graphics.newImage("Sprites/Lanea Zimmerman's spritesheets/characters.png")
    player.grid = anim8.newGrid(16, 16, player.spriteSheet:getWidth(), player.spriteSheet:getHeight())

    player.animations = {}
    player.animations.down = anim8.newAnimation(player.grid('4-6', 1), 0.2)
    player.animations.left = anim8.newAnimation(player.grid('4-6', 2), 0.2)
    player.animations.right = anim8.newAnimation(player.grid('4-6', 3), 0.2)
    player.animations.up = anim8.newAnimation(player.grid('4-6', 4), 0.2)

    player.animation_state = player.animations.down

    return player
end

function Player:Update(dt)
    local isMoving = false

    if love.keyboard.isDown("right") then
        self.x = self.x + self.speed
        self.animation_state = self.animations.right
        isMoving = true
    end

    if love.keyboard.isDown("left") then
        player.x = player.x - player.speed
        player.animation_state= player.animations.left
        isMoving = true
    end

    if love.keyboard.isDown("down") then
        player.y = player.y + player.speed
        player.animation_state= player.animations.down
        isMoving = true
    end

    if love.keyboard.isDown("up") then
        player.y = player.y - player.speed
        player.animation_state= player.animations.up
        isMoving = true
    end

    if isMoving == false then
        self.animation_state:gotoFrame(2)
    end

    self.animation_state:update(dt)
end

function Player:Draw()
    self.animation_state:draw(self.spriteSheet, self.x, self.y, nil, 5)
end

return Player
