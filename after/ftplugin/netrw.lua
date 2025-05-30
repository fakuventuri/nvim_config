local fs = require("utils.fs")
local str = require("utils.string")

local remap = vim.keymap.set
local bind = function(lhs, rhs, desc)
    remap("n", lhs, rhs, { remap = true, buffer = true, desc = desc })
end

bind("a", "<nop>", "no showing only hidden files")
bind("s", "<nop>", "no sort changin")
bind("v", "V", "quality of life")

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
    fs.open_with(fs.cwd() .. file)
end, "open file under cursor")

bind("r", "R", "rename")
bind("n", "%", "create new file")

bind("h", "-", "go to parent directory")
bind("l", "<cr>", "go to directory or open file")

bind("<f1>", "<cmd>tab help netrw<cr>", "go to directory or open file")
