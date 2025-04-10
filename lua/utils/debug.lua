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

local function print_table(table)
    _print_table(table, "")
end

return {
    print_table = print_table,
}
