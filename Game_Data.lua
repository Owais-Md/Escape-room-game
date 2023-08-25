--new folder for progress, settings, cheats option to manually enable properties in progress?
--uses that enteredCollider/activeObject from background.lua to generate text
--need to make getProgressText better so that i can show locked objects better [dialogBox]
--also need to add switches inside the game, so that game isn't bland lmao
--need to make an inventory too

love.graphics.setDefaultFilter("nearest","nearest")
love.mouse.setVisible(false)
bigFont = love.graphics.newFont(32)
smallFont = love.graphics.newFont(16)

local TableIO = require "TableIO"
local Player = require "Player"
local Background = require "Background"

ww = love.graphics.getWidth()
wh = love.graphics.getHeight()
scale = math.min(ww/800, wh/560)
wtranslate = {(ww-800*scale)/2,(wh-560*scale)/2}

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
                isLocked = false,
                associatedDoor = {
                    roomName = "Room 2",
                    doorName = "door"
                }
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
                isLocked = false,
                associatedDoor = {
                    roomName = "Room 1",
                    doorName = "door"
                }
            }
        },
        ["Room 3"] = {
            ["lockingDoor 1"] = {
                beginClosed = true,
                flipped_horizontal = true,
                flipped_vertical = false,
                isLocked = true
            },
            orangeLever = {
                beginClosed = true,
                flipped_horizontal = false,
                flipped_vertical = false,
                isLocked = false
            }
        }
    },
    Teleports = {
        ["Room 1"] = {
            ["Room 2 teleport"] = {
                currentRoomName = "Room 2",
                x = 6*(5*16),
                y = 5.25*(5*16),
                looking = "up"
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
            }
        },
        ["Room 3"] = {
            ["Room 2 teleport"] = {
                currentRoomName = "Room 2",
                x = 8.75*(5*16),
                y = nil,
                looking = "left"
            },
        }
    },
    objectConditions = {
        ["Room 1"] = {
            chest = {
                lockingDoor = {
                    roomName = "Room 3",
                    objectName = "lockingDoor 1",
                    fields = {
                        ["beginClosed"] = false
                    }
                },
                ["first door"] = {
                    roomName = "Room 1",
                    objectName = "door",
                    fields = {
                        ["beginClosed"] = true
                    }
                }
            },
            door = nil
        },
        ["Room 2"] = {
            door = nil
        },
        ["Room 3"] = {
            ["lockingDoor 1"] = {
                lever = {
                    roomName = "Room 3",
                    objectName = "orangeLever",
                    fields = {
                        ["beginClosed"] = false
                    }
                }
            },
            orangeLever = nil
        }
    },
    Settings = {},
    GeneralDialog = {
        wall = "The wall appears to be made of stone.",
        torch = "The torch is bright and warm.",
        fireplace = "The fireplace makes the room feel cozy. If not for this fireplace, the room would probably be pretty cold."
    },
    ProgressText = {
        ["Room 1"] = {
            ["chest"] = {
                isLocked = "The chest appears to be locked",
                beginClosed = 'You can press "O" to open the chest and "C" to close the chest',
                elsetext = "There appears to be a piece of paper inside the chest that reads: Nice"
            },
            ["door"] = {
                beginClosed = 'You can press "O" to open the door and "C" to close the door',
                elsetext = "The door is open"
            },
            ["wierdWall"] = {
                beginClosed = "This wall appears to be different from the other wallls",
                elsetext = "The wall appears to be different from the other walls"
            }
        },
        ["Room 2"] = {
            ["text"] = {
                isLocked = "The chest appears to be locked",
                beginClosed = 'You can press "O" to open the chest and "C" to close the chest',
                elsetext = "There appears to be a piece of paper inside the chest that reads: Nice"
            },
            ["door"] = {
                beginClosed = 'You can press "O" to open the door and "C" to close the door',
                elsetext = "The door is open"
            }
        },
        ["Room 3"] = {
            ["orangeLever"] = {
                isLocked = "The lever is not moving!",
                beginClosed = 'You can press "O" to shift lever to right and "C" to move it back left',
                elsetext = "I wonder what this lever did"
            },
            ["lockingDoor 1"] = {
                isLocked = "The door appears to be locked",
                beginClosed = 'You can press "O" to open the door and "C" to close the door',
                elsetext = "The door is open"
            }
        }
    }
}

--TableIO.dump(Game.Settings, "settings")

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
        self.flag = "Set"
        local object
        if Game.Progress[Game.Progress.currentRoomName][enteredCollider.name] then 
            object = Game.Progress[Game.Progress.currentRoomName][enteredCollider.name]
        end
        if object and object.isLocked then
            text = textTable.isLocked
        elseif object and object.beginClosed then
            text = textTable.beginClosed
        else
            text = textTable.elsetext
        end
    end
    return text
end

function Game:evaluateConditions(roomName, objectName) -- evaluates new condition for islocked, if the evaluation is false, the object will no longer be locked
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

function Game:Update(dt) -- could change isOpening/ isClosing directly from Game:takeInput(key)
    if self.enteredCollider and string.find(self.enteredCollider.name, "teleport") then
        local teleport_details = Game.Teleports[Game.Progress.currentRoomName][self.enteredCollider.name]
        Game.Progress.currentRoomName = teleport_details.currentRoomName
        Game.Progress.player.x = teleport_details.x or player.x
        Game.Progress.player.y = teleport_details.y or player.y
        Game.Progress.player.looking = teleport_details.looking
        Game:reloadGame()
    end
    if self.enteredCollider then
        local RoomName = Game.Progress.currentRoomName
        local ObjectName = self.enteredCollider.name
        if Game.objectConditions[RoomName][ObjectName] ~= nil then
            Game.Progress[RoomName][ObjectName].isLocked = Game:evaluateConditions(RoomName, ObjectName)
            self.activeObject.object.isLocked = Game.Progress[RoomName][ObjectName].isLocked
        end
    end
    if self.activeObject then
        if love.keyboard.isDown("o") or self.activeObject.object.isOpening then -- opens or closes activeObject
            self.activeObject.object:Open(dt)
        elseif love.keyboard.isDown("c") or self.activeObject.object.isClosing then
            self.activeObject.object:Close(dt)
        end
        local associatedDoor = Game.Progress[Game.Progress.currentRoomName][self.activeObject.name].associatedDoor
        if self.activeObject.object.isClosed then -- finds associated Wall and then closes/opens it whenever touched
            for _, movingWall in ipairs(self.movingWalls) do
                if self.activeObject.name == movingWall.name then
                    if movingWall.class ~= "Wall" then
                        movingWall.collider:setCollisionClass('Wall')
                        movingWall.class = "Wall"
                    end
                end
            end
            if associatedDoor then
                Game.Progress[associatedDoor.roomName][associatedDoor.doorName].beginClosed = true
            end
        else
            for _, movingWall in ipairs(self.movingWalls) do
                if self.activeObject.name == movingWall.name then
                    if movingWall.class ~= "Open Wall" then
                        movingWall.collider:setCollisionClass('Open Wall')
                        movingWall.class = "Open Wall"
                    end
                end
            end
            if associatedDoor then
                Game.Progress[associatedDoor.roomName][associatedDoor.doorName].beginClosed = false
            end
        end
        Game.Progress[Game.Progress.currentRoomName][self.activeObject.name].isLocked = self.activeObject.object.isLocked
        Game.Progress[Game.Progress.currentRoomName][self.activeObject.name].beginClosed = self.activeObject.object.isClosed
    end
end

function Game:getMovingWallProperties(objName)
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