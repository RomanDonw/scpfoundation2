local doorctl = require "doorctl"

local doorpos = {0, 0, 0}

local BUTTON_BID = block.index(PACK_ID .. ":button")

function on_use_on_block(x, y, z, pid, n)
    local bid = block.get(x, y, z)

    if doorctl.gettype(x, y, z) ~= -1 then
        doorpos = {x, y, z}
    elseif bid == BUTTON_BID then
        block.set_field(x, y, z, "door_x", doorpos[1])
        block.set_field(x, y, z, "door_y", doorpos[2])
        block.set_field(x, y, z, "door_z", doorpos[3])
    end
    return true
end