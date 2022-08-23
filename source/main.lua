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
print(values[1])
-- navigation variables
local selected = 1
local edit = -1
local fontNontendoBold2X = gfx.font.new('font/Nontendo-Bold-2x')
local fontNontendoBold8X = gfx.font.new('font/Nontendo-Bold-8x')
local fontNontendoBold6X = gfx.font.new('font/Nontendo-Bold-6x')
--line drawing setup
gfx.setLineCapStyle(gfx.kLineCapStyleRound)
gfx.setLineWidth(5)


function updateScreen()
	hp = values[1]
	cd1 = values[2]
	cd2 = values[3]
	cd3 = values[4]
	gfx.clear()
	gfx.setFont(fontNontendoBold2X)
	gfx.drawText("Life",10,10)
	gfx.setFont(fontNontendoBold6X)
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
	if(selected == 1) then
		gfx.drawLine(125,145,275,145)
	elseif (selected == 2) then
		gfx.drawLine(75,230,125,230)
	elseif (selected == 3) then
		gfx.drawLine(175,230,225,230)
	elseif (selected == 4) then
		gfx.drawLine(275,230,325,230)
	end
	

	--commander damage zone

	gfx.setFont(fontNontendoBold2X)
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
updateScreen()
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
	elseif (pd.buttonJustPressed(pd.kButtonLeft)) and ((selected == 3) or (selected  == 4)) then
		selected -= 1
		edit = -1
		updateScreen()
	elseif (pd.buttonJustPressed(pd.kButtonRight)) and ((selected == 3 ) or (selected == 2)) then
		selected += 1
		edit = -1
		updateScreen()
	elseif (pd.buttonJustPressed(pd.kButtonA)) then
		edit = selected
	elseif (pd.buttonJustPressed(pd.kButtonB)) then
		edit = -1
	end
end

