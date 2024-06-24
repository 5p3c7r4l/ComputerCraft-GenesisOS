local gbck = require('Library.gbck')
local mon = require('Library.monitor')


local MonW, MonH, monitor, peripheral = gbck.findPeripheral()
local currentListApp = {}
currentBCK = "Background/OS_BCK.nfp"
local opennedTab = 1
local Boot = false
local shutdown = false
local shutdownImg = paintutils.loadImage('Background/OS_SHUTDOWN.nfp')
local onBootImg = paintutils.loadImage('Background/OS_STARTUP.nfp')
local amountProcess = 1
local bckLogo = true
local rerender = true

local onBoot = (function()
    term.setBackgroundColor(colors.black)
    term.clear()
    gbck.OSLogo(true)
    local processing = 1
    local loadbarX = 1
    os.sleep(1)
    while (processing <= amountProcess) do
        for i=loadbarX, (processing/amountProcess*100) do 
        paintutils.drawPixel(i*(MonW/100),1,colors.gray)
        paintutils.drawPixel((i-1)*(MonW/100),1,colors.purple)
        paintutils.drawPixel(i*(MonW/100),2,colors.magenta)
        loadbarX = loadbarX + 1
        end
        os.sleep(0.05)
        processing = processing + 1
    end 
    os.sleep(0.25)
    term.setCursorPos(1,MonH)
    term.setBackgroundColor(colors.black)
    term.setTextColor(colors.white)
    term.write('Welcome =D')
    os.sleep(1)
    term.setCursorPos(1,1)
end)


local function isBooted ()
    rerender = true
    Boot = true
end


local function desktopBoot ()
    AppLoad()
    monitor.setCursorPos(1,1)
    local i = 0
    for line in io.lines('Apps/applist.txt') do
        currentListApp[i] = line
        i = i+1
    end
    i = 0
end


function AppLoad ()
    monitor.setCursorPos(1,1)
    if (rerender) then
        paintutils.drawFilledBox(1,1,MonW+2,MonH+2,colors.black)
        gbck.drawBck(bckLogo)
        Icons()
        rerender = false
    end
    AppPath()
    if Boot then
        if (peripheral == 'monitor') then
            event, flag, x, y = os.pullEvent('monitor_touch')
        else
            event, flag, x, y = os.pullEvent('mouse_click')
        end
    end
end

AppPath = (function()
    local currX = 1
    local currY = 1

    for i=0, #currentListApp do
        if (x and y) then
            if (x >= currX and x <= currX+3 and y >= currY and y <= currY+2) then
                if (currentListApp[i] == nil) then
                else
                    rerender = true
                    window.create(term.current(),1,1,MonW,MonH)
                    shell.run(currentListApp[i])
                end
            end
        end
        currX = currX + 5
        if (currX > MonW-2) then
            currY = currY + 3
            currX = 1
        end
    end
end)


local function shutdownEvent ()

    local content = (function()
        shutdown = true
        term.setBackgroundColor(colors.black)
        term.clear()
        term.setCursorPos(1,1)
	gbck.Shutdown(true)
        os.sleep(2)
    end)

    if x == nil then
    else
        if ( x>=1 and x <= 3 and y >= MonH-1 and y <= MonH) then 
            content()
        end
    end
end

Icons = (function()
    local currX = 1
    local currY = 1
    for i=0, #currentListApp do
        paintutils.drawFilledBox(currX,currY,currX+3,currY+2, colors.white)
        currX = currX + 5
        if (currX > MonW) then
            currY = currY + 3
            currX = 1
        end
    end
end)

local function newApp(AppPath)
    io.output('Apps/applist'):write(AppPath)
end


local EventHandler = {
    ['onBoot'] = onBoot,
    ['isBooted'] = isBooted,
    ['shutdown'] = shutdownEvent,
}

local Apps = {
    ['load_apps'] = AppLoad,
    ['applist'] = currentListApp,
    ['makeApp'] = newApp
}

local main = (function(options)

    local content = (function()
            Apps['load_apps']()
            EventHandler['shutdown']()
    end)

    term.redirect(monitor)
    desktopBoot()
    EventHandler['onBoot']()
    EventHandler['isBooted']()
    if (options == 'debug') then
        term.setBackgroundColor(colors.black)
        repeat
            term.setBackgroundColor(colors.black)
            term.setCursorPos(1,MonH-4)
            print("current touch:",event, flag, x, y )
            print('Press Any Key to reset')
            content()
        until shutdown
    else
        repeat
            content()
        until shutdown
    end
    term.setBackgroundColor(colors.black)
    term.clear()
    os.shutdown()
end)
main()
