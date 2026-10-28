local reg = require "cardreg"

function on_world_open()
    reg.add_item(item.index(PACK_ID .. ":card1"), 1)
end