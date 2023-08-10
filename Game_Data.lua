local TableIO = require "TableIO"

Game = {
    Room_1 = {
        Room_path = "Room 1",
        Door = "closed",
        Door_teleport = "Room 2",
        Closed = true
    },
    Room_2 = {
        Room_path = "Room 2",
        Door = "closed",
        Door_teleport = "Room 1",
        Closed = false
    }
}

Game.Room_1.Closed = false
TableIO.dump(Game, "output")

function Game.Room_1:interact(enteredCollider)

end

return Game