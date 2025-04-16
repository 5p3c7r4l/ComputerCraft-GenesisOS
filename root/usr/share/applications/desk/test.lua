local test = {}
test.prototype = {}

local ico = function()
    print("foo")
    return "this" 
end

test.prototype.name = "test"
test.prototype.path = "/root/lib/test/test.lua"
test.prototype.icone = "/root/usr/share/icons/hicolor/ico/test.lua"

test.mt = {}
test.new = function(env) 
    if not type(env) == "table" then error("ERROR: must provide an environnement",2) end
    setmetatable(env, test.mt) 
    return env
end

test.mt.__index = function(table, key)
    return test.prototype[key]
end

return test
