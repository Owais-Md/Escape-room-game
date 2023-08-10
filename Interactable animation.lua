local Image = love.graphics.newImage("Sprites/Lanea Zimmerman's spritesheets/things.png")
local imageWidth = Image:getWidth()
local imageHeight = Image:getHeight()
local tileWidth = 16
local tileHeight = 16

local quadsForAnimation = {
    {
        name = "Door",
        cuards = { -- quad cordinates lmao
            {x = 0, y = 0},
            {x = 0, y = 1},
            {x = 0, y = 2},
            {x = 0, y = 3}
        }
    },
    {
        name = "Chest",
        cuards = {
            {x = 6, y = 0},
            {x = 6, y = 1},
            {x = 6, y = 2},
            {x = 6, y = 3}
        }
    }
}

local Animation = {}

function Animation:NewObject(beginClosed, flipped_horizontal, flipped_vertical, Animationspeed, name)
    local animation = {}
    setmetatable(animation, self)
    self.__index = self

    animation.tileWidth = 16
    animation.tileHeight = 16
    animation.imagePath = "Sprites/Lanea Zimmerman's spritesheets/things.png"

    animation.closed = beginClosed
    animation.mid_animation = false
    animation.flipped_horizontal = flipped_horizontal
    animation.flipped_vertical = flipped_vertical
    animation.Animationspeed = animationspeed
    animation.quads = {}
    animation.frame = 0
    if animation.closed == false then
        animation.frame = #animation.quads - 1
    end
    animation.timer = 0
    for _,quads in ipairs(quadsForAnimation) do
        if quads.name == name then
            for _, cuard in ipairs(quads.cuards) do
                table.insert(animation.quads, love.graphics.newQuad(cuard.x*tileWidth, cuard.y*tileHeight, tileWidth, tileHeight, imageWidth, imageHeight))
            end
        end
    end
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
    if self.closed then
        self.mid_animation = true
        if self.frame ~= 3 then
            self.timer = self.timer + dt*self.Animationspeed
            self.frame = (self.timer + 1) % #self.quads
        else
            self.closed = false
            self.mid_animation = false
        end
    end
end

function Animation:Close(dt)
    if self.closed == false then
        self.mid_animation = false
        if self.frame ~= 0 then
            self.timer = self.timer - dt*Animationspeed
            self.frame = (self.timer + 1) % #self.quads
        else
            self.closed = true
            self.mid_animation = true
        end
    end
end

return Animation