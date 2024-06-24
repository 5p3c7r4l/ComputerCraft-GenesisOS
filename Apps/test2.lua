local gbck = require('/Library.gbck')
local Utils = require('/Library.appbuilder')

local useState = Utils.useState
local MonW,MonH,monitor = gbck.findPeripheral()
local appstate = useState(false)
local firstboot = true
local event, handle, x, y

term.setBackgroundColor(colours.black)
term.setTextColor(colours.white)


local shutdown = (function()
    term.setCursorPos(1,1)
    appstate = useState(true)
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
        event, handle, x, y = os.pullEvent('monitor_touch')
    end
    Utils.button(x,y,1,5,MonH+1,MonH-2,colors.purple,eventListener['shutdown'],nil,'hello')
until appstate.state

shell.exit()
