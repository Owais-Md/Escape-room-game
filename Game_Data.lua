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
    }
}

Game.Room_1.Closed = false
TableIO.dump(Game, "output")

function Game.Room_1:interact(enteredCollider)

end

return Game