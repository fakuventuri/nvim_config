local format = {
    ONE_LINE = 1
}

local function _print_table(table, indent)
    for name, value in pairs(table) do
        if (value == nil) then
            print(indent .. name .. ": ")
        elseif (type(value) == "table") then
            _print_table(value, indent .. "\t")
        else
            print(indent .. name .. ": " .. tostring(value))
        end
    end
end

local function format_table_one_line(table, indent, line)
    line = line .. "{"
    for name, value in pairs(table) do
        if (value == nil) then
            line = " " .. line .. name .. ": nil, "
        elseif (type(value) == "table") then
            line = " " .. line .. name .. ": "
            line = format_table_one_line(value, indent .. "", line)
            line = line .. ", "
        else
            line = " " .. line .. name .. ": " .. tostring(value) .. ", "
        end
    end
    line = line .. "}"
    return line
end

local function print_table(table, opts)
    opts = opts or {}
    if (opts.format == format.ONE_LINE) then
        local line = format_table_one_line(table, "", "")
        print(line)
    else
        _print_table(table, "")
    end
end

return {
    print_table = print_table,
    format = format,
}
