import "Corelibs/sprites"
import "Corelibs/timer"
import "Corelibs/object"
import "Corelibs/crank"
import "Corelibs/ui"
import "Corelibs/graphics"

local pd <const> = playdate
local gfx <const> = pd.graphics
local hp = 40
local cd1 = 0
local cd2 = 0
local cd3 = 0
local fontNontendoBold2X = gfx.font.new('font/Nontendo-Bold-2x')
local fontNontendoBold8X = gfx.font.new('font/Nontendo-Bold-8x')
local fontNontendoBold6X = gfx.font.new('font/Nontendo-Bold-6x')
--line drawing setup
gfx.setLineCapStyle(gfx.kLineCapStyleRound)
gfx.setLineWidth(5)

function updateScreen()
	gfx.clear()
	gfx.setFont(fontNontendoBold2X)
	gfx.drawText("Life",10,10)
	gfx.setFont(fontNontendoBold6X)
	local hpText = tostring(hp)
	gfx.drawTextAligned(hpText, 200, 30, kTextAlignment.center)
	--gfx.drawText(hpText, 160,30)
	--gfx.drawLine(125,115,275,115)

	--commander damage zone

	gfx.setFont(fontNontendoBold2X)
	gfx.drawText("Commander Damage",90,140)
	gfx.drawRoundRect(10,130,380,170,10)
	gfx.drawText(cd1, 100,190)
	gfx.drawText(cd2, 190,190)
	gfx.drawText(cd3, 280,190)

end
updateScreen()
function playdate.update()
	if pd.buttonJustPressed(pd.kButtonUp) then
		hp += 1
		updateScreen()
	elseif pd.buttonJustPressed(pd.kButtonDown) then
		hp -= 1
		updateScreen()
	end
end

