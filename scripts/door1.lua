local doorctl = require "doorctl"
local itr = require "interactor"

function on_placed(x, y, z, pid)
    doorctl.lastitime.set(x, y, z, -math.huge)
end

function on_interact(x, y, z, pid)
    itr.usedoor(x, y, z)
    return true
end