local Image = love.graphics.newImage("Sprites/Lanea Zimmerman's spritesheets/things.png")
local imageWidth = Image:getWdith()
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

Animation = {}

function Animation:NewAnimation(beginClosed, flipped_horizontal, flipped_vertical, Animationspeed, name)
    Animation.closed = beginClosed
    Animation.mid_animation = false
    Animation.flipped_horizontal = flipped_horizontal
    Animation.flipped_vertical = flipped_vertical
    Animation.Animationspeed = Animationspeed
    Animation.quads = {}
    Animation.frame = 0
    if Animation.closed == false then
        Animation.frame = #Animation.quads - 1
    end
    Animation.timer = 0
    for _,quads in quadsForAnimation do
        if quads.name == name then
            for _, cuard in ipairs(quads.cuards) do
                table.insert(Animation.quads, love.graphics.newQuad(cuard.x*tileWidth, cuard.y*tileHeight, tileWidth, tileHeight, imageWidth, imageHeight))
            end
        end
    end
    Animation.x_offset, Animation.y_offset, Animation.x_scale, Animation.y_scale = 0, 0, 1, 1
    if Animation.flipped_horizontal ~= 0 then
        Animation.x_offset = 1
        Animation.x_scale = -1
    end
    if Animation.flipped_vertical ~= 0 then
        Animation.y_offset = 1
        Animation.y_scale = -1
    end
end

function Animation:Open(dt)
    if self.closed then
        if self.frame ~= 3 then
            self.timer = self.timer + dt*self.Animationspeed
            self.frame = (self.timer + 1) % #self.quads
        else
            self.closed = false
        end
    end
end

function Animation:Close(dt)
    if self.closed then
        if self.frame ~= 3 then
            self.timer = self.timer + dt*Animationspeed
            self.frame = (self.timer + 1) % #self.quads
        else
            self.closed = false
        end
    end
end

function Animation:Draw(image, x, y)
    love.graphics.draw(
        Image,
        self.quads[self.frame + 1],
        (x + self.x_offset)*self.map.tilewidth,
        (y + self.y_offset)*self.map.tileheight,
        0,
        self.x_scale,
        self.y_scale
    )
end

return Animation