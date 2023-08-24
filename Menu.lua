--has new-game, load from game, savegame, restart, choose sprites, customization?, cheats?, credits?

local MenuBox = require "Menu Box"
local ImageData = require "basictiles"
local TileSetData = require "TilesetDataGenerator"
local Buttons = require "Menu Buttons"
local Dialog  = require "Dialog"

local quads = TileSetData.quads
local imageToDrawFrom = love.graphics.newImage(ImageData.image)
local charactersImage = love.graphics.newImage("Sprites/Lanea Zimmerman's spritesheets/characters.png")

love.mouse.setPosition(200,130)
local mx, my = love.mouse.getPosition()
local mode = "mouse"
local hotButton = 1
local isDown = false

local colors = {
    default = {1, 1, 1, 1},
    fill = {0.3, 0.3, 0.5, 0.8},
    hot = {0.6, 0.8, 0.6, 1}
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
        Buttons["Neutral"]
    }
}

local function getCurrentMenu(menuStack)
    local menu = {}
    menu.menuName = menuStack[#menuStack]
    menu.margin = 20
    menu.buttons = menuList[menu.menuName]
    if menu.menuName ~= "Change Sprite" and menu.menuName ~= "Change Dialog Background" then
        menu.height = 3*smallFont:getHeight()
        menu.totalheight = menu.height*#menu.buttons + menu.margin*(#menu.buttons-1)
        for _, button in ipairs(menu.buttons) do
            button.width = smallFont:getWidth(button.text)
            button.x = 400 - button.width/2 - 2*menu.margin
            button.w = 2*(400 - button.x)
            button.y = 280 - menu.totalheight/2 + (_ - 1)*(menu.height + menu.margin)
            button.h = menu.height
            button.text_x = 400 - button.width/2
            button.text_y = button.y + menu.height/3
            button.hot = false
            if _ == 1 then
                hotButton = 1
                button.hot = true
            end
        end
    else
        menu.width = 100
        menu.height = 100
        if menu.buttons[#menu.buttons].text == "Back" then
            table.remove(menu.buttons, #menu.buttons)
        end
        menu.totalwidth = menu.width*#menu.buttons + menu.margin*(#menu.buttons-1)
        for _, button in ipairs(menu.buttons) do
            button.x = 400 - menu.totalwidth/2 + (_ - 1)*(menu.width + menu.margin)
            button.w = menu.width
            button.y = 280 - menu.height/2
            button.h = 2*(280 - button.y)
            button.image_x = button.x + menu.margin
            button.image_y = button.y + menu.margin
            button.text_x = button.x + menu.margin
            button.text_y = 280 + menu.margin
            button.hot = false
            if _ == 1 then
                hotButton = 1
                button.hot = true
            end
        end
        local Back = Buttons["Back"]
        local width = smallFont:getWidth(Back.text)
        Back.x = 400 - width/2 - 2*menu.margin
        Back.y = 280 + menu.height/2 + menu.margin
        Back.w = 2*(400 - Back.x)
        Back.h = 3*smallFont:getHeight()
        Back.text_x = Back.x + 2*menu.margin
        Back.text_y = Back.y + Back.h/3
        table.insert(menu.buttons, Back)
    end
    return menu
end

function Menu:getMenu()
    local menu = {}
    setmetatable(menu, self)
    self.__index = self
    menu.menuStack = {"startScreen"}
    menu.currentMenu = getCurrentMenu(menu.menuStack)
    menu.warningGiven = false
    menu.dialogBox = Dialog:getDialogBox()
    return menu
end

function Menu:MenuPush(menuState)
    table.insert(self.menuStack, menuState)
    self.currentMenu = getCurrentMenu(self.menuStack)
end

function Menu:getExitWarning()
    if self.warningGiven or not stateStack:StateInStack("player") then
        return true
    else
        self.warningGiven = true
        return false
    end
end

function Menu:MenuPop()
    if #self.menuStack > 0 then
        table.remove(self.menuStack, #self.menuStack)
    end
    if #self.menuStack>0 then
        self.currentMenu = getCurrentMenu(self.menuStack)
        return true
    else
        if stateStack:Top() == "menu" then
            stateStack:Pop()
            self.warningGiven = false
        end
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

function Menu:takeInput(key)
    mode = "keyboard"
    local num = #self.currentMenu.buttons
    if key == "up" or key == "w" or key == "left" or key == "a" then
        hotButton = math.max(1, hotButton - 1)
    end
    if key == "down" or key == "s" or key == "right" or key == "d" then
        hotButton = math.min(num, hotButton + 1)
    end
    local func
    for _, button in ipairs(self.currentMenu.buttons) do
        if _ == hotButton then
            button.hot = true
            func = button.func
        else
            button.hot = false
        end
    end
    if key == "return" then
        func()
    end
end

function Menu:Update(dt)
    local newmx, newmy = love.mouse.getPosition()
    if newmx~=mx or newmy ~= my then
        mode = "mouse"
    end
    mx, my = newmx, newmy
    if mx>800 then mx = 800 end
    if my>560 then my = 560 end
    if mode == "mouse" then
        if stateStack:Top() == "menu" then
            if not love.mouse.isDown(1) then
                isDown = false
            end
            for _, button in ipairs(self.currentMenu.buttons) do
                if mx>button.x and mx<button.x + button.w and my>button.y and my<button.y + button.h then
                    button.hot = true
                    hotButton = _
                    if love.mouse.isDown(1) and not isDown then
                        isDown = true
                        button.func()
                    end
                else
                    button.hot = false
                end
            end
        end
    end
end

function Menu:Draw()
    if stateStack:StateInStack("menu") then
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
        love.graphics.circle("fill", mx, my, 10)
        -- love.graphics.print(hotButton, 20, 20)
    end
end

return Menu