local MonW, MonH, monitor, peripheral, currentDEL = require('/Library.gbck')

local window = {}

function window.create(handle,msg,values,pointer)
end

function window.createHandle(WindowClass,WindowTitle,sizeX,sizeY)
    local win = coroutine.create(function ()

    end)
    return win
end

return window
