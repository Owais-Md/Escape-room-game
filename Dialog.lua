--uses that dialogBox.lua
--uses those fonts from LaenaZimmerman's spriteSheets
--need to make dialog:load(inventory) [and also need to make an inventory] [prints inventory inside dialogBox itself? or should i make another pop-up/ state for inventory?]

local DialogBox = require "Dialog Box"
local ImageData = require "basictiles"
local TileSetData = require "TilesetDataGenerator"

local imageToDrawFrom = love.graphics.newImage(ImageData.image)
local quads = TileSetData.quads
local font = love.graphics.newFont(32)
local letterlimit = 32

love.graphics.setFont(font)

local scale = 5
local dialog = {}

function dialog:getDialogBox()
    local object = {}
    setmetatable(object, self)
    self.__index = self
    object.text = ""
    object.textTable = {}
    object.currentLine = 1
    return object
end

function dialog:UpdateLine(key)
    if key == "down" and #self.textTable>2 then
        self.currentLine = math.min(self.currentLine + 1, #self.textTable - 1)
    elseif love.keyboard.isDown("up") then
        self.currentLine = math.max(self.currentLine - 1, 1)
    elseif key == "x" then
        self.currentLine = 1
    end
end


function dialog:load(inventory)
    --need to make an inventory table too
end

function dialog:pushDialog(text)
    self.text = text or "nil"
    counter = 0
    newline = ""
    for word in self.text:gmatch("%S+") do
        if #word + counter < letterlimit then
            if newline == "" then
                newline = word
            else
                newline = newline .." ".. word
            end
            counter = counter + #word
        else
            counter = #word
            table.insert(self.textTable, newline)
            newline = word
        end
    end
    if counter ~= 0 then
        table.insert(self.textTable, newline)
    end
end

function dialog:clearDialog()
    self.text = ""
    self.textTable = {}
end

function dialog:PrintDialog()
    love.graphics.push()
    love.graphics.scale(scale)
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
                    local quad = quads[tid]
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
    if self.currentLine < #self.textTable - 1 then
        love.graphics.polygon("fill", {8.6*tilewidth, 5.8*tilewidth, 8.7*tilewidth , 5.9*tilewidth, 8.8*tilewidth, 5.8*tilewidth})
    end
    if self.currentLine > 1 then
        love.graphics.polygon("fill", {8.6*tilewidth, 4.2*tilewidth, 8.7*tilewidth , 4.1*tilewidth, 8.8*tilewidth, 4.2*tilewidth})
    end
    love.graphics.pop()
    if #self.textTable > 0 then
        love.graphics.print(self.textTable[self.currentLine], 1.2*tilewidth*scale, 4.3*tileheight*scale)
    end
    if self.currentLine < #self.textTable then
        love.graphics.print(self.textTable[self.currentLine+1], 1.2*tilewidth*scale, 5.05*tileheight*scale)
    end
end

return dialog