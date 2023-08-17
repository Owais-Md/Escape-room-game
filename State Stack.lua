--Makes stateStack such that only top of stack can accept inputs in the game, but all of the states in the state stack get rendered

local StateStack = {}

function StateStack:getStateStack()
    local stateStack = {}
    setmetatable(stateStack, self)
    self.__index = self
    return stateStack
end

function StateStack:push(state)
    table.insert(self, state)
end

function  StateStack:top()
    return self[#self]
end

function StateStack:pop()
    table.remove(self, #self)
end

return StateStack