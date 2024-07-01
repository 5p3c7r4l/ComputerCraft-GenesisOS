local bckColour = colors.black
local menuButtonColour = colors.purple
local taskBarColour = colors.pink
local logoPath = 'Background/logoPath.txt'
local logoPos = 'Background/logoPos.txt'
local currentLogos = {}
local currentLogoPos = {}
local MonW, MonH
local monitor

local gbck = {}

function gbck.findPeripheral()
    local testPeriph = peripheral.getNames()
    local currentDeviceEventListener
    for i=1, #testPeriph do
        if peripheral.getType(testPeriph[i]) == 'monitor' then
            testPeriph = peripheral.getType(testPeriph[i])
            break
        end
    end
    if (testPeriph == 'monitor') then
        monitor = peripheral.find('monitor')
        MonW, MonH = monitor.getSize()
        currentDeviceEventListener = 'monitor_touch'
    else
        monitor = term.current()
        MonW, MonH = monitor.getSize()
        testPeriph = 'computer'
        currentDeviceEventListener = 'mouse_click'
    end
    return MonW,MonH,monitor,testPeriph,currentDeviceEventListener
end

local function listSetup (addLogo)
	for line in io.lines(logoPath) do
		table.insert(currentLogos,line)
	end
	for line in io.lines(logoPos) do
		for y in string.gfind(line,'%d+') do
			table.insert(currentLogoPos, tonumber(y))
		end
	end
end


function gbck.drawBck (addLogo) 
	term.setBackgroundColor(bckColour)
	term.setCursorPos(1,1)
	if (addLogo) then
		listSetup(addLogo)
		local y = 1
		for i=1, #currentLogos do
		local Width = (MonW/2)-currentLogoPos[y]/2
		local Height = (MonH/2)-currentLogoPos[y+1]/2
			paintutils.drawImage(paintutils.loadImage(currentLogos[i]),Width,Height)
			y= y+2
		end
		paintutils.drawFilledBox(1,MonH,4,MonH-1,menuButtonColour)
		paintutils.drawLine(5,MonH,5,MonH-1,colors.gray)
		paintutils.drawLine(6,MonH,MonW+1,MonH,taskBarColour)
	end
end

function gbck.OSLogo (addLogo)
	term.setBackgroundColor(bckColour)
	term.setCursorPos(1,1)
	if (addLogo) then
		listSetup(addLogo)
		local y = 1
		local Width = (MonW/2)-10
		local Height = (MonH/2)-6
		for i=1, #currentLogos do
			paintutils.drawImage(paintutils.loadImage(currentLogos[i]),Width,Height)
			y= y+2
		end
	end
end

function gbck.Shutdown (addLogo)
	term.setBackgroundColor(bckColour)
	term.setCursorPos(1,1)
	if (addLogo) then
		listSetup(addLogo)
		local y = 1
		local Width = (MonW/2)-(45/2)
		local Height = (MonH/2)-8
		paintutils.drawImage(paintutils.loadImage('Background/OS_SHUTDOWN.nfp'),Width,Height)
	end
end

return gbck
