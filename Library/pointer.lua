local ptr = {}

parent {
    name = '',
    value = nil,
    setPointer = (function(var, val) 
        parent.name = var
        parent.value = val
    end),
    child {
        names = {},
        setName = (function(var)
            table.insert(parent.child.name,{var,parent.value})

        end),
        value = nil,
        setValue = (function()
            parent.child.value = parent.value
        end)
    }
}

local parentMetatable = {
    __index = parent
}

local childMetatable = {
    __index = parent.child.value,
    __mode = 'v'
}


setmetatable(parent, parentMetatable )
setmetatable(parent.child,childMetatable)

function ptr.w(var)
    
    return var
end

function ptr.r(var)

    return var
end

return ptr
