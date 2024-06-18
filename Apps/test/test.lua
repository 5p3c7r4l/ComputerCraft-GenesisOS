local mon = require('Library.monitor')
local 

repeat
    print('OK')
    local event, command, x, y = os.pullEvent('monitor')
    mon.space(x,y,1,)
until
