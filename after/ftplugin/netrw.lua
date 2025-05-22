local fs = require("utils.fs")
local str = require("utils.string")

local remap = vim.keymap.set
local bind = function(lhs, rhs, desc)
    remap("n", lhs, rhs, { remap = true, buffer = true, desc = desc })
end

bind("s", "<nop>", "no sort changin")
bind("v", "<nop>", "no vertical split open")

---@return string
local function get_selected_files()
    vim.cmd("normal! y")
    return str.line_preppend(vim.fn.getreg("\""), fs.cwd())
end

remap("v", "y", function()
    fs.copy(get_selected_files())
end, { desc = "copy selected files", buffer = true })
remap("v", "d", function()
    fs.move(get_selected_files())
end, { desc = "move selected files", buffer = true })
remap("v", "D", function()
    fs.delete(get_selected_files())
end, { desc = "delete selected files", buffer = true })
bind("p", function()
    fs.paste(fs.cwd())
end, "paste selected files")
bind("<leader>p", function()
    fs.paste(fs.cwd(), { clipboard = fs.Clipboard.SYSTEM })
end, "paste selected files")

bind("O", "t", "open in file new tab")
bind("o", function()
    local file = vim.fn.getline(".")
    fs.open_with((vim.fn.expand("%") or ".") .. "/" .. file)
end, "open file under cursor")

bind("r", "R", "rename")
bind("n", "%", "create new file")

bind("h", "-", "go to parent directory")
bind("l", "<cr>", "go to directory or open file")
