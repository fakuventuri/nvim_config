local config_files = io.popen("ls " .. vim.fn.stdpath("config") .. "/lua/utils") or {}
local utils = {}

for file in config_files:lines() do
    if file ~= "init.lua" then
        local name = file:sub(1, -5) -- taking out .lua extension
        utils[name] = require("utils." .. name)
    end
end

return utils
