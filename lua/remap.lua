-- vim.keymap.set("n", "", "", { desc = "" })

local quickfix = require("utils.quickfix")
-- BASE
vim.keymap.set("n", "<leader>e", vim.cmd.Ex, { desc = "open netrw" })

vim.keymap.set("n", "<tab>", "gt", { desc = "go to next tab" })
vim.keymap.set("n", "<s-tab>", "gT", { desc = "go to previos tab" })

vim.keymap.set({"n", "v"}, "L", "$", { desc = "go to line end" })
vim.keymap.set("n", "dL", "d$", { desc = "go to line end" })
vim.keymap.set({"n", "v"}, "H", "^", { desc = "delete till line start" })
vim.keymap.set("n", "dH", "d^", { desc = "delete till line start" })

vim.keymap.set("n", "D", vim.diagnostic.open_float, { desc = "delete till line start" })

vim.keymap.set("n", "<leader>rp", ":%s/<C-r><C-w>/<C-r><C-w>/gI<Left><Left><Left>", { desc = "replace ocurrencies" })
vim.keymap.set("v", "<leader>sr", "y/<C-r>\"", { desc = "search marked text ocurrencies" })
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

vim.keymap.set("n", "<leader>ts", "<cmd>tab split<cr>", { desc = "tab split" })
vim.keymap.set("n", "<leader>tn", "<cmd>tabnew<cr>", { desc = "new tab" })

-- TROUBLE
vim.keymap.set("n", "<leader>sd", "<cmd>Trouble diagnostics toggle<cr>", { desc = "show diagnostics" })
vim.keymap.set("n", "<leader>sb", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
    { desc = "show buffer diagnostics" })
vim.keymap.set("n", "<leader>ss", "<cmd>Trouble symbols toggle focus=false<cr>", { desc = "show symbols" })

-- TELESCOPE
local builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "find files" })
vim.keymap.set("n", "<leader>fp", function()
    builtin.grep_string({ search = vim.fn.input("Grep > ") })
end, { desc = "project grep" })
vim.keymap.set("n", "<leader>fg", builtin.git_files, { desc = "find git files" })
vim.keymap.set("n", "<leader>fr", builtin.lsp_references, { desc = "find git files" })
vim.keymap.set("n", "<leader>fs", builtin.lsp_workspace_symbols, { desc = "find workspace symbols" })
vim.keymap.set("n", "<leader>fbs", builtin.lsp_document_symbols, { desc = "find document symbols" })
vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "telescope diagnostics" })
vim.keymap.set("n", "<leader>fbd", function() builtin.diagnostics({ bufnr = 0 }) end,
    { desc = "telescope buffer diagnostics" })
vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "key mappings" })

-- COMMENT
vim.keymap.set("n", "<leader>c", require("Comment.api").toggle.linewise.current, { desc = "toggle comment" })
