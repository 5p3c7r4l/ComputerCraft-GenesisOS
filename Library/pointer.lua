PointerNum = 1
PointerIDs = {}


local ptr = {}

Parent = {
    name = nil,
    setPointer = (function(val)
        table.insert(Parent.child.value, val)
    end),
    child = {
        pointerIncrement = 0,
        setPointerIncrement = (function()
            Parent.child.pointerIncrement = Parent.child.pointerIncrement + 1
        end),
        names = {},
        setName = (function()
            table.insert(Parent.child.names,Parent.child.pointerIncrement)
            Parent.child.setPointerIncrement()
            return Parent.child.names[Parent.child.pointerIncrement]
        end),
        value = {},
    }
}

local ParentMetatable = {
    __index = Parent
}

--local childMetatable = {
--    __index = Parent.child.value,
--    __mode = 'v'
--}


--Script -> main use is to increment the current pointer to always have a place in memory to store the next one
--          while also returning the correct index of the pointer

local s = (function(tab)
    table.insert(PointerIDs,PointerNum)
    tab.name = PointerIDs[PointerNum]
    PointerNum = PointerNum + 1
    return tab
end)

--Pointer.Write -> main use is to setup a pointer value

function ptr.w(val)
    local t = {}
    setmetatable(t, ParentMetatable)
    t.setPointer(val)
    return s(t)
end

--Pointer.Point -> main use is to have a table that has 3 values, 
--the pointer id, the parent pointer id, the value it's pointing at

function ptr.p(tab)
    tab.child.setName()
    return {tab.child.names[tab.child.pointerIncrement], tab.name,tab.child.value[tab.name]}
end

--Pointer.Read -> main use is to read the value pointed at
function ptr.r(tab)
    if tab.name == nil then
        return tab[3]
    else
        return tab.child.value[tab.name]
    end
end

--local e = ptr.w(10)
--local d = ptr.w(30)
--
--local f = ptr.p(e)
--local g = ptr.p(d)
--local h = ptr.p(d)
--local i = ptr.p(d)
--
--print(e.name)
--print(d.name)
--print(f[1],f[2],f[3])
--print(g[1],g[2],g[3])
--print(ptr.r(d))

return ptr
