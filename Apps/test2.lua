local gbck = require('/Library.gbck')
local Utils = require('/Library.appbuilder')


local MonW,MonH,monitor,peripheral,currentDEL = gbck.findPeripheral()
local appstate = Utils.useState(false)
local firstboot = true
local event, handle, x, y

term.setBackgroundColor(colours.black)


term.setBackgroundColor(colours.black)
term.setTextColor(colours.white)

local shutdown = (function()
    term.setCursorPos(1,1)
    appstate.setState(true)
    term.setBackgroundColor(colors.black)
    term.clear()
end)

local co = coroutine.create(function()
    local pixel = {true, false, true, true, false, true}
    gbck.HDpixel(pixel,3,3,colors.white, colors.red)
    coroutine.yield()
end)


local eventListener = {
    ['shutdown'] = shutdown,
    ['cr'] = coroutine.resume
}

repeat
    if firstboot then
        firstboot = false
    else
        eventListener['cr'](co)
        event, handle, x, y = os.pullEvent(currentDEL)
        --eventListener['shutdown']()
        term.setCursorPos(1,1)
        paintutils.drawPixel(x,y,colours.white)
    end
    Utils.button(x,y,1,5,MonH+1,MonH-2,colors.purple,eventListener['shutdown'],nil,'hello')
until appstate.state

shell.exit()
