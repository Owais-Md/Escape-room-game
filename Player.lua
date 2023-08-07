local anim8 = require 'libraries/anim8'

local Player = {}

function Player:new()
    local player = {}
    setmetatable(player, self)
    self.__index = self

    love.graphics.setDefaultFilter("nearest", "nearest")
    
    player.x = love.graphics.getWidth() / 2 - 40
    player.y = love.graphics.getHeight() / 2 - 40
    player.width = 16
    player.height = 16
    player.speed = 8
    player.scale = 5
    player.spriteSheet = love.graphics.newImage("Sprites/Lanea Zimmerman's spritesheets/characters.png")
    player.grid = anim8.newGrid(player.width, player.height, player.spriteSheet:getWidth(), player.spriteSheet:getHeight())

    player.animations = {}
    player.animations.down = anim8.newAnimation(player.grid('4-6', 1), 1/player.speed)
    player.animations.left = anim8.newAnimation(player.grid('4-6', 2), 1/player.speed)
    player.animations.right = anim8.newAnimation(player.grid('4-6', 3), 1/player.speed)
    player.animations.up = anim8.newAnimation(player.grid('4-6', 4), 1/player.speed)

    player.animation_state = player.animations.down

    return player
end

function Player:Update(dt)
    local isMoving = false

    if love.keyboard.isDown("right") or love.keyboard.isDown("kp6") or love.keyboard.isDown("d") then
        self.x = self.x + self.speed
        self.animation_state = self.animations.right
        isMoving = true

    elseif love.keyboard.isDown("left") or love.keyboard.isDown("kp4") or love.keyboard.isDown("a") then
        player.x = player.x - player.speed
        player.animation_state= player.animations.left
        isMoving = true
    
    elseif love.keyboard.isDown("down") or love.keyboard.isDown("kp2") or love.keyboard.isDown("s") then
        player.y = player.y + player.speed
        player.animation_state= player.animations.down
        isMoving = true
    
    elseif love.keyboard.isDown("up") or love.keyboard.isDown("kp8") or love.keyboard.isDown("w") then
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
    self.animation_state:draw(self.spriteSheet, self.x - (self.x % (self.scale*self.width/player.speed)), self.y - (self.y % (self.scale*self.height/player.speed)), nil, player.scale)
end

return Player
