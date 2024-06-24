local mon = require('/Library.monitor')

local Utils = {}

Utils.usestate = {
    state = nil,
    setState = (function(args)
        Utils.usestate.state = args
    end)}
Utils.metatable = {
    __index = Utils.usestate
}

function Utils.useState(argument)
    local t = {}
    setmetatable(t, Utils.metatable)
    t.setState(argument)
    return t
end

function Utils.button (x,y,xCor1,xCor2,yCor1,yCor2,colour,Callback,iCallback,textarea,txtcolor)
    mon.area(x,y,xCor1,xCor2,yCor1,yCor2,Callback,iCallback)
    paintutils.drawFilledBox(xCor1,yCor1,xCor2,yCor2,colour)
    if (txtcolor == nil) then
        term.setTextColor(colors.white)
    else
        term.setTextColor(txtcolor)
    end
    term.setCursorPos(xCor1,yCor1-1)
    term.write(textarea)
end

return Utils
