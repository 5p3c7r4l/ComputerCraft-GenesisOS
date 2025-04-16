local visualHUD = require("/root/lib/hud")
local periph = require("/root/lib/peripherals")
local flagify = require("/root/lib/flagify").new({})

local hud = periph.new({})
local valper = hud.validperiph[1]
valper.setBackgroundColor(1)
valper.setTextScale(0.5)
valper.clear()
local periphSize = hud.sizeofperiph(valper,1)

local windowHandler = visualHUD.new({})
local appPath = fs.find("/root/usr/share/applications/desk/*") 
local appIcoPath = fs.find("/root/usr/share/icons/hicolor")
local appList = {}


local DEmanager = {}
DEmanager.prototype = {}

DEmanager.prototype.showAppIco = function(env,path)
    if not env then error("ERROR: A valild environnement must be provided",2) end
    if not path and type(path) == "table" then error("ERROR: A valid list of path must be provided",2) end
    local tmpPos = {2,2}
    env.setBackgroundColor(1)
    env.clear()
    
    for i, e in pairs(path) do
        local tmpReq = require(string.gsub(path[i],".lua",""))
        local tmpApp = tmpReq.new({})

        env.setCursorPos(tmpPos[1],tmpPos[2])
        env.width = tmpPos[1]
        env.height = tmpPos[2]
        
        multishell.launch(env,tmpApp.icone)
        
        appList[i] = {tmpApp.path, tmpPos[1], tmpPos[2], tmpApp.name}
        
        if tmpPos[1] + 7 > periphSize[1].width then 
            tmpPos[1] = 2
            tmpPos[2] = tpmPos[2] + 6
        else
            tmpPos[1] = tmpPos[1] + 7
        end
    end 
end

DEmanager.prototype.launchApp = function(env, x, y)    
    for i, e in pairs(appList) do
        if x < appList[i][2]+7 and x > appList[i][2]-1 and y > appList[i][3]-1 and y < appList[i][3]+5 then 
            windowHandler.newWindowInstance(env,1,1,40,20,appList[i][1],appList[i][4])
        end
    end
end

DEmanager.mt = {}
DEmanager.new = function(env) 
    if not env then
        error("ERROR: No base environnement provided for the Desktop Environnement",2)
    end
    setmetatable(env, DEmanager.mt) 
end
DEmanager.mt.__index = function(table, key) return DEmanager.prototype[key] end

--while(true) do
DEmanager.prototype.showAppIco(valper,appPath)
flagify.warning("this")
write("that")

while(true) do
    local event, flag, x, y = os.pullEvent("monitor_touch")
    DEmanager.prototype.launchApp(valper, x, y)
end

--Need to rerender only after a window is closed
