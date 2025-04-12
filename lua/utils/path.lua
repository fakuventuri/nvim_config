local os_name = vim.loop.os_uname().sysname
local config
if os_name == "Linux" then
    config = "~/.config/nvim/"
else
    error("config path not set")
end

return {
    config = config
}
