--need to add isLocked and implement inside Background.lua

local Image = love.graphics.newImage("Sprites/Lanea Zimmerman's spritesheets/things.png")
local imageWidth = Image:getWidth()
local imageHeight = Image:getHeight()
local tileWidth = 16
local tileHeight = 16

local quadsForAnimation = {
    {
        name = "door",
        cuards = { -- quad cordinates lmao
            {x = 0, y = 0},
            {x = 0, y = 1},
            {x = 0, y = 2},
            {x = 0, y = 3}
        }
    },
    {
        name = "chest",
        cuards = {
            {x = 6, y = 0},
            {x = 6, y = 1},
            {x = 6, y = 2},
            {x = 6, y = 3}
        }
    },
    {
        name = "lockingDoor",
        cuards = {
            {x = 3, y = 0},
            {x = 3, y = 1},
            {x = 3, y = 2},
            {x = 3, y = 3}
        }
    },
    {
        name = "orangeLever",
        cuards = {
            {x = 3, y = 4},
            {x = 4, y = 4},
            {x = 5, y = 4}
        }
    }
}

local Animation = {}

function Animation:NewObject(beginClosed, isLocked, flipped_horizontal, flipped_vertical, animationSpeed, name)
    local animation = {}
    setmetatable(animation, self)
    self.__index = self

    animation.tileWidth = 16
    animation.tileHeight = 16
    animation.imagePath = "Sprites/Lanea Zimmerman's spritesheets/things.png"

    animation.isClosed = beginClosed
    animation.isLocked = isLocked
    animation.flipped_horizontal = flipped_horizontal
    animation.flipped_vertical = flipped_vertical
    animation.isOpening = false
    animation.isClosing = false
    animation.animationSpeed = animationSpeed
    animation.quads = {}
    animation.frame = 0
    for _,quads in ipairs(quadsForAnimation) do
        if string.find(name, quads.name) then
            for _, cuard in ipairs(quads.cuards) do
                table.insert(animation.quads, love.graphics.newQuad(cuard.x*tileWidth, cuard.y*tileHeight, tileWidth, tileHeight, imageWidth, imageHeight))
            end
        end
    end
    if beginClosed == false then
        animation.frame = #animation.quads - 1
    end
    animation.timer = animation.frame
    animation.x_offset, animation.y_offset, animation.x_scale, animation.y_scale = 0, 0, 1, 1
    if animation.flipped_horizontal then
        animation.x_offset = 1
        animation.x_scale = -1
    end
    if animation.flipped_vertical then
        animation.y_offset = 1
        animation.y_scale = -1
    end

    return animation
end

function Animation:Open(dt)
    if self.isClosed and not self.isLocked then
        self.isOpening = true
        if self.frame ~= #self.quads - 1 then
            self.timer = self.timer + dt*self.animationSpeed
            self.frame = self.timer - self.timer % 1
        else
            self.isClosed = false
            self.isOpening = false
        end
    end
end

function Animation:Close(dt)
    if self.isClosed == false then
        self.isClosing = true
        if self.frame ~= 0 then
            self.timer = self.timer - dt*self.animationSpeed
            self.frame = self.timer - self.timer % 1
        else
            self.isClosed = true
            self.isClosing = false
        end
    end
end

return Animation