--new folder for progress, settings, cheats option to manually enable properties in progress?
--self.gamedetails.progress = self.gamedetails.progress or load(self.gamedetails.savefile)

local TableIO = require "TableIO"

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
        Wall = "The wall appears to be made of stone",
        WierdWall = "This wall appears to be different from the other walls",
        Chest = {
            ifLocked = "The chest appears to be locked",
            ifUnlocked = "The chest is not locked, press o to open and c to close the chest"
        }
    }
}

Game.Room_1.Closed = false
TableIO.dump(Game.Settings, "settings")

function Game.Room_1:interact(enteredCollider)

end

return Game