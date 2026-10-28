local doorctl = require "doorctl"

function on_placed(x, y, z, pid)
    doorctl.lastitime.set(x, y, z, -math.huge)
end