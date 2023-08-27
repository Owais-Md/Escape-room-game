--need to add selectable sprites
--add that torch highlight thing
--need to change player.x and player.y on the basis of teleport

local anim8 = require 'libraries.anim8' --Could've done it without this library too, but had imported this when just started the project, so now can't remove
local wf = require "libraries.windfield" --FOSS library for game physics

local spriteSheet = love.graphics.newImage("Sprites/Lanea Zimmerman's spritesheets/characters.png")
local grid = anim8.newGrid(16, 16, spriteSheet:getWidth(), spriteSheet:getHeight())

local animations = {
    ["Boy"] = {
        down = anim8.newAnimation(grid('4-6', 1), {0.2, 0.1, 0.2}),
        left = anim8.newAnimation(grid('4-6', 2), {0.2, 0.1, 0.2}),
        right = anim8.newAnimation(grid('4-6', 3), {0.2, 0.1, 0.2}),
        up = anim8.newAnimation(grid('4-6', 4), {0.2, 0.1, 0.2})
    },
    ["Girl"] = {
        down = anim8.newAnimation(grid('7-9', 1), {0.2, 0.1, 0.2}),
        left = anim8.newAnimation(grid('7-9', 2), {0.2, 0.1, 0.2}),
        right = anim8.newAnimation(grid('7-9', 3), {0.2, 0.1, 0.2}),
        up = anim8.newAnimation(grid('7-9', 4), {0.2, 0.1, 0.2})
    },
    ["Skeleton"] = {
        down = anim8.newAnimation(grid('10-12', 1), {0.2, 0.1, 0.2}),
        left = anim8.newAnimation(grid('10-12', 2), {0.2, 0.1, 0.2}),
        right = anim8.newAnimation(grid('10-12', 3), {0.2, 0.1, 0.2}),
        up = anim8.newAnimation(grid('10-12', 4), {0.2, 0.1, 0.2})
    },
    ["Neutral"] = {
        down = anim8.newAnimation(grid('1-3', 1), {0.2, 0.1, 0.2}),
        left = anim8.newAnimation(grid('1-3', 2), {0.2, 0.1, 0.2}),
        right = anim8.newAnimation(grid('1-3', 3), {0.2, 0.1, 0.2}),
        up = anim8.newAnimation(grid('1-3', 4), {0.2, 0.1, 0.2})
    }
}

local Player = {}

function Player:New()
    local player = {}
    setmetatable(player, self)
    self.__index = self
    
    player.width = 16
    player.height = 16
    player.scale = 5
    player.speed = 3*player.scale/4
    player.x = gameObjects.Progress.player.x or (love.graphics.getWidth() / 2 - player.scale*player.width/2)
    player.y = gameObjects.Progress.player.y or (love.graphics.getHeight() / 2 - player.scale*player.height/2)
    player.world = wf.newWorld(0, 0)
    player.world:addCollisionClass('Player')
    player.world:addCollisionClass('Wall')
    player.world:addCollisionClass('Detector', {ignores = {'Player'}})
    player.world:addCollisionClass('Open Wall', {ignores = {'Player'}})
    player.collider = player.world:newBSGRectangleCollider(player.x, player.y, player.width*player.scale*3/4, player.height*player.scale, 3*player.scale)
    player.collider:setCollisionClass('Player')
    player.collider:setFixedRotation(true)

    player.character = gameObjects.Progress.player.character or "Boy"

    player.animations = animations[player.character]

    player.animation_state = player.animations[gameObjects.Progress.player.looking] or player.animations.down
    player.looking = "down"
    player.isMoving = false

    return player
end

function Player:SpriteChange(character)
    gameObjects.Progress.player.character = character
    self.character = character
    self.animations = animations[character]
    self.animation_state = self.animations[self.looking]
end

function Player:Update(dt)
    self.isMoving = false
    vx, vy = 0, 0

    if stateStack:Top() == "player" then
        if love.keyboard.isDown("right") or love.keyboard.isDown("kp6") or love.keyboard.isDown("d") then
            vx = self.speed * self.width * self.scale
            self.animation_state = self.animations.right
            self.looking = "right"
            self.isMoving = true
        elseif love.keyboard.isDown("left") or love.keyboard.isDown("kp4") or love.keyboard.isDown("a") then
            vx = -1 * self.speed * self.width * self.scale
            self.animation_state= self.animations.left
            self.looking = "left"
            self.isMoving = true
        elseif love.keyboard.isDown("down") or love.keyboard.isDown("kp2") or love.keyboard.isDown("s") then
            vy = self.speed * self.height * self.scale
            self.animation_state= self.animations.down
            self.looking = "down"
            self.isMoving = true
        elseif love.keyboard.isDown("up") or love.keyboard.isDown("kp8") or love.keyboard.isDown("w") then
            vy = -1 * self.speed * self.height * self.scale
            self.animation_state= self.animations.up
            self.looking = "up"
            self.isMoving = true
        end

    end
    self.collider:setLinearVelocity(vx,vy)

    self.x = self.collider:getX() - self.scale*self.width/2
    self.y = self.collider:getY() - self.scale*self.height/2

    if self.isMoving == false then
        self.animation_state:gotoFrame(2)
    end

    self.animation_state:update(dt)
    self.world:update(dt)
end

function Player:Draw()
    if stateStack:StateInStack("player") then
        if show_debugging then
            self.world:draw()
        end
        self.animation_state:draw(spriteSheet, self.x, self.y, nil, self.scale)
    end
end

return Player