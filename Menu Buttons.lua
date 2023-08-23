local function newButton(text, func)
    return {
        text = text,
        func = func
    }
end

local function pushDialoginMenu(textTable)
    stateStack:Push("menuDialogBox")
    menu.dialogBox:clearDialog()
    table.insert(textTable, 'Press "Enter" to continue')
    for _, line in ipairs(textTable) do
        menu.dialogBox:pushDialog(line)
    end
end

local Buttons = {
    ["New Game"] = newButton("New Game",
                    function ()
                        menu:MenuPop()
                        stateStack:Push("background", "player") --, "tutorial") -- need to make a tutorial
                        menu:MenuPush("midGame")
                    end
                )
    ,
    ["Settings"] = newButton("Settings",
                    function ()
                        menu:MenuPush("Settings") -- need to make settings..
                    end
                )
    ,
    ["Save Game"] = newButton("Save Game",
                    function ()
                        gameObjects:saveGame("progress.save")
                        menu:getExitWarning()
                        local saveGameText = {
                            "Game has been saved."
                        }
                        pushDialoginMenu(saveGameText)
                    end
                )
    ,
    ["Load From Saved Game"] = newButton("Load From Saved Game",
                    function ()
                        menu:MenuPop()
                        gameObjects:loadGame("progress.save")
                        stateStack:Push("background", "player")
                        menu:MenuPush("midGame")
                    end
                )
    ,
    ["Change Sprite"] = newButton("Change Sprite",
                    function ()
                        text = {
                            "Wait for future updates :) !!"
                        }
                        pushDialoginMenu(text)
                    end
                )
    ,
    ["Change Dialog Background"] = newButton("Change Dialog Background",
                    function ()
                        text = {
                            "Wait for future updates :) !!"
                        }
                        pushDialoginMenu(text)
                    end
                )
    ,
    ["Credits"] = newButton("Credits",
                    function ()
                        creditsText = {
                            "Spritesheets: By Laena Zimmerman, from https://opengameart.org/content/ tiny-16-basic under the creative commons license CC BY 3.0."
                        }
                        pushDialoginMenu(creditsText)
                    end
                )
    ,
    ["Back"] = newButton("Back",
                    function ()
                        menu:MenuPop()
                    end
                )
    ,
    ["Exit"] = newButton("Exit",
                    function ()
                        if not menu:getExitWarning() then
                            local exitWarningText = {
                                "Make sure to save your game before you exit."
                            }
                            pushDialoginMenu(exitWarningText)
                        else
                            love.event.quit(0)
                        end
                    end
                )
}

return Buttons