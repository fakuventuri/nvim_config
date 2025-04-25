local remap = vim.keymap.set
local quickfix = require("utils.quickfix")
-- BASE
remap("n", "<leader>e", vim.cmd.Ex, { desc = "open netrw" })

remap("n", "<tab>", "gt", { desc = "go to next tab" })
remap("n", "<s-tab>", "gT", { desc = "go to previos tab" })

remap({ "n", "v" }, "L", "$", { desc = "go to line end" })
remap("n", "dL", "d$", { desc = "go to line end" })
remap({ "n", "v" }, "H", "^", { desc = "delete till line start" })
remap("n", "dH", "d^", { desc = "delete till line start" })

remap("n", "D", vim.diagnostic.open_float, { desc = "open float diagnostic" })

remap("n", "<leader>rp", ":%s/<C-r><C-w>/<C-r><C-w>/gI<Left><Left><Left>", { desc = "replace all ocurrencies" })
remap("v", "<leader>sr", "y/<C-r>\"<cr>", { desc = "search ocurrencies of marked text " })

remap("v", "K", ":m '>+1<CR>gv=gv", { desc = "move marked text up" })
remap("v", "J", ":m '<-2<CR>gv=gv", { desc = "move marked text down" })
remap("n", "J", "mzJ`z", { desc = "J maintains cursor position" })
remap("n", "<C-d>", "<C-d>zz", { desc = "centeres <C-d>" })
remap("n", "<C-u>", "<C-u>zz", { desc = "centeres <C-u>" })
remap("n", "n", "nzzzv", { desc = "Centered cursor n" })
remap("n", "N", "Nzzzv", { desc = "Centered cursor N" })

remap({ "n", "v" }, "<leader>y", "\"+y", { desc = "yank to clipboard" })
remap({ "n", "v" }, "<leader>p", "\"+p", { desc = "paste from system clipboard" })
remap({ "n", "v" }, "<leader>P", "\"+p", { desc = "paste from system clipboard" })
remap("v", "r", "\"_dP", { desc = "replace marked with clipboard" })
remap("v", "<leader>r", "\"_d\"+P", { desc = "replace marked with system clipboard" })

remap("n", "U", "<C-r>", { desc = "redo" })
remap("n", "<C-z>", "<nop>", { desc = "nothing" })

remap("n", "<leader>q", function() quickfix.toggle() end, { desc = "toggle quickfix list" })
remap("n", "<leader>lo", function()
    vim.cmd('e' .. vim.lsp.get_log_path())
end, { desc = "show error log" })

remap("n", "<C-n>", "<cmd>tab split<cr>", { desc = "new tab" })
remap("n", "Q", "<cmd>tabclose<cr>", { desc = "close tab" })
-- insert mode
remap("i", "<C-j>", "<down>", { desc = "down in insert mode" })
remap("i", "<C-k>", "<up>", { desc = "up in insert mode" })
remap("i", "<C-h>", "<left>", { desc = "left in insert mode" })
remap("i", "<C-l>", "<right>", { desc = "right in insert mode" })

-- TROUBLE
remap("n", "<leader>sd", "<cmd>Trouble diagnostics toggle focus=true<cr>", { desc = "show diagnostics" })
remap("n", "<leader>se",
    "<cmd>Trouble diagnostics toggle focus=true filter.severity=vim.diagnostic.severity.ERROR<cr>",
    { desc = "show diagnostics" })
remap("n", "<leader>sbd", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
    { desc = "show buffer diagnostics" })
remap("n", "<leader>sbe",
    "<cmd>Trouble diagnostics toggle focus=true filter.severity=vim.diagnostic.severity.ERROR filter.buf=0<cr>",
    { desc = "show diagnostics" })
remap("n", "<leader>ss", "<cmd>Trouble symbols toggle focus=false<cr>", { desc = "show symbols" })

-- TELESCOPE
local builtin = require("telescope.builtin")

remap("n", "<leader>ff", builtin.find_files, { desc = "find files" })
remap("n", "<leader>fp", function()
    builtin.grep_string({ search = vim.fn.input("Grep > ") })
end, { desc = "project grep" })
remap("n", "<leader>fg", builtin.git_files, { desc = "find git files" })
remap("n", "<leader>fr", builtin.lsp_references, { desc = "find git files" })
remap("n", "<leader>fs", builtin.lsp_workspace_symbols, { desc = "find workspace symbols" })
remap("n", "<leader>fbs", builtin.lsp_document_symbols, { desc = "find document symbols" })
remap("n", "<leader>fd", builtin.diagnostics, { desc = "telescope diagnostics" })
remap("n", "<leader>fbd", function() builtin.diagnostics({ bufnr = 0 }) end,
    { desc = "telescope buffer diagnostics" })
remap("n", "<leader>fk", builtin.keymaps, { desc = "key mappings" })
