--new folder for progress, settings, cheats option to manually enable properties in progress?
--uses that enteredCollider/activeObject from background.lua to generate text
--self.gamedetails.progress = load(self.gamedetails.savefile) or self.gamedetails.progress

local TableIO = require "TableIO"

local Game = {
    Progress = {
        roomName = "Room_1"
    },
    Settings = {
        
    },
    Room_data = {
        Room_1 = {
            Room_path = "Room 1",
            Door_teleport = "Room 2",
            Closed = true
        },
        Room_2 = {
            name = "Room 2",
            Room_path = "Room 2",
            Door_teleport = "Room 1",
            Closed = false
        }
    },
    Dialog = {
        wall = "The wall appears to be made of stone.",
        wierdWall = "This wall appears to be different from the other walls.",
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
    if key == "x" then
        if stateStack:Top() == "player" then
            stateStack:Push("dialogBox")
        elseif stateStack:Top() == "dialogBox" then
            stateStack:Pop()
        end
    end
    if stateStack:Top() == "dialogBox" then
        dialogBox:UpdateLine(key)
    end
    dialogBox:clearDialog()
    if self.activeObject then
        --Active Object actions
    end
    if self.enteredCollider then
        local text = tostring(Game.Dialog[self.enteredCollider.name])
        if text == "nil" then
            text = Game:getProgressText()
        end
        dialogBox:pushDialog(text)
    end
end

function Game:Update(enteredCollider, activeObject)
    self.enteredCollider = enteredCollider
    self.activeObject = activeObject
end

return Game