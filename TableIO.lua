local function tableToString(table)
    local function serialize(tbl)
        local str = "{"
        for k, v in pairs(tbl) do
            if type(k) == "string" then
                k = '"' .. k .. '"'
            end
            local valueStr
            if type(v) == "table" then
                valueStr = serialize(v)
            elseif type(v) == "string" then
                valueStr = '"' .. v .. '"'
            elseif type(v) == "boolean" then
                valueStr = tostring(v)
            else
                valueStr = v
            end
            str = str .. "[" .. k .. "]=" .. valueStr .. ","
        end
        str = str .. "}"
        return str
    end
    return serialize(table)
end

local function stringToTable(str)
    return assert(load("return " .. str))()
end


local function dump(table, filename)
    local file = io.open(filename, "w")
    if file then
        local serialized = tableToString(table)
        file:write(serialized)
        file:close()
        print("Table saved to " .. filename)
    else
        print("Error: Unable to open file " .. filename)
    end
end

local function load(filename)
    local file = io.open(filename, "r")
    if file then
        local content = file:read("*all")
        file:close()
        local table = stringToTable(content)
        return table
    else
        print("Error: Unable to open file " .. filename)
        return nil
    end
end

return {
    dump = dump,
    load = load
}
