--Makes stateStack such that only top of stack can accept inputs in the game, but all of the states in the state stack get rendered

local StateStack = {}

function StateStack:getStateStack()
    local stateStack = {}
    setmetatable(stateStack, self)
    self.__index = self
    return stateStack
end

function StateStack:Push(...)
    for _, state in ipairs({...}) do
        table.insert(self, state)
    end
end

function  StateStack:Top()
    if #self > 0 then
        return self[#self]
    else
        return nil
    end
end

function StateStack:Pop()
    if #self > 0 then
        table.remove(self, #self)
    end
end

return StateStack