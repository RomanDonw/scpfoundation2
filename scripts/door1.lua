local doorctl = require "doorctl"

function on_block_present(x, y, z)
    doorctl.lastitime.set(x, y, z, -math.huge)
end

function on_interact(x, y, z, pid)
    local itime = doorctl.lastitime.get(x, y, z)
    local wtime = world.get_total_time()
    
    if wtime >= itime + 2 then
        doorctl.toggle(x, y, z)
        doorctl.lastitime.set(x, y, z, wtime)
    end

    return true
end