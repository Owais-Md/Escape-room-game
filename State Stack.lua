--Makes stateStack such that only top of stack can accept inputs in the game, but all of the states in the state stack get rendered

StateStack = {}

function StateStack:getStateStack()
    local stateStack = {}
    setmetatable(stateStack, self)
    self.__index = self
    return stateStack
end

function StateStack:push(state)

end

function  StateStack:top()
    
end

function StateStack:pop()
    
end

function StateStack:update(dt)

end

return StateStack