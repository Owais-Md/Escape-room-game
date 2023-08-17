--new folder for progress, settings, cheats option to manually enable properties in progress?
--uses that enteredCollider/activeObject from background.lua to generate text
--self.gamedetails.progress = load(self.gamedetails.savefile) or self.gamedetails.progress

local TableIO = require "TableIO"

local Game = {
    Progress = {
        currentRoomName = "Room_1",
        interactableObjects = {
            Room_1 = {
                chest = {
                    beginClosed = true,
                    flipped_horizontal = false,
                    flipped_vertical = false,
                    isLocked = false
                },
                door = {
                    beginClosed = true,
                    flipped_horizontal = false,
                    flipped_vertical = false,
                    isLocked = false
                },
                wierdWall = {
                    beginClosed = true,
                    isLocked = true,
                    dialog = "This wall appears to be different from the other walls.",
                }
            },
            Room_2 = {

            }
        }
    },
    Settings = {
        
    },
    Dialog = {
        wall = "The wall appears to be made of stone.",
        chestLocked = "The chest appears to be locked.",
        chestUnlocked = "The chest is not locked, press o to open and c to close the chest.",
        doorLocked = "The door appears to be locked.",
        doorUnlocked = "The door is unlocked, press o to open and c to close the door.",
        torch = "The torch is bright and warm.",
        fireplace = "The fireplace makes the room feel cozy. If not for this fireplace, the room would probably be pretty cold."
    }
}

--TableIO.dump(Game.Settings, "settings")

function Game:saveGame(savefilename)

end

function Game:loadGame(savefilename)

end

function Game:getGameObjects()
    local game = {}
    setmetatable(game, self)
    self.__index = self

    game.enteredCollider = nil
    game.activeObject = nil
    game.movingWalls = nil
    return game
end

function Game:getProgressText()
    -- if self.enteredCollider.name == "chest" then
        
    -- else
        return "Gotta Enter Correct Text"
--     end
end

function Game:takeInput(key)
    dialogBox:clearDialog() -- add some form of condition to clearing dialog so that extra text can be pushed inside the dialog box for instruction?
    if self.activeObject then -- need to handle gameObject (interactable objects') functions from here
        --Active Object actions
    end
    if self.enteredCollider then
        local text = tostring(Game.Dialog[self.enteredCollider.name])
        if text == "nil" then
            text = Game:getProgressText()
        end
    end
    dialogBox:pushDialog(text)
    if key == "x" then
        if stateStack:Top() == "player" and #dialogBox.textTable > 0 then
            stateStack:Push("dialogBox")
        elseif stateStack:Top() == "dialogBox" then
            stateStack:Pop()
        end
    end
    if stateStack:Top() == "dialogBox" then
        dialogBox:UpdateLine(key)
    end
end

function Game:Update(enteredCollider, activeObject)
    self.enteredCollider = enteredCollider
    self.activeObject = activeObject
end

return Game