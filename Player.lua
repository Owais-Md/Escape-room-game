local anim8 = require 'libraries/anim8'
local wf = require "libraries.windfield" --FOSS library for game physics

local Player = {}

function Player:New(scale)
    local player = {}
    setmetatable(player, self)
    self.__index = self

    love.graphics.setDefaultFilter("nearest", "nearest")
    
    
    player.width = 16
    player.height = 16
    player.scale = scale
    player.speed = 3*player.scale/4
    player.spriteSheet = love.graphics.newImage("Sprites/Lanea Zimmerman's spritesheets/characters.png")
    player.grid = anim8.newGrid(player.width, player.height, player.spriteSheet:getWidth(), player.spriteSheet:getHeight())
    player.x = love.graphics.getWidth() / 2 - player.scale*player.width/2
    player.y = love.graphics.getHeight() / 2 - player.scale*player.height/2
    player.world = wf.newWorld(0, 0)
    player.world:addCollisionClass('Player')
    player.world:addCollisionClass('Wall')
    player.world:addCollisionClass('Detector', {ignores = {'Player'}})
    player.world:addCollisionClass('Open Wall', {ignores = {'Player'}})
    player.collider = player.world:newBSGRectangleCollider(player.x, player.y, player.width*player.scale*3/4, player.height*player.scale, 3*player.scale)
    player.collider:setCollisionClass('Player')
    player.collider:setFixedRotation(true)

    player.animations = {}
    player.animations.down = anim8.newAnimation(player.grid('4-6', 1), 3/(player.scale*player.speed))
    player.animations.left = anim8.newAnimation(player.grid('4-6', 2), 3/(player.scale*player.speed))
    player.animations.right = anim8.newAnimation(player.grid('4-6', 3), 3/(player.scale*player.speed))
    player.animations.up = anim8.newAnimation(player.grid('4-6', 4), 3/(player.scale*player.speed))

    player.animation_state = player.animations.down
    player.looking = "down"
    player.isMoving = false

    return player
end

function Player:Update(dt)
    player.isMoving = false

    vx, vy = 0, 0

    if love.keyboard.isDown("right") or love.keyboard.isDown("kp6") or love.keyboard.isDown("d") then
        vx = self.speed * self.width * self.scale
        self.animation_state = self.animations.right
        player.looking = "right"
        player.isMoving = true
    end
    if love.keyboard.isDown("left") or love.keyboard.isDown("kp4") or love.keyboard.isDown("a") then
        vx = -1 * self.speed * self.width * self.scale
        self.animation_state= self.animations.left
        player.looking = "left"
        player.isMoving = true
    end
    if love.keyboard.isDown("down") or love.keyboard.isDown("kp2") or love.keyboard.isDown("s") then
        vy = self.speed * self.height * self.scale
        self.animation_state= self.animations.down
        player.looking = "down"
        player.isMoving = true
    end
    if love.keyboard.isDown("up") or love.keyboard.isDown("kp8") or love.keyboard.isDown("w") then
        vy = -1 * self.speed * self.height * self.scale
        self.animation_state= self.animations.up
        player.looking = "up"
        player.isMoving = true
    end

    self.collider:setLinearVelocity(vx,vy)

    self.x = self.collider:getX() - self.scale*self.width/2
    self.y = self.collider:getY() - self.scale*self.height/2

    if player.isMoving == false then
        self.animation_state:gotoFrame(2)
    end

    self.animation_state:update(dt)
    player.world:update(dt)
end

function Player:Draw()
    if show_debugging then
        self.world:draw()
    end
    self.animation_state:draw(self.spriteSheet, self.x, self.y, nil, self.scale)
end

return Player
