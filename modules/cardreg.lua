local _M = {}

local data = {}

local function trunc(x)
    return x >= 0 and math.floor(x) or math.ceil(x)
end

function _M.add_item(id, level)
    if type(id) ~= "number" then error("first parameter must be a number") end
    if type(level) ~= "number" then error("second parameter must be a number") end
    
    table.insert(data, {id, level})
end

function _M.get_level(id)
    if type(id) ~= "number" then error("first parameter must be a number") end
    id = trunc(id)

    for i = 1, #data do
        if data[i][1] == id then return data[i][2] end
    end
    return nil
end

function _M.set_level(id, level)
    if type(id) ~= "number" then error("first parameter must be a number") end; id = trunc(id)
    if type(level) ~= "number" then error("second parameter must be a number") end; level = trunc(level)

    for i = 1, #data do
        if data[i][1] == id then
            local oldlevel = data[i][2]
            data[i][2] = level
            return oldlevel
        end
    end
    return nil
end

return _M