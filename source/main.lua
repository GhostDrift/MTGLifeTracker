import "Corelibs/sprites"
import "Corelibs/timer"
import "Corelibs/object"
import "Corelibs/crank"
import "Corelibs/ui"
import "Corelibs/graphics"

local pd <const> = playdate
local gfx <const> = pd.graphics

function initialize()
	local fontNontendoBold = gfx.font.new('font/Nontendo-Bold-2x')
	gfx.setFont(fontNontendoBold)
	gfx.drawText("Test",100,100)
end
initialize()
function playdate.update()
	
end

