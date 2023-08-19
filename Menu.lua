--has new-game, load from game, savegame, restart, choose sprites, customization?, cheats?, credits?

local MenuBox = require "Menu Box"

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

function Menu:getMenu()
    local menu = {}
    setmetatable(menu, self)
    self.__index = self
    menu.state = "startScreen"
    menu.currentMenu = {}
    menu.startScreen = {
        Buttons["New Game"],
        Button["Load From Saved Game"],
        Button["Settings"],
        Button["Credits"],
        Button["Exit"]
    }
    menu.midGame = {
        Button["Save Game"],
        Button["Settings"],
        Button["Credits"],
        Button["Exit"]
    }
    menu.Settings = {
        Button["Change Sprite"],
        Button["Change Dialog Background"]
    }
    menu["Change Sprite"] = {
        Button["Boy"],
        Button["Girl"],
        Button["Skeleton"],
        Button["Player 1"]
    }
end

function Menu:PrintPopup()

end

function Menu:Update(dt)
    
end

function Menu:Draw()

end