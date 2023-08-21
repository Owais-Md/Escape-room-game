--new folder for progress, settings, cheats option to manually enable properties in progress?
--uses that enteredCollider/activeObject from background.lua to generate text
--self.gamedetails.progress = load(self.gamedetails.savefile) or self.gamedetails.progress
--need to organize Game.Progress.interactableObjects better?
--could make enteredCollider, activeObject and movingWalls global and declare them here?
--need to save progress actively from Game:Update(dt), so that on saving Game.Progress later, progress can be retrieved
--also need to add switches inside the game, so that game isn't bland lmao
--need to make background.lua read movingWall and interactableObject details from Game.Progress
--need to make teleport function
--could i just use loadgame and Game.Progress smartly to make my teleport function?
--lmao jeniyas

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

local Game = {
    Progress = {
        currentRoomName = "Room 1",
        player = {
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
                beginClosed = true,
                isLocked = true,
                dialog = "This wall appears to be different from the other walls.",
            },
            teleports = {
                ["Room 2 teleport"] = {
                    currentRoomName = "Room 2",
                    x = 5*(5*16),
                    y = 5*(5*16),
                    looking = "up"
                }
            }
        },
        ["Room 2"] = {
            door = {
                beginClosed = true,
                flipped_horizontal = true,
                flipped_vertical = false,
                isLocked = false
            },
            teleports = {
                ["Room 1 teleport"] = {
                    currentRoomName = "Room 1",
                    x = 6*(5*16),
                    y = 1*(5*16),
                    looking = "down"
                }
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
    Game.Progress = TableIO.load(savefilename) or Game.Progress
    Game:reloadGame()
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
    local text = nil
    if enteredCollider.name == "chest" or enteredCollider.name == "door" then
        if enteredCollider.isLocked then
            text = enteredCollider.name.."Locked"
        else
            text = enteredCollider.name.."Unlocked"
        end
        text = Game.Dialog[text]
    elseif Game.Progress[Game.Progress.currentRoomName][enteredCollider.name] then
        text = Game.Progress[Game.Progress.currentRoomName][enteredCollider.name].dialog
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
    if key == "x" or key == "return" then
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
        elseif stateStack:Top() == "menu" and menu:MenuTop() ~= "startScreen" then
            stateStack:Pop()
        end
    end
    if stateStack:Top() == "dialogBox" then
        dialogBox:UpdateLine(key)
    end
end

function Game:Update(dt) -- could change isOpening/ isClosing directly from Game:takeInput(key)
    if self.enteredCollider and string.find(self.enteredCollider.name, "teleport") then
        local teleport_details = Game.Progress[Game.Progress.currentRoomName].teleports[self.enteredCollider.name]
        Game.Progress.currentRoomName = teleport_details.currentRoomName
        Game.Progress.player.x = teleport_details.x
        Game.Progress.player.y = teleport_details.y
        Game.Progress.player.looking = teleport_details.looking
        Game:reloadGame()
    end
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
        Game.Progress[Game.Progress.currentRoomName][self.activeObject.name].isLocked = self.activeObject.object.isLocked
        Game.Progress[Game.Progress.currentRoomName][self.activeObject.name].beginClosed = self.activeObject.object.isClosed
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