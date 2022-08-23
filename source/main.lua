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
	gfx.drawTextAligned(hpText, 200, 40, kTextAlignment.center)
	gfx.drawArc(200,73,60,0,9*hp)
	--gfx.drawText(hpText, 160,30)
	gfx.drawLine(125,140,275,140)

	--commander damage zone

	gfx.setFont(fontNontendoBold2X)
	--gfx.drawText("Commander Damage",90,160)
	gfx.drawTextAligned("Commander Damage", 200, 160, kTextAlignment.center)
	gfx.drawRoundRect(10,150,380,170,10)
	gfx.drawText(cd1, 100,200)
	gfx.drawText(cd2, 190,200)
	gfx.drawText(cd3, 280,200)

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

