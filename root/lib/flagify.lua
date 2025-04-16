local flagify = {}
flagify.prototype = {}
--make a list of all running apps and their status
--make a function to interact with the list
--make function that would tell to rerender
flagify.prototype.warning = function(msg)
    local tmpRead = term.getTextColor()
    term.setTextColor(2)
    term.write(debug.getinfo(2,"S").source:sub(2) .. " ")
    term.write("Line:" .. debug.getinfo(2).currentline .. " ")
    term.write("[WARNING]: " .. msg)
    term.setTextColor(tmpRead)
end

flagify.prototype.listofrunning = {}
flagify.prototype.addtolist = function()

end

flagify.prototype.openWindow = function ()
end

flagify.prototype.rerender = function(env)
    
end


flagify.mt = {}
flagify.new = function(env)
    if not env then return error("ERROR: Must provide an environnement",2) end
    setmetatable(env,flagify.mt)
    return env
end
flagify.mt.__index = function(table, key)
    return flagify.prototype[key]
end
return flagify
