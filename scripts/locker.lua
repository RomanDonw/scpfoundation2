local BUTTON_BID = block.index(PACK_ID .. ":button")

function on_use_on_block(x, y, z, pid, n)
    local bid = block.get(x, y, z)

    if bid == BUTTON_BID then
        local locked = block.get_field(x, y, z, "locked")
        if locked == nil or locked == 0 then
            block.set_field(x, y, z, "locked", 1)
        else
            block.set_field(x, y, z, "locked", 0)
        end
    end
    return true
end