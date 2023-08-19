--has new-game, load from game, savegame, restart, choose sprites, customization?, cheats?, credits?

local MenuBox = require "Menu Box"
local ImageData = require "basictiles"
local TileSetData = require "TilesetDataGenerator"

local quads = TileSetData.quads
local imageToDrawFrom = love.graphics.newImage(ImageData.image)

local Menu = {}

local function newButton(text, func)
    return {
        text = text,
        func = func
    }
end

local Buttons = {
    ["New Game"] = newButton("New Game",
                    function ()
                        stateStack:Pop()
                        stateStack:Push("background", "player") --, "tutorial") -- need to make a tutorial
                    end
                )
    ,
    ["Settings"] = newButton("Settings",
                    function ()
                        stateStack:Push("settings") -- need to make settings..
                    end
                )
    ,
    ["Load From Saved Game"] = newButton("Load From Saved Game",
                    function ()
                        -- call loadGame from GameData
                        stateStack:Push("background", "player")
                    end
                )
    ,
    ["Save Game"] = newButton("Save Game",
                    function ()
                        -- call saveGame from GameData
                    end
                )
    ,
    ["Credits"] = newButton("Credits",
                    function ()
                        -- need to make credits
                    end
                )
    ,
    ["Exit"] = newButton("Exit",
                    function ()
                        love.event.quit(0)
                    end
                )
}

local menuList = {
    startScreen = {
        Buttons["New Game"],
        Buttons["Load From Saved Game"],
        Buttons["Settings"],
        Buttons["Credits"],
        Buttons["Exit"]
    },
    midGame = {
        Buttons["Save Game"],
        Buttons["Settings"],
        Buttons["Credits"],
        Buttons["Exit"]
    },
    Settings = {
        Buttons["Change Sprite"],
        Buttons["Change Dialog Background"]
    },
    ["Change Sprite"] = {
        Buttons["Boy"],
        Buttons["Girl"],
        Buttons["Skeleton"]
    }
}

local function CreateMenu(menuStack)

end

function Menu:getMenu()
    local menu = {}
    setmetatable(menu, self)
    self.__index = self
    menu.menuStack = {"startScreen","randommenu"}
    menu.currentMenu = CreateMenu()
    return menu
end

function Menu:PrintPopup(text)

end

function Menu:MenuPush(menuState)
    table.insert(self.menuStack, menuState)
end

function Menu:MenuPop()
    if #self.menuStack > 0 then
        table.remove(self.menuStack, #self.menuStack)
    end
    if #self.menuStack>0 then
        return true
    else
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

function Menu:Update(dt)
    
end

function Menu:Draw()
    if stateStack:Top() == "menu" then
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
        love.graphics.setColor(0.3,0.3,0.5,1)
        love.graphics.rectangle("fill", 300, 200, 200, 100)
        love.graphics.setColor(1,1,1,1)
    end
end

return Menu