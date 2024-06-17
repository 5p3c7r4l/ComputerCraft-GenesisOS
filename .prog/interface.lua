local function connect (item)
    currentPeriph = peripheral.find(item)
    currentPeriph.setCursorPos(1,1)
    currentPeriph.clear()
    currentPeriph.clearLine()
    currentPeriph.setBackgroundColor(colors.black)
    currentPeriph.setTextColor(colors.white)
    currentPeriph.setCursorPos(1,1)
    return currentPeriph
end

local function screen (args)
    os.run({},"OS.lua")
end



peripheralInfo = {
    ['connect'] = connect, 
}
local eventHandler = {
    ['monitor'] = screen,
}


function main (args, flags)
    if (flags == nil) then
        flags = '__main__'
    end
    if (args == nil) then
        args = 'monitor'
    end
    
    if (flags == '__main__') then 
        _start(args,flags)
    end
end



function _start(args,flags)
    _start_loop(args,flags)    
end

function _start_loop(args,flags)
    if (args == 'monitor') then        
        eventHandler['monitor'](args)
    end    
end


main(nil,nil)
