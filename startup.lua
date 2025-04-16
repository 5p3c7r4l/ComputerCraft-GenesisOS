local r = require "cc.require"
local env = setmetatable({},{__index = _ENV})
env.require, env.package = r.make(env, "/")
env.multishell = multishell
env.shell = shell
env.term = term
env.window = window
env.module = module
env.os = os

local _VIEW_TYPE = nil
local _SYSTEM_SETTINGS = {}
_EXPORTED_SETTINGS = _SYSTEM_SETTINGS
local _BOOT_FLAGS = {}

local curScreen = function()
    local directionTable = {"top","bottom","left","right","front","back"}   
    for i, e in  pairs(directionTable) do
        if (not (peripheral.wrap(directionTable[i]) == nil)) then
            _VIEW_TYPE = peripheral.wrap(directionTable[i])
            table.insert(_EXPORTED_SETTINGS, directionTable[i])
            table.insert(_BOOT_FLAGS, "0X01")  
        end      
    end
     if (not _VIEW_TYPE) then
        _G.write("A screen wasn't found: Continuing in docked mode")
        _G.write("Initializing portable view \n")
        _G._CC_DEFAULT_SETTINGS = _G._CC_DEFAULT_SETTINGS .. ""
        table.insert(_BOOT_FLAGS, "0X00")
        return 0
    end
    if (_VIEW_TYPE) then
        _G.write("Initializing desktop view \n")
        _G._CC_DEFAULT_SETTINGS = _G._CC_DEFAULT_SETTINGS .. ""
        return 1
    end
    printError("An error occured while trying to chose the screen, ERROR: 1")
end

local devBootSettings = function(option) 
    if(not option) then return 0 end
    if (option == "D") then
        file = io.open("/root/var/log/onBoot" .. os.date("%m-%d-%H-%M-%S") .. ".txt", "w")
        io.output(file)
        io.write([[Screen: ]])
        for i, e in pairs(_EXPORTED_SETTINGS) do io.write(peripheral.getType(_VIEW_TYPE) .. " [" .. _EXPORTED_SETTINGS[i] .. "]" .. "\n") end
        io.write([[BootFlags: ]])
        for i, e in pairs(_BOOT_FLAGS) do io.write(_BOOT_FLAGS[i]) end
        io.close(file)
    end
    return 1
end

local onBoot = function()
    _VIEW_TYPE.clear()
    shell.setDir("./root")
    local mainInstance = multishell.launch(env,"/root/lib/kekcidicDE.lua")
    multishell.setTitle(mainInstance,"GraphicsPart")    
    shell.switchTab((mainInstance))
end

local defineSettings = function()
    settings.define("bootRaisedFlags", {
        description = "all raised flags during the boot sequence",
        default = _BOOT_FLAGS,
        type = "table"
    })
    settings.define("activeView", {
        description = "the current screen type",
        default = _EXPORTED_SETTINGS,
        type = "table"
    })
    settings.define("luaVersion", {
        description = "current Lua version",
        default = _VERSION,
        type = "number"
    })
    settings.save()
    return 1
end

curScreen()
devBootSettings("D")
defineSettings()
print(settings.get("activeView")) 
onBoot()
