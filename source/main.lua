import "Corelibs/sprites"
import "Corelibs/timer"
import "Corelibs/object"
import "Corelibs/crank"
import "Corelibs/ui"
import "Corelibs/graphics"
import "Note"

local pd <const> = playdate
local gfx <const> = pd.graphics
local snd = pd.sound

--sounds
local sounds = {}

-- value variables
local values = {40,0,0,0}
-- navigation variables
local selected = 1
local edit = false
local circleChords = {{200,73,55},{101,217,20},{201,217,20},{301,217,20}}
local fontNontendoBoldOutline2X = gfx.font.new('font/Nontendo-Bold-Outline-2x')
local fontNontendoBoldOutline6X = gfx.font.new('font/Nontendo-Bold-outline-6x')
local docked = nil
gfx.setLineCapStyle(gfx.kLineCapStyleRound)
gfx.setLineWidth(5)
-- function to initialize sounds
local function initializeSounds()
	sounds[1] = playdate.sound.fileplayer.new("sounds/CongaHi")
	sounds[2] = playdate.sound.fileplayer.new("sounds/Rimshot")
	sounds[3] = playdate.sound.fileplayer.new("sounds/CongaLow")
	sounds[4] = playdate.sound.fileplayer.new("sounds/CongaMid")
	sounds[5] = playdate.sound.fileplayer.new("sounds/Maraca")
	sounds[6] = Note(0,0.2,0.2,0.43,1000,0.1,0.5,snd.kWaveNoise)
end
--function to update the edit value
function editing(value)
	if edit ~= value then
		edit = value
		if edit == false then
			sounds[4]:play()
		else
			sounds[1]:play()
		end
	end
end
--function to draw the hp circles
function drawHPCircle(hp)
	local numberOfCircles = math.floor((hp/40)) - 1
	local radius = 60
	local x = 200
	local y = 73
	if hp > 40 then
		if(hp % 40) == 0 then
			numberOfCircles -= 1
		end
		for i = 0,numberOfCircles,1 do
			gfx.drawCircleAtPoint(x,y,radius)
			radius += 3
		end
	end
	gfx.drawArc(x,y,radius,0,9*hp)
end
function updateScreen()
	hp = values[1]
	cd1 = values[2]
	cd2 = values[3]
	cd3 = values[4]
	gfx.clear()
	--draw the circles that represent the hp value
	if hp > 0 then
		drawHPCircle(hp)
	end
	--draw the hp area
	gfx.setFont(fontNontendoBoldOutline2X)
	gfx.drawText("Life",10,10)

	--commander damage zone
	gfx.setColor(gfx.kColorWhite)
	gfx.fillRoundRect(10,150,380,170,10)
	gfx.setColor(gfx.kColorBlack)
	gfx.drawRoundRect(10,150,380,170,10) -- x,y,w,h,raduis
	gfx.drawTextAligned("Commander Damage", 200, 160, kTextAlignment.center)

	-- draw the selected ui elements
	if(edit) then
		gfx.fillCircleAtPoint(circleChords[selected][1],circleChords[selected][2],circleChords[selected][3])
	elseif(selected == 1) then
		gfx.drawLine(125,145,275,145)
	elseif (selected == 2) then
		gfx.drawLine(75,231,125,231)
	elseif (selected == 3) then
		gfx.drawLine(175,231,225,231)
	elseif (selected == 4) then
		gfx.drawLine(275,231,325,231)
	end

	-- draw values
	gfx.drawTextAligned(cd1, 100, 205, kTextAlignment.center)
	gfx.drawTextAligned(cd2, 200, 205, kTextAlignment.center)
	gfx.drawTextAligned(cd3, 300, 205, kTextAlignment.center)
	gfx.setFont(fontNontendoBoldOutline6X)
	local hpText = tostring(hp)
	gfx.drawTextAligned(hpText, 200, 40, kTextAlignment.center)

end
function reset()
	values = {40,0,0,0}
	updateScreen()
	sounds[6]:play()
end
function initialize()
	initializeSounds()
	local menu = pd.getSystemMenu()
	local menuItem, error = menu:addMenuItem("Reset Values", function()
		reset()
	end)
	docked = pd.isCrankDocked()
	if not docked then
		editing(true)
	end
	gfx.setImageDrawMode(gfx.kDrawModeCopy)
	updateScreen()
end
--UI functions
function pd.crankDocked()
	docked = true
	updateScreen()
end
function pd.crankUndocked()
	editing(true)
	docked = false
	updateScreen()
end
function pd.cranked()
	if edit then
		changeValue(pd.getCrankTicks(20))
		updateScreen()
	end
end	
function changeValue(increment)
	if increment ~= 0 then
	values[selected] += increment
	sounds[2]:play()
	end
end	
function moveUp()
	if selected ~= 1 then
		selected = 1
	end
end
function moveDown()
	if selected == 1 then 
		selected = 3
	end
end
function moveLeft()
	if selected == 1 then
		selected = 2
	elseif (selected == 3) or (selected == 4) then 
	selected -= 1
	end
end
function moveRight()
	if selected == 1 then
		selected = 4
	elseif (selected == 3) or (selected == 2) then
		selected += 1
	end
end

initialize()
function playdate.update()
	if not docked then
		local ticks = pd.getCrankTicks(20)
	end
	if pd.buttonJustPressed(pd.kButtonUp) then
		if docked then
			if edit then
				changeValue(1)
			else
				moveUp()
			end
		else
			moveUp()
		end
		updateScreen()
	elseif (pd.buttonJustPressed(pd.kButtonDown))then
		if docked then
			if edit then
				changeValue(-1)
			else
				moveDown()
			end
		else
			moveDown()
		end
		updateScreen()
	elseif (pd.buttonJustPressed(pd.kButtonLeft)) then
		if docked then
			editing(false)
		end
		moveLeft()
		updateScreen()
	elseif (pd.buttonJustPressed(pd.kButtonRight)) then
		if docked then
			editing(false)
		end
		moveRight()
		updateScreen()
	elseif (pd.buttonJustPressed(pd.kButtonA)) then
		editing(true)
		updateScreen()
	elseif (pd.buttonJustPressed(pd.kButtonB)) then
		editing(false)
		updateScreen()
	end
end

