import "Corelibs/sprites"
import "Corelibs/timer"
import "Corelibs/object"
import "Corelibs/crank"

local pd <const> = playdate
local gfx <const> = pd.graphics

function initialize()
	local font = gfx.font.new('font/Mini Sans 2X')
	gfx.setFont(font)
	gfx.drawText("test",180,120)
end
initialize()
function pd.update()

end

