import "Corelibs/sprites"
import "Corelibs/timer"
import "Corelibs/object"
import "Corelibs/crank"

local pd <const> = playdate
local gfx <const> = pd.graphics

function initialize()
	local fontNontendoBold = gfx.font.new('font/Nontendo-Bold-2x')
	gfx.setFont(fontNontendoBold)
	gfx.drawText("Test",100,100)
	
end
initialize()
function pd.update()

end

