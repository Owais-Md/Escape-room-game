--new folder for progress, settings, cheats option to manually enable properties in progress?
--uses that enteredCollider/activeObject from background.lua to generate text
--self.gamedetails.progress = load(self.gamedetails.savefile) or self.gamedetails.progress

local TableIO = require "TableIO"
local stateStack = require "State Stack"
local Dialog = require "Dialog"

Game = {
    Settings = {
        
    },
    Room_data = {
        {
            name = "Room 1",
            Room_path = "Room 1",
            Door_teleport = "Room 2",
            Closed = true
        },
        {
            name = "Room 2",
            Room_path = "Room 2",
            Door_teleport = "Room 1",
            Closed = false
        }
    },
    Dialog = {
        wall = "The wall appears to be made of stone",
        wierdWall = "This wall appears to be different from the other walls",
        chest = {
            ifLocked = "The chest appears to be locked",
            ifUnlocked = "The chest is not locked, press o to open and c to close the chest"
        },
        door = {
            ifLocked = "The door appears to be locked",
            ifUnlocked = "The door is unlocked, press o to open and c to close the door"
        }
    }
}

--TableIO.dump(Game.Settings, "settings")

function Game:getGameObjects(dialogBox)
    local game = {}
    setmetatable(game, self)
    self.__index = self

    game.enteredColliders = {}
    game.activeObject = nil
    game.movingWalls = nil
    return game
end

function Game:takeInput(key)
    if self.activeObject then
        --Active Object actions
    end
    if #self.enteredColliders>0 then
        dialogBox:clearDialog()
        for _,enteredCollider in ipairs(self.enteredColliders) do
            dialogBox:pushDialog(enteredCollider.name..":"..tostring(Game.Dialog[enteredCollider.name]))
        end
    end
end

function Game:Update(enteredColliders, activeObject)
    self.enteredColliders = enteredColliders
    self.activeObject = activeObject
end

return Game