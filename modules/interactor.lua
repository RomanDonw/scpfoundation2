local _M = {}

local doorctl = require "doorctl"

local TIMEOUT = 2

function _M.doorbusy(x, y, z)
    if doorctl.gettype(x, y, z) == -1 then return false end

    return world.get_total_time() < doorctl.lastitime.get(x, y, z) + TIMEOUT
end

function _M.usedoor(x, y, z)
    if doorctl.gettype(x, y, z) == -1 then return end

    local itime = doorctl.lastitime.get(x, y, z)
    local wtime = world.get_total_time()
    
    if wtime >= itime + TIMEOUT then
        doorctl.toggle(x, y, z)
        doorctl.lastitime.set(x, y, z, wtime)
    end
end

return _M