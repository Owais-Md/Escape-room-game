local function newButton(text, func)
    return {
        text = text,
        func = func
    }
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
                        dialogBox:clearDialog()
                        gameObjects:saveGame("progress.save")
                        dialogBox:pushDialog("Game has been saved.")
                        dialogBox:pushDialog('Press "Enter" to continue')
                        stateStack:Push("dialogBox")
                        dialogBox.dialogPopped = false
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
                        
                    end
                )
    ,
    ["Change Dialog Background"] = newButton("Change Dialog Background",
                    function ()
                        
                    end
                )
    ,
    ["Credits"] = newButton("Credits",
                    function ()
                        -- need to make credits
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
                            dialogBox:clearDialog()
                            dialogBox:pushDialog("Make sure to save your game before you exit.")
                            dialogBox:pushDialog('Press "Enter" to continue')
                            stateStack:Push("dialogBox")
                            dialogBox.dialogPopped = false
                        else
                            love.event.quit(0)
                        end
                    end
                )
}

return Buttons