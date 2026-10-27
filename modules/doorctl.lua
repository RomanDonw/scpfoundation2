local _M = {}

_M.DOOR_TYPE_UNKNOWN = -1
_M.DOOR_TYPE_GENERIC = 0

local PACK_ID = "scpfoundation"
local GENERIC_DOOR_BID = block.index(PACK_ID .. ":door1")

function _M.gettype(x, y, z)
    if type(x) ~= "number" then error("first parameter must be a number") end
    if type(y) ~= "number" then error("second parameter must be a number") end
    if type(z) ~= "number" then error("third parameter must be a number") end
    x, y, z = block.seek_origin(x, y, z)
    
    local bid = block.get(x, y, z)
    if bid == GENERIC_DOOR_BID then
        return _M.DOOR_TYPE_GENERIC
    else
        return _M.DOOR_TYPE_UNKNOWN
    end
end

function _M.getstate(x, y, z)
    if _M.gettype(x, y, z) == -1 then error("block at " .. x .. " " .. y .. " " .. z .. " isnt a door") end
    x, y, z = block.seek_origin(x, y, z)
    
    local v = block.get_variant(x, y, z)
    if v ~= 0 then
        return true
    else
        return false
    end
end

function _M.setstate(x, y, z, state)
    if _M.gettype(x, y, z) == -1 then error("block at " .. x .. " " .. y .. " " .. z .. " isnt a door") end
    if type(state) ~= "boolean" then error("fourth parameter must be a boolean") end
    x, y, z = block.seek_origin(x, y, z)

    if state then
        block.set_variant(x, y, z, 1)
    else
        block.set_variant(x, y, z, 0)
    end
end

function _M.open(x, y, z)
    if _M.getstate(x, y, z) then return end
    _M.setstate(x, y, z, true)
    x, y, z = block.seek_origin(x, y, z)

    local b = block.get_user_bits(x, y, z, 0, 2)
    if b > 2 then
        b = 0
        block.set_user_bits(x, y, z, 0, 2, b)
    end

    audio.play_sound("doors/1/open_" .. (b + 1), x + 0.5, y + 1, z + 0.5, 1, 1)
end

function _M.close(x, y, z)
    if not _M.getstate(x, y, z) then return end
    _M.setstate(x, y, z, false)
    x, y, z = block.seek_origin(x, y, z)

    local b = block.get_user_bits(x, y, z, 0, 2)
    if b > 2 then b = 0 end

    b = b + 1
    audio.play_sound("doors/1/close_" .. b, x + 0.5, y + 1, z + 0.5, 1, 1)
    if b > 2 then b = 0 end
    block.set_user_bits(x, y, z, 0, 2, b)
end

function _M.toggle(x, y, z)
    if _M.getstate(x, y, z) then
        _M.close(x, y, z)
    else
        _M.open(x, y, z)
    end
end

_M.lastitime = {}

function _M.lastitime.get(x, y, z)
    if _M.gettype(x, y, z) == -1 then error("block at " .. x .. " " .. y .. " " .. z .. " isnt a door") end
    x, y, z = block.seek_origin(x, y, z)

    return block.get_field(x, y, z, "lastitime")
end

function _M.lastitime.set(x, y, z, t)
    if _M.gettype(x, y, z) == -1 then error("block at " .. x .. " " .. y .. " " .. z .. " isnt a door") end
    if type(t) ~= "number" then error("fourth parameter must be a number") end
    x, y, z = block.seek_origin(x, y, z)

    block.set_field(x, y, z, "lastitime", t)
end

return _M