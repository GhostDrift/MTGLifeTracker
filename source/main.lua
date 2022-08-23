import "Corelibs/sprites"
import "Corelibs/timer"
import "Corelibs/object"
import "Corelibs/crank"
import "Corelibs/ui"
import "Corelibs/graphics"

local pd <const> = playdate
local gfx <const> = pd.graphics

-- value variables
local values = {40,0,0,0}

-- navigation variables
local selected = 1
local edit = -1
local circleChords = {{200,73,55},{101,217,20},{201,217,20},{301,217,20}}
local fontNontendoBoldOutline2X = gfx.font.new('font/Nontendo-Bold-Outline-2x')
local fontNontendoBold8X = gfx.font.new('font/Nontendo-Bold-8x')
local fontNontendoBoldOutline6X = gfx.font.new('font/Nontendo-Bold-outline-6x')
--line drawing setup
gfx.setLineCapStyle(gfx.kLineCapStyleRound)
gfx.setLineWidth(5)


function updateScreen()
	hp = values[1]
	cd1 = values[2]
	cd2 = values[3]
	cd3 = values[4]
	gfx.clear()
	if(edit ~= -1) then
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
	gfx.setFont(fontNontendoBoldOutline2X)
	gfx.drawText("Life",10,10)
	gfx.setFont(fontNontendoBoldOutline6X)
	local hpText = tostring(hp)
	gfx.drawTextAligned(hpText, 200, 40, kTextAlignment.center)
	if(hp <= 40) then
		gfx.drawArc(200,73,60,0,9*hp)
	elseif((hp >40) and (hp <= 80))then
		gfx.drawArc(200,73,60,0,360)
		gfx.drawArc(200,73,63,0,9*(hp-40))
	elseif((hp >80) and (hp <= 120))then
		gfx.drawArc(200,73,60,0,360)
		gfx.drawArc(200,73,63,0,360)
		gfx.drawArc(200,73,66,0,9*(hp-80))
	end
	
	

	--commander damage zone

	gfx.setFont(fontNontendoBoldOutline2X)
	--gfx.drawText("Commander Damage",90,160)
	gfx.drawTextAligned("Commander Damage", 200, 160, kTextAlignment.center)
	gfx.drawRoundRect(10,150,380,170,10)
	gfx.drawTextAligned(cd1, 100, 205, kTextAlignment.center)
	gfx.drawTextAligned(cd2, 200, 205, kTextAlignment.center)
	gfx.drawTextAligned(cd3, 300, 205, kTextAlignment.center)
	--gfx.drawText(cd1, 100,200)
	--gfx.drawText(cd2, 190,200)
	--gfx.drawText(cd3, 280,200)

end
function reset()
	values = {40,0,0,0}
	edit = -1
	updateScreen()
end
function initialize()
	local menu = pd.getSystemMenu()
	local menuItem, error = menu:addMenuItem("Reset Values", function()
		reset()
	end)
	gfx.setImageDrawMode(gfx.kDrawModeCopy)
	updateScreen()
end
initialize()
function playdate.update()
	if pd.buttonJustPressed(pd.kButtonUp) then
		if edit ~= -1 then
			values[selected] += 1
		elseif selected ~= 1 then
			selected = 1
		end
		updateScreen()
	elseif (pd.buttonJustPressed(pd.kButtonDown)) and (selected == 1) then
		if edit ~= -1 then
			values[selected] -= 1
		else
			selected = 3
		end
		updateScreen()
	elseif (pd.buttonJustPressed(pd.kButtonLeft)) then
		if selected == 1 then
			selected = 2
		elseif (selected == 3) or (selected == 4) then 
		selected -= 1
		end
		edit = -1
		updateScreen()
	elseif (pd.buttonJustPressed(pd.kButtonRight)) then
		if selected == 1 then
			selected = 4
		elseif (selected == 3) or (selected == 2) then
			selected += 1
		end
		edit = -1
		updateScreen()
	elseif (pd.buttonJustPressed(pd.kButtonA)) then
		edit = selected
		updateScreen()
	elseif (pd.buttonJustPressed(pd.kButtonB)) then
		edit = -1
		updateScreen()
	end
end

