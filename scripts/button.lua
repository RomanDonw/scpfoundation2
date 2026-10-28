local itr = require "interactor"

function on_interact(x, y, z, pid)
    local dx = block.get_field(x, y, z, "door_x"); if dx == nil then return end
    local dy = block.get_field(x, y, z, "door_y"); if dy == nil then return end
    local dz = block.get_field(x, y, z, "door_z"); if dz == nil then return end

    if not itr.doorbusy(dx, dy, dz) then
        audio.play_sound("interaction/button/success", x + 0.5, y + 0.5, z + 0.5, 1, 1)
        itr.usedoor(dx, dy, dz)
    else
        audio.play_sound("interaction/button/fail", x + 0.5, y + 0.5, z + 0.5, 1, 1)
    end
    return true
end