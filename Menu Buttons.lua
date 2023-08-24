local function textButton(text, func)
    return {
        type = "text",
        text = text,
        func = func
    }
end

local function imageButton(image, quads, func)
    return{
        type = "image",
        image = image,
        quads = quads,
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
    ["New Game"] = textButton("New Game",
                    function ()
                        menu:MenuPop()
                        stateStack:Push("background", "player") --, "tutorial") -- need to make a tutorial
                        menu:MenuPush("midGame")
                    end
                )
    ,
    ["Settings"] = textButton("Settings",
                    function ()
                        menu:MenuPush("Settings") -- need to make settings..
                    end
                )
    ,
    ["Save Game"] = textButton("Save Game",
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
    ["Load From Saved Game"] = textButton("Load From Saved Game",
                    function ()
                        menu:MenuPop()
                        gameObjects:loadGame("progress.save")
                        stateStack:Push("background", "player")
                        menu:MenuPush("midGame")
                    end
                )
    ,
    ["Change Sprite"] = textButton("Change Sprite",
                    function ()
                        -- text = {
                        --     "Wait for future updates :) !!"
                        -- }
                        -- pushDialoginMenu(text)
                        menu:MenuPush("Change Sprite")
                    end
                )
    ,
    ["Change Dialog Background"] = textButton("Change Dialog Background",
                    function ()
                        text = {
                            "Wait for future updates :) !!"
                        }
                        pushDialoginMenu(text)
                    end
                )
    ,
    ["Credits"] = textButton("Credits",
                    function ()
                        creditsText = {
                            "Spritesheets: By Laena Zimmerman, from https://opengameart.org/content/ tiny-16-basic under the creative commons license CC BY 3.0."
                        }
                        pushDialoginMenu(creditsText)
                    end
                )
    ,
    ["Back"] = textButton("Back",
                    function ()
                        menu:MenuPop()
                    end
                )
    ,
    ["Boy"] = textButton("Boy",
                    function ()
                        menu:MenuPop()
                    end
                )
    ,
    ["Girl"] = textButton("Girl",
                    function ()
                        menu:MenuPop()
                    end
                )
    ,
    ["Skeleton"] = textButton("Skeleton",
                    function ()
                        menu:MenuPop()
                    end
                )
    ,
    ["Neutral"] = textButton("Neutral",
                    function ()
                        menu:MenuPop()
                    end
                )
    ,
    ["Exit"] = textButton("Exit",
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