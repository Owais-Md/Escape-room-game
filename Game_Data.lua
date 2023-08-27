--new folder for progress, settings, cheats option to manually enable properties in progress?
--uses that enteredCollider/activeObject from background.lua to generate text
--need to make getProgressText better so that i can show locked objects better [dialogBox]
--also need to add switches inside the game, so that game isn't bland lmao
--need to make an inventory too

love.graphics.setDefaultFilter("nearest","nearest")
love.mouse.setVisible(false)
bigFont = love.graphics.newFont(30)
smallFont = love.graphics.newFont(16)

local TableIO = require "TableIO"
local Player = require "Player"
local Background = require "Background"

ww = love.graphics.getWidth()
wh = love.graphics.getHeight()
scale = math.min(ww/800, wh/560)
wtranslate = {(ww-800*scale)/2,(wh-560*scale)/2}

local won = false

local justPopped

local Game = {
    Progress = {
        currentRoomName = "Room 1",
        player = {
            character = "Boy",
            x = nil,
            y = nil,
            looking = nil
        },
        ["Room 1"] = {
            chest = {
                beginClosed = true,
                flipped_horizontal = false,
                flipped_vertical = false,
                isLocked = false
            },
            door = {
                beginClosed = true,
                flipped_horizontal = true,
                flipped_vertical = false,
                isLocked = false
            },
            wierdWall = {
                beginClosed = true
            }
        },
        ["Room 2"] = {
            door = {
                beginClosed = true,
                flipped_horizontal = true,
                flipped_vertical = false,
                isLocked = false
            }
        },
        ["Room 3"] = {
            lockingDoor = {
                beginClosed = true,
                flipped_horizontal = true,
                flipped_vertical = false,
                isLocked = true
            },
            greenLever = {
                beginClosed = true,
                flipped_horizontal = false,
                flipped_vertical = false,
                isLocked = false
            }
        },
        ["Room 4"] = {
            ["redLever 1"] = {
                beginClosed = true,
                flipped_horizontal = false,
                flipped_vertical = false,
                isLocked = false
            },
            ["redLever 2"] = {
                beginClosed = true,
                flipped_horizontal = false,
                flipped_vertical = false,
                isLocked = false
            },
            ["redLever 3"] = {
                beginClosed = true,
                flipped_horizontal = false,
                flipped_vertical = false,
                isLocked = false
            },
            ["lockingDoor"] = {
                beginClosed = true,
                flipped_horizontal = true,
                flipped_vertical = false,
                isLocked = true
            },
            ["chest"] = {
                beginClosed = true,
                flipped_horizontal = false,
                flipped_vertical = false,
                isLocked = false
            }
        },
        ["Room 5"] = {
            ["lockingDoor 1"] = {
                beginClosed = true,
                flipped_horizontal = true,
                flipped_vertical = false,
                isLocked = false
            },
            ["lockingDoor 2"] = {
                beginClosed = true,
                flipped_horizontal = true,
                flipped_vertical = false,
                isLocked = true
            },
            ["chest"] = {
                beginClosed = true,
                flipped_horizontal = false,
                flipped_vertical = false,
                isLocked = true
            }
        },
        ["Room 6"] = {
            ["lockingDoor"] = {
                beginClosed = true,
                flipped_horizontal = true,
                flipped_vertical = false,
                isLocked = true
            }
        },
        ["Room 7"] = {
            ["door"] = {
                beginClosed = true,
                flipped_horizontal = true,
                flipped_vertical = false,
                isLocked = false
            }
        },
        ["Room 8"]= {
            ["door"] = {
                beginClosed = true,
                flipped_horizontal = true,
                flipped_vertical = false,
                isLocked = false
            },
            ["chest"] = {
                beginClosed = true,
                flipped_horizontal = false,
                flipped_vertical = false,
                isLocked = true
            },
            ["greenLever"] = {
                beginClosed = true,
                flipped_horizontal = false,
                flipped_vertical = false,
                isLocked = true
            }
        },
        ["Hidden Room"] = {
            ["chest 1"] = {
                beginClosed = false,
                flipped_horizontal = false,
                flipped_vertical = false,
                isLocked = false
            },
            ["chest 2"] = {
                beginClosed = true,
                flipped_horizontal = false,
                flipped_vertical = false,
                isLocked = false
            },
            ["redLever"] = {
                beginClosed = true,
                flipped_horizontal = false,
                flipped_vertical = false,
                isLocked = false
            },
            ["greenLever"] = {
                beginClosed = true,
                flipped_horizontal = false,
                flipped_vertical = false,
                isLocked = false
            },
            ["blueLever"] = {
                beginClosed = true,
                flipped_horizontal = false,
                flipped_vertical = false,
                isLocked = false
            },
            ["orangeLever"] = {
                beginClosed = true,
                flipped_horizontal = false,
                flipped_vertical = false,
                isLocked = false
            }
        }
    },
    associatedDoors = {
        ["Room 1"] = {
            door = {
                roomName = "Room 2",
                doorName = "door"
            }
        },
        ["Room 2"] = {
            door = {
                roomName = "Room 1",
                doorName = "door"
            }
        },
        ["Room 3"] = {
            lockingDoor = {
                roomName = "Room 5",
                doorName = "lockingDoor 1"
            }
        },
        ["Room 5"] = {
            ["lockingDoor 1"] = {
                roomName = "Room 3",
                doorName = "lockingDoor"
            }
        },
        ["Room 7"] = {
            ["door"] = {
                roomName = "Room 8",
                doorName = "door"
            }
        }
    },
    ProgressText = {
        ["Room 1"] = {
            ["chest"] = {
                isLocked = "The chest appears to be locked.",
                beginClosed = 'You can press "O" to open the chest and "C" to close the chest.',
                elsetext = [[There appears to be a piece of paper inside the chest that reads:
                "Nice, you figured out how to open this chest!!"]]
            },
            ["door"] = {
                beginClosed = 'Press "O" to open the door and "C" to close the door.',
                elsetext = "The door is open."
            },
            ["wierdWall"] = {
                beginClosed = "This wall looks like any other wall.",
                elsetext = "Whoa!! This wall looks like it just blurred out!! Could I walk through this...?"
            }
        },
        ["Room 2"] = {
            ["text"] = {
                elsetext = "Tip: There are different colored torches.. What is their purpose other than lighting the rooms?"
            },
            ["door"] = {
                beginClosed = 'You can press "O" to open the door and "C" to close the door.',
                elsetext = "The door is open."
            }
        },
        ["Room 3"] = {
            ["text"] = {
                elsetext = [[Tip:
                If an object is locked after it is opened, it can't be closed until unlocked again.]]
            },
            ["greenLever"] = {
                isLocked = "The lever is not moving!",
                beginClosed = 'You can press "R" to shift lever to right and "L" to move it back left.',
                elsetext = "I wonder what this lever did... did it unlock the door in this room??"
            },
            lockingDoor = {
                isLocked = "The door appears to be locked.",
                beginClosed = 'It appears that the lever has unlocked this door. You can press "O" to open the door and "C" to close the door.',
                elsetext = "The door is open."
            }
        },
        ["Room 4"] = {
            ["text"] = {
                elsetext = "Let the light guide the way.. But what is it that 3 levers can do that a single one can't?"
            },
            ["redLever 1"] = {
                isLocked = '"R" to move lever right and "L" to move it left',
                beginClosed = '"R" to move lever right and "L" to move it left',
                elsetext = '"R" to move lever right and "L" to move it left'
            },
            ["redLever 2"] = {
                isLocked = '"R" to move lever right and "L" to move it left',
                beginClosed = '"R" to move lever right and "L" to move it left',
                elsetext = '"R" to move lever right and "L" to move it left'
            },
            ["redLever 3"] = {
                isLocked = '"R" to move lever right and "L" to move it left',
                beginClosed = '"R" to move lever right and "L" to move it left',
                elsetext = '"R" to move lever right and "L" to move it left'
            },
            ["lockingDoor"] = {
                isLocked = "The door appears to be locked.",
                beginClosed = 'Press "O" to open the door and "C" to close it.',
                elsetext = "The door is open."
            },
            ["chest"] = {
                beginClosed = 'Press "O" to open the door and "C" to close.',
                elsetext = [[There is a paper that reads:
                "The room ahead has the final door.
                To find the levers that unlock it, you must first find the levers :)
                They are hidden from sight, and the hidden path only unlocks when all the levers you can see are turned right :)"]]
            }
        },
        ["Room 5"] = {
            ["text"] = {
                elsetext = [[On the floor above, from the green tile,
                follow the footsteps of that brave king's bright knight clad in white on whose queen was showered gold.
                BEWARE!!
                IF YOU STRAY FROM THE PATH, YOU WILL BE SENT BACK HERE!!
                Tip: try moving forward first and then to the sides.
                Also, the tiles of the wrong paths are really sensitive :)]]
            },
            ["chest"] = {
                isLocked = [[switch 5 unlocks the chest and switch 3 unlocks the door!!
                Even with the right switching, the door here doesn't open if the chest is closed:)]],
                beginClosed = 'You can press "O" to open the chest and "C" to close the chest.',
                elsetext = "switch 3 unlocks the door!!"
            },
            ["lockingDoor 1"] = {
                isLocked = "The door appears to be locked.",
                beginClosed = '"O" to open and "C" to close the door',
                elsetext = "The door is open."
            },
            ["lockingDoor 2"] = {
                isLocked = "The door appears to be locked.",
                beginClosed = '"O" to open and "C" to close the door',
                elsetext = "The door is open."
            },
            ["stairs"] = {
                elsetext = "The stairs are made of polished stone."
            }
        },
        ["Room 6"] = {
            ["text"] = {
                elsetext = [[Yay!!
                This is the last door!!
                Unlock it and walk through to win the game!!]]
            },
            ["lockingDoor"] = {
                isLocked = "The door appears to be locked.",
                beginClosed = '"O" to open and "C" to close the door',
                elsetext = "The door is open."
            }
        },
        ["Room 7"] = {
            ["door"] = {
                isLocked = "The door appears to be locked.",
                beginClosed = '"O" to open and "C" to close the door',
                elsetext = "The door is open."
            }
        },
        ["Room 8"] = {
            ["chest"] = {
                isLocked = "This chest unlocks itself and the green lever here when the other green lever is off.",
                beginClosed = 'You can press "O" to open the chest and "C" to close the chest.',
                elsetext = [[There appears to be a piece of paper inside the chest that reads:
                "If you get thrown from this floor, the green switch here turns back"]]
            },
            ["door"] = {
                beginClosed = 'You can press "O" to open the door and "C" to close the door.',
                elsetext = "The door is open."
            },
            ["greenLever"] = {
                isLocked = "The lever is not moving",
                beginClosed = '"R" to move lever right and "L" to move it left',
                elsetext = '"R" to move lever right and "L" to move it left'
            }
        },
        ["Hidden Room"] = {
            ["redLever"] = {
                isLocked = '"R" to move lever right and "L" to move it left',
                beginClosed = '"R" to move lever right and "L" to move it left',
                elsetext = '"R" to move lever right and "L" to move it left'
            },
            ["greenLever"] = {
                isLocked = '"R" to move lever right and "L" to move it left',
                beginClosed = '"R" to move lever right and "L" to move it left',
                elsetext = '"R" to move lever right and "L" to move it left'
            },
            ["blueLever"] = {
                isLocked = '"R" to move lever right and "L" to move it left',
                beginClosed = '"R" to move lever right and "L" to move it left',
                elsetext = '"R" to move lever right and "L" to move it left'
            },
            ["orangeLever"] = {
                isLocked = '"R" to move lever right and "L" to move it left',
                beginClosed = '"R" to move lever right and "L" to move it left',
                elsetext = '"R" to move lever right and "L" to move it left'
            },
            ["chest 2"] = {
                beginClosed = "The chest is not locked",
                elsetext = "Turn the levers to point in the direction where torches are placed in the floor above, and close all the doors behind you to open the last one :)"
            },
            ["wierdWall"] = {
                elsetext = "This hidden door is pretty neat :)"
            }
        }
    },
    Teleports = {
        ["Room 1"] = {
            ["Room 2 teleport"] = {
                currentRoomName = "Room 2",
                x = 6*(5*16),
                y = 5.75*(5*16),
                looking = "up"
            },
            ["Hidden Room teleport"] = {
                currentRoomName = "Hidden Room",
                x = 4*(5*16),
                y = 5*(5*16),
                looking = "left"
            }
        },
        ["Room 2"] = {
            ["Room 1 teleport"] = {
                currentRoomName = "Room 1",
                x = 6*(5*16),
                y = 0.25*(5*16),
                looking = "down"
            },
            ["Room 3 teleport"] = {
                currentRoomName = "Room 3",
                x = 1*(5*16),
                y = nil,
                looking = "right"
            },
            ["Room 4 teleport"] = {
                currentRoomName = "Room 4",
                x = 8.75*(5*16),
                y = nil,
                looking = "left"
            }
        },
        ["Room 3"] = {
            ["Room 2 teleport"] = {
                currentRoomName = "Room 2",
                x = 8.75*(5*16),
                y = nil,
                looking = "left"
            },
            ["Room 5 teleport"] = {
                currentRoomName = "Room 5",
                x = nil,
                y = 0.25*(5*16),
                looking = "down"
            }
        },
        ["Room 4"] = {
            ["Room 2 teleport"] = {
                currentRoomName = "Room 2",
                x = 0.25*(5*16),
                y = nil,
                looking = "right"
            },
            ["Room 6 teleport"] = {
                currentRoomName = "Room 6",
                x = nil,
                y = 0.25*(5*16),
                looking = "down"
            }
        },
        ["Room 5"] = {
            ["Room 3 teleport"] = {
                currentRoomName = "Room 3",
                x = nil,
                y = 5.75*(5*16),
                looking = "right"
            },
            ["Room 7 teleport"] = {
                currentRoomName = "Room 7",
                x = 6*(5*16),
                y = 6*(5*16),
                looking = "left"
            }
        },
        ["Room 6"] = {
            ["Room 4 teleport"] = {
                currentRoomName = "Room 4",
                x = nil,
                y = 5.75*(5*16),
                looking = "up"
            }
        },
        ["Room 7"] = {
            ["Room 5 Stair teleport"] = {
                currentRoomName = "Room 5",
                x = 3*(5*16),
                y = 2*(5*16),
                looking = "right"
            },
            ["Room 5 Drop teleport"] = {
                currentRoomName = "Room 5",
                x = 1*(5*16),
                y = 1*(5*16),
                looking = "up"
            },
            ["Room 8 teleport"] = {
                currentRoomName = "Room 8",
                x = nil,
                y = 5.75*(5*16),
                looking = "up"
            }
        },
        ["Room 8"] = {
            ["Room 7 teleport"] = {
                currentRoomName = "Room 7",
                x = nil,
                y = 0.25*(5*16),
                looking = "down"
            }
        },
        ["Hidden Room"] = {
            ["Room 1 teleport"] = {
                currentRoomName = "Room 1",
                x = 1.25*(5*16),
                y = 2*(5*16),
                looking = "right"
            }
        }
    },
    objectConditions = { -- if it is an interactable object, then the conditions are meant for isLocked, and if it is a movingWall, then the conditions are meant for beginClosed
        ["Room 1"] = {
            chest = nil,
            door = nil,
            wierdWall = {
                ["lever 1"] = {
                    roomName = "Room 3",
                    objectName = "greenLever",
                    fields = {
                        ["beginClosed"] = false
                    }
                },
                ["lever 2"] = {
                    roomName = "Room 4",
                    objectName = "redLever 1",
                    fields = {
                        ["beginClosed"] = false
                    }
                },
                ["lever 3"] = {
                    roomName = "Room 4",
                    objectName = "redLever 2",
                    fields = {
                        ["beginClosed"] = false
                    }
                },
                ["lever 4"] = {
                    roomName = "Room 4",
                    objectName = "redLever 3",
                    fields = {
                        ["beginClosed"] = false
                    }
                },
                ["lever 5"] = {
                    roomName = "Room 8",
                    objectName = "greenLever",
                    fields = {
                        ["beginClosed"] = false
                    }
                }
            }
        },
        ["Room 2"] = {
            door = nil
        },
        ["Room 3"] = {
            lockingDoor = {
                lever = {
                    roomName = "Room 3",
                    objectName = "greenLever",
                    fields = {
                        ["beginClosed"] = false
                    }
                }
            },
            greenLever = nil
        },
        ["Room 4"] = {
            ["redLever 1"] = nil,
            ["redLever 2"] = nil,
            ["redLever 3"] = nil,
            ["lockingDoor"] = {
                ["redLever 1"] = {
                    roomName = "Room 8",
                    objectName = "greenLever",
                    fields = {
                        ["beginClosed"] = false
                    }
                }
            },
            ["chest"] = nil
        },
        ["Room 5"] = {
            ["lockingDoor 1"] = nil,
            ["lockingDoor 2"] = {
                ["redLever 1"] = {
                    roomName = "Room 4",
                    objectName = "redLever 1",
                    fields = {
                        ["beginClosed"] = true
                    }
                },
                ["redLever 2"] = {
                    roomName = "Room 4",
                    objectName = "redLever 2",
                    fields = {
                        ["beginClosed"] = false
                    }
                },
                ["redLever 3"] = {
                    roomName = "Room 4",
                    objectName = "redLever 3",
                    fields = {
                        ["beginClosed"] = false
                    }
                },
                ["chest"] = {
                    roomName = "Room 5",
                    objectName = "chest",
                    fields = {
                        ["beginClosed"] = false
                    }
                }
            },
            ["chest"] = {
                ["redLever 1"] = {
                    roomName = "Room 4",
                    objectName = "redLever 1",
                    fields = {
                        ["beginClosed"] = false
                    }
                },
                ["redLever 2"] = {
                    roomName = "Room 4",
                    objectName = "redLever 2",
                    fields = {
                        ["beginClosed"] = true
                    }
                },
                ["redLever 3"] = {
                    roomName = "Room 4",
                    objectName = "redLever 3",
                    fields = {
                        ["beginClosed"] = false
                    }
                }
            }
        },
        ["Room 6"] = {
            ["lockingDoor"] = {
                ["lever 1"] = {
                    roomName = "Hidden Room",
                    objectName = "redLever",
                    fields = {
                        ["beginClosed"] = true
                    }
                },
                ["lever 2"] = {
                    roomName = "Hidden Room",
                    objectName = "greenLever",
                    fields = {
                        ["beginClosed"] = false
                    }
                },
                ["lever 3"] = {
                    roomName = "Hidden Room",
                    objectName = "blueLever",
                    fields = {
                        ["beginClosed"] = false
                    }
                },
                ["lever 4"] = {
                    roomName = "Hidden Room",
                    objectName = "orangeLever",
                    fields = {
                        ["beginClosed"] = true
                    }
                },
                ["door 1"] = {
                    roomName = "Room 2",
                    objectName = "door",
                    fields = {
                        ["beginClosed"] = true
                    }
                },
                ["door 2"] = {
                    roomName = "Room 3",
                    objectName = "lockingDoor",
                    fields = {
                        ["beginClosed"] = true
                    }
                },
                ["door 3"] = {
                    roomName = "Room 4",
                    objectName = "lockingDoor",
                    fields = {
                        ["beginClosed"] = true
                    }
                },
                ["door 4"] = {
                    roomName = "Room 5",
                    objectName = "lockingDoor 1",
                    fields = {
                        ["beginClosed"] = true
                    }
                },
                ["door 5"] = {
                    roomName = "Room 5",
                    objectName = "lockingDoor 2",
                    fields = {
                        ["beginClosed"] = true
                    }
                },
                ["door 6"] = {
                    roomName = "Room 7",
                    objectName = "door",
                    fields = {
                        ["beginClosed"] = true
                    }
                }
            }
        },
        ["Room 7"] = {
            ["door"] = nil
        },
        ["Room 8"] = {
            ["door"] = nil,
            ["chest"] = {
                ["greenLever"] = {
                    roomName = "Room 3",
                    objectName = "greenLever",
                    fields = {
                        ["beginClosed"] = true
                    }
                }
            },
            ["greenLever"] = {
                ["chest"] = {
                    roomName = "Room 3",
                    objectName = "greenLever",
                    fields = {
                        ["beginClosed"] = true
                    }
                }
            }
        },
        ["Hidden Room"] = {
            ["chest 2"] = nil,
            ["greenLever"] = nil,
            ["redLever"] = nil,
            ["blueLever"] = nil,
            ["orangeLever"] = nil

        }
    },
    GeneralDialog = {
        wall = "The wall appears to be made of stone.",
        torch = "The torch is bright and warm.",
        fireplace = "The fireplace makes the room feel cozy. If not for this fireplace, the room would probably be pretty cold."
    }
}

function Game:saveGame(savefilename)
    self.Progress.player.character = player.character
    self.Progress.player.x = player.x
    self.Progress.player.y = player.y
    self.Progress.player.looking = player.looking

    TableIO.dump(Game.Progress, savefilename)
end

function Game:reloadGame() -- Uses Game.Progress to reload the game
    player.world:destroy()
    player = Player:New()
    background = Background:New(self.Progress.currentRoomName, player.world)
end

function Game:loadGame(savefilename)
    local loadedFile = TableIO.load(savefilename)
    if loadedFile then
        Game.Progress = loadedFile
        Game:reloadGame()
        return true
    else
        return false
    end
end

function Game:getGameObjects()
    local game = {}
    setmetatable(game, self)
    self.__index = self

    game.enteredCollider = nil
    game.activeObject = nil
    game.movingWalls = {}
    return game
end

function Game:getProgressText(enteredCollider)
    local text = "Not yet set text"
    local textTable = nil
    if Game.ProgressText[Game.Progress.currentRoomName][enteredCollider.name] then
        textTable = Game.ProgressText[Game.Progress.currentRoomName][enteredCollider.name]
    end
    if textTable then
        local object
        if Game.Progress[Game.Progress.currentRoomName][enteredCollider.name] then 
            object = Game.Progress[Game.Progress.currentRoomName][enteredCollider.name]
        end
        if object and object.isLocked and object.isLocked then
            text = textTable.isLocked
        elseif object and object.beginClosed then
            text = textTable.beginClosed
        else
            text = textTable.elsetext
        end
    end
    return text
end

function Game:evaluateConditions(roomName, objectName) -- evaluates new condition for islocked, if the evaluation is false, the object will no longer be locked/closed
    local evaluation = true
    if Game.objectConditions[roomName][objectName] ~= nil then
        for _, conditions in pairs(Game.objectConditions[roomName][objectName]) do
            for field, value in pairs(conditions.fields) do
                evaluation = evaluation and (Game.Progress[conditions.roomName][conditions.objectName][field] == value)
            end
        end
        return not evaluation
    else
        return false
    end
end

function Game:takeInput(key)
    if stateStack:Top() == "tutorial" then
        dialogBox:UpdateLine(key)
        if key == "escape" then
            stateStack:Pop()
            dialogBox.currentLine = 1
        end
    else
        --dialogBox:load(inventory)
        justPopped = false
        dialogBox:clearDialog()
        if self.enteredCollider then
            local text = tostring(Game.GeneralDialog[self.enteredCollider.name])
            if text == "nil" then --couldnt find general dialog, tries to find dialog inside 
                text = Game:getProgressText(self.enteredCollider)
            end
            dialogBox:pushDialog(text)
        end
        if key == "x" or key == "return" then
            if stateStack:Top() == "player" and #dialogBox.textTable > 0 then
                stateStack:Push("dialogBox")
            elseif stateStack:Top() == "dialogBox" then
                dialogBox:clearDialog()
                stateStack:Pop()
                dialogBox.currentLine = 1
            elseif stateStack:Top() == "menuDialogBox" then
                menu.dialogBox:clearDialog()
                justPopped = true
                stateStack:Pop()
                menu.dialogBox.currentLine = 1
            end
        end
        if key == "escape" then
            if not stateStack:StateInStack("menu") then
                if menu:MenuEmpty() then
                    menu:MenuPush("midGame")
                end
                stateStack:Push("menu")
            elseif stateStack:Top() == "menu" and menu:MenuTop() ~= "startScreen" then
                stateStack:Pop()
                while menu:MenuPop() do end
                menu.warningGiven = false
            end
        end
        if stateStack:Top() == "dialogBox" then
            dialogBox:UpdateLine(key)
        end
        if stateStack:Top() == "menu" and not justPopped then
            menu:takeInput(key)
        end
        if stateStack:Top() == "menuDialogBox" then
            menu.dialogBox:UpdateLine(key)
        end
    end
end

function Game.GameWon()
    if not won then
        won = true
        while stateStack:Top() ~= nil do
            stateStack:Pop()
        end
        while menu:MenuPop() do end
        menu:MenuPush("GameWon")
        stateStack:Push("menu","menuDialogBox")
        menu.dialogBox:pushDialog("You have won the game :):):) !!!")
    end
end

function Game:Update(dt) -- could change isOpening/ isClosing directly from Game:takeInput(key)
    local RoomName = Game.Progress.currentRoomName
    if self.enteredCollider and self.enteredCollider.name == "Room 5 Drop teleport" then
        Game.Progress["Room 8"]["greenLever"].beginClosed = true
    end
    if self.enteredCollider and self.enteredCollider.name == "Game Won" then
        Game.GameWon()
    end
    if self.enteredCollider and string.find(self.enteredCollider.name, "teleport") then
        local teleport_details = Game.Teleports[RoomName][self.enteredCollider.name]
        Game.Progress.currentRoomName = teleport_details.currentRoomName
        Game.Progress.player.x = teleport_details.x or player.x
        Game.Progress.player.y = teleport_details.y or player.y
        Game.Progress.player.looking = teleport_details.looking or player.looking
        Game:reloadGame()
    end
    if self.activeObject then
        local ObjectName = self.enteredCollider.name
        if Game.objectConditions[RoomName][ObjectName] ~= nil then
            Game.Progress[RoomName][ObjectName].isLocked = Game:evaluateConditions(RoomName, ObjectName)
            self.activeObject.object.isLocked = Game.Progress[RoomName][ObjectName].isLocked
        end
    end
    for _, movingWall in ipairs(self.movingWalls) do
        if self.activeObject then -- finds associated Wall and then closes/opens it whenever touched
            if self.activeObject.object.isClosed then
                    if self.activeObject.name == movingWall.name then
                        if movingWall.class ~= "Wall" then
                            movingWall.collider:setCollisionClass('Wall')
                            movingWall.class = "Wall"
                        end
                    end
            else
                if self.activeObject.name == movingWall.name then
                    if movingWall.class ~= "Open Wall" then
                        movingWall.collider:setCollisionClass('Open Wall')
                        movingWall.class = "Open Wall"
                    end
                end
            end
        else -- unassociated walls
            if self.enteredCollider and self.enteredCollider.name == movingWall.name then
                if Game.Progress[RoomName][movingWall.name] then
                    local evaluation = Game:evaluateConditions(RoomName, movingWall.name)
                    Game.Progress[RoomName][movingWall.name].beginClosed = evaluation
                    if evaluation then
                        if movingWall.class ~= "Wall" then
                            movingWall.collider:setCollisionClass('Wall')
                            movingWall.class = "Wall"
                        end
                    else
                        if movingWall.class ~= "Open Wall" then
                            movingWall.collider:setCollisionClass('Open Wall')
                            movingWall.class = "Open Wall"
                        end
                    end
                end
            end
        end
    end
    if self.activeObject then
        if (not string.find(self.activeObject.name, "Lever") and love.keyboard.isDown("o")) or (string.find(self.activeObject.name, "Lever") and love.keyboard.isDown("r")) or self.activeObject.object.isOpening then -- opens or closes activeObject
            self.activeObject.object:Open(dt)
        elseif (not string.find(self.activeObject.name, "Lever") and love.keyboard.isDown("c")) or (string.find(self.activeObject.name, "Lever") and love.keyboard.isDown("l")) or self.activeObject.object.isClosing then
            self.activeObject.object:Close(dt)
        end
        local associatedDoor
        if Game.associatedDoors[RoomName] and Game.associatedDoors[RoomName][self.activeObject.name] then
            associatedDoor = Game.associatedDoors[RoomName][self.activeObject.name]
        end
        if associatedDoor then
            Game.Progress[associatedDoor.roomName][associatedDoor.doorName].beginClosed = self.activeObject.object.isClosed
        end
        Game.Progress[RoomName][self.activeObject.name].isLocked = self.activeObject.object.isLocked
        Game.Progress[RoomName][self.activeObject.name].beginClosed = self.activeObject.object.isClosed
    end
end

function Game:isWallClosed(objName)
    local Obj = Game.Progress[Game.Progress.currentRoomName][objName]
    if Obj then
        return Obj.beginClosed
    end
end
function Game:getObjectProperties(objName)
    local Obj = Game.Progress[Game.Progress.currentRoomName][objName]
    if Obj then
        return {
            beginClosed = Obj.beginClosed,
            flipped_horizontal = Obj.flipped_horizontal,
            flipped_vertical = Obj.flipped_vertical,
            isLocked = Obj.isLocked
        }
    end
end

function Game:UpdateObjects(enteredCollider, activeObject, movingWalls)
    self.enteredCollider = enteredCollider
    self.activeObject = activeObject
    self.movingWalls = movingWalls
end

return Game