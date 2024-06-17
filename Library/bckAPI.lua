local bckColour = colors.black
local menuButtonColour = colors.purple
local taskBarColour = colors.pink
local logoPath = 'Background/logoPath.txt'
local logoPos = 'Background/logoPos.txt'
local currentLogos = {}
local currentLogoPos = {}
local MonW, MonH = peripheral.find('monitor').getSize()

local gbck = {}

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
		local Width = MonW/(currentLogoPos[y]/100)
		local Height = MonH/(currentLogoPos[y+1]/100)
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
		local Width = MonW/(280/100)
		local Height = MonH/(300/100)
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
		local Width = MonW/(575/100)
		local Height = MonH/(450/100)
		paintutils.drawImage(paintutils.loadImage('Background/OS_SHUTDOWN.nfp'),Width,Height)
	end
end

return gbck
