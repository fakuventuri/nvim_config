-- vim.keymap.set("n", "", "", { desc = "" })

local quickfix = require("utils.quickfix")
-- BASE
vim.keymap.set("n", "<leader>e", vim.cmd.Ex, { desc = "Open netrw" })

vim.keymap.set("n", "<leader>rp", ":%s/<C-r><C-w>/<C-r><C-w>/gI<Left><Left><Left>", { desc = "replace ocurrencies" })
vim.keymap.set("v", "<leader>s", "y/<C-r>\"", { desc = "search marked text ocurrencies" })

vim.keymap.set("v", "K", ":m '>+1<CR>gv=gv", { desc = "move marked text up" })
vim.keymap.set("v", "J", ":m '<-2<CR>gv=gv", { desc = "move marked text down" })

vim.keymap.set("n", "J", "mzJ`z", { desc = "J maintains cursor position" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "centeres <C-d>" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "centeres <C-u>" })
vim.keymap.set("n", "n", "nzzzv", { desc = "Centered cursor n" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Centered cursor N" })

vim.keymap.set({ "n", "v" }, "<leader>y", "\"+y", { desc = "yank to clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>p", "\"+p", { desc = "paste from system clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>P", "\"+p", { desc = "paste from system clipboard" })
vim.keymap.set("v", "r", "\"_dp", { desc = "replace marked with clipboard" })
vim.keymap.set("v", "<leader>r", "\"_d\"+p", { desc = "replace marked with system clipboard" })

vim.keymap.set("n", "U", "<C-r>", { desc = "redo" })
vim.keymap.set("n", "<C-z>", "<nop>", { desc = "nothing" })

vim.keymap.set("i", "<C-j>", "<down>", { desc = "down in insert mode" })
vim.keymap.set("i", "<C-k>", "<up>", { desc = "up in insert mode" })
vim.keymap.set("i", "<C-h>", "<left>", { desc = "left in insert mode" })
vim.keymap.set("i", "<C-l>", "<right>", { desc = "right in insert mode" })

vim.keymap.set("n", "Q", function() quickfix.toggle() end, { desc = "toggle quickfix list" })
vim.keymap.set("n", "<leader>lo", function()
    vim.cmd('e' .. vim.lsp.get_log_path())
end, { desc = "show error log" })

-- TROUBLE
vim.keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics (Trouble)" })
vim.keymap.set("n", "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
    { desc = "Buffer Diagnostics (Trouble)" })
vim.keymap.set("n", "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", { desc = "Symbols (Trouble)" })
vim.keymap.set("n", "<leader>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
    { desc = "LSP Definitions / references / ... (Trouble)" })
vim.keymap.set("n", "<leader>xL", "<cmd>Trouble loclist toggle<cr>", { desc = "Location List (Trouble)" })
vim.keymap.set("n", "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", { desc = "Quickfix List (Trouble)" })

-- TELESCOPE
local builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "telescope find files" })
vim.keymap.set("n", "<leader>fs", function()
    builtin.grep_string({ search = vim.fn.input("Grep > ") })
end, { desc = "telescope project grep" })

-- vim.keymap.set("n", "<leader>fg", builtin.find_git, { desc = "Telescope live grep" })

-- ["<C-p>"] = { function() vim.diagnostic.goto_prev() end, "prev diagnostic" },
-- ["<C-n>"] = { function() vim.diagnostic.goto_next() end, "next diagnostic" },
--
-- ["<C-c>"] = {
--     function()
-- 	require("Comment.api").toggle.linewise.current()
--     end,
--     "Toggle comment",
-- },

-- M.debugging = {
--     n = {
--         ["<leader>b"] = { "<cmd> DapToggleBreakpoint<CR>", "toggle break point" },
--         ["<leader>db"] = {
--             function()
--                 local widgets = require("dap.ui.widgets")
--                 local sidebar = widgets.sidebar(widgets.scopes)
--                 sidebar.open()
--             end,
--             "open debugging sidebar"
--         }
--     },
-- }
