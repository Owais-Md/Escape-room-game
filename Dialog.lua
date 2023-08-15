--uses that dialogBox.lua
--uses those fonts from LaenaZimmerman's spriteSheets

Game = require "Game_Data"
DialogBox = require "Dialog Box"
ImageData = require "basictiles"
TileSetData = require "TilesetDataGenerator"

imageToDrawFrom = love.graphics.newImage(ImageData.image)
quads = TileSetData.quads
scale = 5

function PrintDialog()
    love.graphics.push()
    love.graphics.scale(scale)
    text = "The chest is not locked, press o to open and c to close the chest"
    width = DialogBox.width
    height = DialogBox.height
    tilewidth = DialogBox.tilewidth
    tileheight = DialogBox.tileheight
    for _, layer in ipairs(DialogBox.layers) do
        for y = 0, layer.height - 1 do
            for x = 0, layer.width - 1 do
                local index = (x + y * layer.width) + 1
                local tid = layer.data[index]
                if tid ~= 0 then
                    local quad = quads[tid] -- did not make the quads yet.. ouch
                    love.graphics.draw(
                        imageToDrawFrom,
                        quad,
                        x*tilewidth,
                        y*tileheight
                    )
                end
            end
        end
    end
    love.graphics.pop()
    local font = love.graphics.newFont(30)
    love.graphics.setFont(font)
    love.graphics.print(text, tilewidth*scale, 4.2*tileheight*scale)
end

return PrintDialog