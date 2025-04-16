local periph = {}
periph.prototype = {}

local validPeriph = function()
    if not settings.get("activeView") then error("activeView does not contain any parameters", 2) end
    local tmp = {}
    for i, e in pairs(settings.get("activeView")) do 
        table.insert(tmp, peripheral.wrap(e))
    end
    
    return tmp
end

periph.prototype.sizeofperiph = function(element,optIndex)
    if not element then error("ERROR: must provide a valid table value",2) end
    if not optIndex and type(optIndex) == "number" then error("ERROR: must provide a valid starting index",2) end
    local tmp = {}
    if peripheral.getType(element) == "monitor" then
        tmp[optIndex] = {}
        tmp[optIndex].width, tmp[optIndex].height = element.getSize()
        return tmp
    end
    if type(element) == "table" then
        for i, e in pairs(table) do
            if peripheral.getType(element[i]) == "monitor" then
            tmp[optIndex+(i-1)].width, tmp[optIndex+(i-1)].height = element[i].getSize()
            end
        end
        return tmp
    end
end

periph.prototype.validperiph = validPeriph()
periph.prototype.entries = settings.get("activeView")

periph.mt = {}
periph.new = function(env)
    if not env then error("ERROR: no environnement provided",2) end
    setmetatable(env, periph.mt)
    return env 
end 
periph.mt.__index = function(table,key)
    return periph.prototype[key]
end 

return periph
