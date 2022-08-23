import "Corelibs/sprites"
import "Corelibs/timer"
import "Corelibs/object"
import "Corelibs/crank"
import "Corelibs/ui"
import "Corelibs/graphics"

local pd <const> = playdate
local gfx <const> = pd.graphics
local fnt <const> = gfx.font
local hp = 40
local cd = 20
local fontNontendoBold2X = gfx.font.new('font/Nontendo-Bold-2x')
local fontNontendoBold8X = gfx.font.new('font/Nontendo-Bold-8x')
function updateScreen()
	gfx.clear()
	gfx.setFont(fontNontendoBold2X)
	gfx.drawText("Life",10,10)
	gfx.setFont(fontNontendoBold8X)
	local hpText = tostring(hp)
	--local textWidth = fontNontendoBold8X:getTextWidth(cellText)
	--local cellRadius = textWidth /1.4
	--gfx.drawCircleAtPoint(195,65,cellRadius)
	gfx.drawText(hpText,150,25)
	gfx.setFont(fontNontendoBold2X)
	gfx.drawText("Commander Damage",90,140)
	
	gfx.drawText(cd, 120,180)
	gfx.drawText(cd, 180,180)
	gfx.drawText(cd, 240,180)

end
updateScreen()
function playdate.update()
	if pd.buttonJustPressed(pd.kButtonUp) then
		cellNumber += 1
		updateScreen()
	elseif pd.buttonJustPressed(pd.kButtonDown) then
		cellNumber -= 1
		updateScreen()
	end
end

