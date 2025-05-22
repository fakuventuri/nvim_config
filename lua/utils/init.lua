local config_files = io.popen("ls " .. vim.fn.stdpath("config") .. "/lua/utils") or {}
local utils = {}

for file in config_files:lines() do
    if file == "init.lua" then
        goto continue
    end
    local name = file
    if file:find(".lua") then
        name = file:sub(1, -5) -- taking out .lua extension
    end
    utils[name] = require("utils." .. name)

    ::continue::
end

return utils
