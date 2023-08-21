--has new-game, load from game, savegame, restart, choose sprites, customization?, cheats?, credits?

local MenuBox = require "Menu Box"
local ImageData = require "basictiles"
local TileSetData = require "TilesetDataGenerator"
local Buttons = require "Menu Buttons"

local quads = TileSetData.quads
local imageToDrawFrom = love.graphics.newImage(ImageData.image)

local mx, my = love.mouse.getPosition()
local isDown = false

local colors = {
    default = {1, 1, 1, 1},
    fill = {0.3, 0.3, 0.5, 0.8},
    hot = {0.7, 0.8, 0.6, 1}
}

local Menu = {}

local menuList = {
    startScreen = {
        Buttons["New Game"],
        Buttons["Load From Saved Game"],
        Buttons["Credits"],
        Buttons["Exit"]
    },
    midGame = {
        Buttons["Save Game"],
        Buttons["Settings"],
        Buttons["Credits"],
        Buttons["Back"],
        Buttons["Exit"]
    },
    Settings = {
        Buttons["Change Sprite"],
        Buttons["Change Dialog Background"],
        Buttons["Back"]
    },
    ["Change Sprite"] = {
        Buttons["Boy"],
        Buttons["Girl"],
        Buttons["Skeleton"],
        Buttons["Back"]
    }
}

local function getCurrentMenu(menuStack)
    local menu = {}
    menu.buttons = menuList[menuStack[#menuStack]]
    menu.margin = 20
    for _, button in ipairs(menu.buttons) do
        button.width = smallFont:getWidth(button.text)
        if not menu.height then
            menu.height = 3*smallFont:getHeight()
            menu.totalheight = menu.height*#menu.buttons + menu.margin*(#menu.buttons-1)
        end
        button.x = 400 - button.width/2 - 2*menu.margin
        button.w = 2*(400 - button.x)
        button.y = 280 - menu.totalheight/2 + (_ - 1)*(menu.height + menu.margin)
        button.h = menu.height
        button.text_x = 400 - button.width/2
        button.text_y = button.y + menu.height/3
        button.hot = false
    end
    return menu
end

function Menu:getMenu()
    local menu = {}
    setmetatable(menu, self)
    self.__index = self
    menu.menuStack = {"startScreen"}
    menu.currentMenu = getCurrentMenu(menu.menuStack)
    return menu
end

function Menu:PrintPopup(text)

end

function Menu:MenuPush(menuState)
    table.insert(self.menuStack, menuState)
    self.currentMenu = getCurrentMenu(self.menuStack)
end

function Menu:MenuPop()
    if #self.menuStack > 0 then
        table.remove(self.menuStack, #self.menuStack)
    end
    if #self.menuStack>0 then
        self.currentMenu = getCurrentMenu(self.menuStack)
        return true
    else
        stateStack:Pop()
        return false
    end
end

function Menu:MenuEmpty()
    if #self.menuStack == 0 then
        return true
    else
        return false
    end
end

function Menu:MenuTop()
    if not menu:MenuEmpty() then
        return self.menuStack[#self.menuStack]
    else
        return "nil"
    end
end

function Menu:Update(dt)
    mx, my = love.mouse.getPosition()
    if not love.mouse.isDown(1) then
        isDown = false
    end
    for _, button in ipairs(self.currentMenu.buttons) do
        if mx>button.x and mx<button.x + button.w and my>button.y and my<button.y + button.h then
            button.hot = true
            if love.mouse.isDown(1) and not isDown then
                isDown = true
                button.func()
            end
        else
            button.hot = false
        end
    end
end

function Menu:Draw()
    if stateStack:Top() == "menu" then
        love.graphics.setFont(smallFont)
        love.graphics.setColor(1,1,1,0.8)
        love.graphics.push()
        love.graphics.scale(5)
        width = MenuBox.width
        height = MenuBox.height
        tilewidth = MenuBox.tilewidth
        tileheight = MenuBox.tileheight
        for _, layer in ipairs(MenuBox.layers) do
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
        love.graphics.pop()
        for _, button in ipairs(self.currentMenu.buttons) do
            love.graphics.setColor(unpack(colors.fill))
            if button.hot then love.graphics.setColor(unpack(colors.hot)) end
            love.graphics.rectangle("fill", button.x, button.y, button.w, button.h)
            love.graphics.setColor(unpack(colors.default))
            love.graphics.rectangle("line", button.x, button.y, button.w, button.h)
            love.graphics.print(button.text, button.text_x, button.text_y)
        end
        love.graphics.circle("fill", mx, my, menu.currentMenu.margin/2)
    end
end

return Menu