--new folder for progress, settings, cheats option to manually enable properties in progress?
--uses that enteredCollider/activeObject from background.lua to generate text
--self.gamedetails.progress = load(self.gamedetails.savefile) or self.gamedetails.progress
--need to organize Game.Progress.interactableObjects better?
--could make enteredCollider, activeObject and movingWalls global and declare them here?
--need to make background.lua read movingWall and interactableObject details from Game.Progress
--need to make teleport function

local TableIO = require "TableIO"

width = love.graphics.getWidth()
height = love.graphics.getHeight()
scale = math.min(width/800, height/560)

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
    Settings = {},
    Dialog = {
        wall = "The wall appears to be made of stone.",
        chestLocked = "The chest appears to be locked.",
        chestUnlocked = 'Press "O" to open, and "C" to close the chest.',
        doorLocked = "The door appears to be locked.",
        doorUnlocked = 'Press "O" to open, and "C" to close the door.',
        torch = "The torch is bright and warm.",
        fireplace = "The fireplace makes the room feel cozy. If not for this fireplace, the room would probably be pretty cold."
    }
}

--TableIO.dump(Game.Settings, "settings")

function Game:saveGame(savefilename)
    TableIO.dump(Game.Progress, "progress")
end

function Game:loadGame(savefilename)
    Game.Progress = TableIO.load("progress") or Game.Progress
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
    local text
    if enteredCollider.name == "chest" or enteredCollider.name == "door" then
        if enteredCollider.isLocked then
            text = enteredCollider.name.."Locked"
        else
            text = enteredCollider.name.."Unlocked"
        end
        text = Game.Dialog[text]
    elseif Game.Progress.interactableObjects[Game.Progress.currentRoomName][enteredCollider.name] then
        text = Game.Progress.interactableObjects[Game.Progress.currentRoomName][enteredCollider.name].dialog
    end
    return text
end

function Game:takeInput(key)
    --dialogBox:load(inventory)
    dialogBox:clearDialog()
    if self.enteredCollider then
        local text = tostring(Game.Dialog[self.enteredCollider.name])
        if text == "nil" then
            text = Game:getProgressText(self.enteredCollider)
        end
        dialogBox:pushDialog(text)
    end
    if key == "x" then
        if stateStack:Top() == "player" and #dialogBox.textTable > 0 then
            stateStack:Push("dialogBox")
        elseif stateStack:Top() == "dialogBox" then
            stateStack:Pop()
        end
    end
    if key == "escape" then
        if not stateStack:StateInStack("menu") then
            if menu:MenuEmpty() then
                menu:MenuPush("midGame")
            end
            stateStack:Push("menu")
        elseif stateStack:Top() == "menu" then
            if not menu:MenuPop() then
                stateStack:Pop()
            end
        end
    end
    if stateStack:Top() == "dialogBox" then
        dialogBox:UpdateLine(key)
    end
end

function Game:Update(dt) -- could change isOpening/ isClosing directly from Game:takeInput(key)
    if self.activeObject then
        if love.keyboard.isDown("o") or self.activeObject.object.isOpening then
            self.activeObject.object:Open(dt)
        elseif love.keyboard.isDown("c") or self.activeObject.object.isClosing then
            self.activeObject.object:Close(dt)
        end
        if self.activeObject.object.isClosed then
            for _, movingWall in ipairs(self.movingWalls) do
                if self.activeObject.name == movingWall.name then
                    if movingWall.class ~= "Wall" then
                        movingWall.collider:setCollisionClass('Wall')
                        movingWall.class = "Wall"
                    end
                end
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
        end
    end
end

function Game:UpdateObjects(enteredCollider, activeObject, movingWalls)
    self.enteredCollider = enteredCollider
    self.activeObject = activeObject
    self.movingWalls = movingWalls
end

return Game