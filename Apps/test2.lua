local gbck = require('/Library.gbck')
local Utils = require('/Library.appbuilder')

local MonW,MonH,monitor,peripheral,currentDEL = gbck.findPeripheral()
local appstate = Utils.useState(false)
local firstboot = true
local event, handle, x, y

term.setBackgroundColor(colours.black)
term.setTextColor(colours.white)


local shutdown = (function()
    term.setCursorPos(1,1)
    appstate.setState(true)
    term.setBackgroundColor(colors.black)
    term.clear()
end)

local co = coroutine.create(function()
    print('using coroutine')
    coroutine.yield()
end)


local eventListener = {
    ['shutdown'] = shutdown,
    ['cr'] = coroutine.resume
}

repeat
    eventListener['cr'](co)
    if firstboot then
        firstboot = false
    else
        local event2, handle2, x2, y2 = os.pullEvent('mouse_drag')
        print(handle,event,x,y)
        print(handle2,event2,x2,y2)
    end
    Utils.button(x,y,1,5,MonH+1,MonH-2,colors.purple,eventListener['shutdown'],nil,'hello')
until appstate.state

shell.exit()
