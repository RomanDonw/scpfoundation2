local _M = {}

local doorctl = require "doorctl"

function _M.usedoor(x, y, z)
    local itime = doorctl.lastitime.get(x, y, z)
    local wtime = world.get_total_time()
    
    if wtime >= itime + 2 then
        doorctl.toggle(x, y, z)
        doorctl.lastitime.set(x, y, z, wtime)
    end
end

return _M