------------
--APP SIDE--
------------
local JSON = require('/Library.JSONParser')
local mon = require('/Library.monitor')

local flag = '0x00'
local arg = '0x00'
local MonW,MonH = term.getSize(term.current())
local API = 'https://httpcats.com/101.json'


local function args (arg,message)
    if (arg == '200') then
        return arg
    else
        error(arg .. ': ' .. message)
        return arg
    end
end

local function flags (flag)
    if (flag == nil) then
        return '0x80'
    else
        return '0x10'
    end
end



local function download (name)
end

local function uninstall (name)
end

local function search (name)
end


local function update (list)
	local applist = http.get(list)

	if (applist == nil) then
		return applist
	else
		currentlist = io.input('Apps/storeapplist.json'):read('a')
        return JSON.parse(currentlist,2)
	end
end


local function load ()
	local list = update(API)
	if (list == nil) then
        print(list)
		return list, '404', "Couldn't find the list"
	else
		print(list)
        return list, '200', 'OK'
	end

end


local App = {
	['dwnl'] = download,
	['unin'] = uninstall,
	['srch'] = search,
	['load'] = load,
}


local function main (arg,flag)
    local apps = {}
    local msg,userInput,event,x,y

    apps,arg,msg = App['load']()

    repeat
    arg = args(arg,msg)
    flag = flags(apps)
    event, userInput, x, y = os.pullEvent('monitor_touch')
        if (flag == '0x10') then
            print('enter program')
            for i,j in pairs(apps) do 
                print(i)
            end

            print(event,userInput,x,y)
        elseif(flag == '0x80') then
            return arg
        end
    until flag == '0x80'

end

main(arg,flag)
