local itr = require "interactor"
local reg = require "cardreg"

function on_interact(x, y, z, pid)
    local invid, selslot = player.get_inventory(pid)
    local seliid, selicount = inventory.get(invid, selslot)
    local sellevel = reg.get_level(seliid)
    if sellevel == nil then return end

    local dx = block.get_field(x, y, z, "door_x"); if dx == nil then return end
    local dy = block.get_field(x, y, z, "door_y"); if dy == nil then return end
    local dz = block.get_field(x, y, z, "door_z"); if dz == nil then return end
    local level = block.get_field(x, y, z, "level"); if level == nil then level = 0 end
    local locked = block.get_field(x, y, z, "locked")
    if locked == nil or locked == 0 then locked = false else locked = true end

    if not locked and not itr.doorbusy(dx, dy, dz) and sellevel >= level then
        audio.play_sound("interaction/cardreader/success", x + 0.5, y + 0.5, z + 0.5, 1, 1)
        itr.usedoor(dx, dy, dz)
    else
        audio.play_sound("interaction/cardreader/fail", x + 0.5, y + 0.5, z + 0.5, 1, 1)
    end
    return true
end