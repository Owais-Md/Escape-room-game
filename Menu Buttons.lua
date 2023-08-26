local function textButton(text, func)
    return {
        type = "text",
        text = text,
        func = func
    }
end

local function imageButton(image, name, func)
    return{
        type = "image",
        image = image,
        name = name,
        func = func
    }
end

local function pushDialoginMenu(text)
    stateStack:Push("menuDialogBox")
    menu.dialogBox:clearDialog()
    menu.dialogBox:pushDialog(text..'\nPress "Enter" to continue')
end

local Buttons = {
    ["New Game"] = textButton(
                    "New Game",
                    function ()
                        menu:MenuPop()
                        menu:MenuPush("midGame")
                        stateStack:Push("background", "player", "tutorial")
                        dialogBox:pushDialog([[
                            Player: you can use arrow keys or WASD to move the player around.
                            Menu: opened and closed with escape key, navigation with mouse or arrow keys or WASD, selection with Enter key or mouseclick.
                            You can change your sprite from Menu->Settings.
                            DialogBox: Navigated using the arrow keys. exits with "x" or Enter key.
                            You can go up to an object and press "x" or "Enter" to inspect the object, which will open a dialog box.
                            The objective of this game is to exit this house? building? or whatever this is..
                            This tutorial will pop-up everytime you start a new game.
                            You can press "escape" to exit this tutorial.
                        ]])
                    end
                )
    ,
    ["Settings"] = textButton(
                    "Settings",
                    function ()
                        menu:MenuPush("Settings")
                    end
                )
    ,
    ["Save Game"] = textButton(
                    "Save Game",
                    function ()
                        gameObjects:saveGame("progress.save")
                        menu:getExitWarning()
                        pushDialoginMenu("Game has been saved.")
                    end
                )
    ,
    ["Load From Saved Game"] = textButton(
                    "Load From Saved Game",
                    function ()
                        if not gameObjects:loadGame("progress.save") then
                            pushDialoginMenu("No save file found.")
                        else
                            menu:MenuPop()
                            stateStack:Push("background", "player")
                            menu:MenuPush("midGame")
                        end
                    end
                )
    ,
    ["Change Sprite"] = textButton(
                    "Change Sprite",
                    function ()
                        menu:MenuPush("Change Sprite")
                    end
                )

    ,
    ["Credits"] = textButton(
                    "Credits",
                    function ()
                        pushDialoginMenu([[
                            Spritesheets:
                            By Laena Zimmerman, from https://opengameart.org/content/ tiny-16-basic under the creative commons license CC BY 3.0.
                        ]])
                    end
                )
    ,
    ["Back"] = textButton(
                    "Back",
                    function ()
                        menu:MenuPop()
                    end
                )
    ,
    ["Boy"] = imageButton(
                "characters",
                "Boy",
                    function ()
                        player:SpriteChange("Boy")
                        while menu:MenuPop() do end
                    end
                )
    ,
    ["Girl"] = imageButton(
                "characters",
                "Girl",
                    function ()
                        player:SpriteChange("Girl")
                        while menu:MenuPop() do end
                    end
                )
    ,
    ["Skeleton"] = imageButton(
                "characters",
                "Skeleton",
                    function ()
                        player:SpriteChange("Skeleton")
                        while menu:MenuPop() do end
                    end
                )
    ,
    ["Neutral"] = imageButton(
                "characters",
                "Neutral",
                    function ()
                        player:SpriteChange("Neutral")
                        while menu:MenuPop() do end
                    end
                )
    ,
    ["Exit"] = textButton(
                    "Exit",
                    function ()
                        if not menu:getExitWarning() then
                            pushDialoginMenu("Make sure to save your game before you exit.")
                        else
                            love.event.quit(0)
                        end
                    end
                )
}

return Buttons