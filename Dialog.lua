--uses that dialogBox.lua
--uses that enteredCollider/activeObject from background.lua to generate text
--uses those fonts from LaenaZimmerman's spriteSheets
Game = require "Game_Data"

dialog = {}

function dialog.PrintDialog(text)

end

function dialog.findDialog(enteredCollider, interactableObject)
    if love.keyboard.isDown("x") then
        if interactableObject then

        elseif enteredCollider then
            
        else
            
        end
    end
end
