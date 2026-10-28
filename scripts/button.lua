local itr = require "interactor"

function on_interact(x, y, z, pid)
    itr.usedoor(
        block.get_field(x, y, z, "door_x"),
        block.get_field(x, y, z, "door_y"),
        block.get_field(x, y, z, "door_z")
    )
    return true
end