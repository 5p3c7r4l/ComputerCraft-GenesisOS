local periph = require("/root/lib/peripherals")

hud = periph.new({})
valper = hud.validperiph[1]
valper.setBackgroundColor(1)
valper.setTextScale(0.5)

local visualHUD = {}
visualHUD.prototype = {}

local setDefaultWindow = function()
    settings.define("windowWidth", {
        description = "default window width",
        default = 40,
        type = "number"
    })
    settings.define("windowHeight",{
        description = "default window height",
        default = 10,
        type = "number"
    })
end

visualHUD.prototype.usedPeriph = valper
visualHUD.prototype.instancedWindows = {}
visualHUD.prototype.newWindowInstance = function(env,cpX,cpY,Width,Height,path,title)
    if not env then error("ERROR: Must provide a valid environnement to create a window", 2) end
    if not path then error("ERROR: Must provide a valid path to create a window", 2) end
    
    local curWindow = {}
    curWindow._G = _G
    curWindow.window = window
    curWindow.colors = colors
    curWindow.multishell = multishell 
    curWindow.settings = settings
    curWindow.require = require
    curWindow.os = os
    curWindow.shell = shell
    
    curWindow.windowDim = {}
    curWindow.windowDim.cpX = cpX
    curWindow.windowDim.cpY = cpY
    curWindow.windowDim.width = Width
    curWindow.windowDim.height = Height
    
    curWindow.env = env
    
    
    setmetatable(env, {__index = env}) 
    setfenv(1, curWindow)
    
    _W = curWindow
    
    _W.bar = _W.window.create(env,cpX,cpY,Width,1)
    _W.instance = _W.window.create(env ,cpX,cpY+1,Width,Height)
    
    _W.bar.setBackgroundColor(colors.blue)
    _W.bar.clear()
    
    _W.instancedWindow =  multishell.launch(curWindow,path)
    multishell.setTitle(_W.instancedWindow, title)
    
    _W.instancedWindowBar = multishell.launch(curWindow ,"/root/lib/barhandle.lua")
    
    table.insert(visualHUD.prototype.instancedWindows,{true,_W.instancedWindow,_W.instancedWindowBar})
end

visualHUD.prototype.redrawWindow = function(truthTable)
    if truthTable[1] then
        truthTable[2].redraw()
        truthTable[3].redraw()
    end
end

visualHUD.mt = {}
visualHUD.new= function(env)
    if not env then error("no environement provided, ERROR:0X02") end
    setmetatable(env, visualHUD.mt)
    return env
end
visualHUD.mt.__index = function(table,key)
    return visualHUD.prototype[key]
end

return visualHUD
