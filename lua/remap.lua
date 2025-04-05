-- vim.keymap.set("n", "", "", { desc = "" })

local quickfix = require("utils.quickfix")
-- BASE
vim.keymap.set("n", "<leader>e", vim.cmd.Ex, { desc = "Open netrw" })

vim.keymap.set("n", "<leader>rp", ":%s/<C-r><C-w>/<C-r><C-w>/gI<Left><Left><Left>", { desc = "replace ocurrencies" })
vim.keymap.set("n", "<leader>s", ":%s/<C-r><C-w>", { desc = "search ocurrencies" })
-- TODO same but in visual mode

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

vim.keymap.set("n", "Q", function() quickfix.toggle() end, { desc = "toggle quickfix list" })
vim.keymap.set("n", "<leader>lo", function()
    vim.cmd('e' .. vim.lsp.get_log_path())
end, { desc = "show error log" })

-- ["<C-p>"] = { function() vim.diagnostic.goto_prev() end, "prev diagnostic" },
-- ["<C-n>"] = { function() vim.diagnostic.goto_next() end, "next diagnostic" },
--
-- ["<C-c>"] = {
--     function()
-- 	require("Comment.api").toggle.linewise.current()
--     end,
--     "Toggle comment",
-- },
--
-- FUGITIVE
vim.keymap.set("n", "<leader>gs", vim.cmd.Git, { desc = "" })

-- NVIMTREE
-- ["<C-o>"] = { "<cmd> NvimTreeToggle <CR>", "Toggle nvimtree" },

-- UNDOTREE
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "toggle undo tree" })

-- TELESCOPE
local builtin = require("telescope.builtin")
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'telescope find files' })
-- vim.keymap.set('n', '<leader>fg', builtin.find_git, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fs', function()
    builtin.grep_string({ search = vim.fn.input("Grup > ") })
end, { desc = 'telescope project grep' })

-- TMUX NAVIGATION
vim.keymap.set("n", "<C-h>", vim.cmd.TmuxNavigateLeft, { desc = "window left" })
vim.keymap.set("n", "<C-l>", vim.cmd.TmuxNavigateRight, { desc = "window right" })
vim.keymap.set("n", "<C-j>", vim.cmd.TmuxNavigateDown, { desc = "window down" })
vim.keymap.set("n", "<C-k>", vim.cmd.TmuxNavigateUp, { desc = "window up" })

-- LUASNIP
vim.keymap.set("n", "<leader>L", function()
    require("luasnip.loaders.from_lua")
        .load({ paths = "~/.config/nvim/lua/snippets/" })
end, { desc = "reload snippets" })

-- VIMTEX
vim.keymap.set("n", "<leader>lv", vim.cmd.VimtexView, { desc = "vimtex view" })
vim.keymap.set("n", "<leader>lc", vim.cmd.VimtexCompile, { desc = "vimtex compile" })

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
-- M.spectre = {
--     n = {
--         ['<leader>S'] = { function() require("spectre").toggle() end, "toggle Spectre" },
--         ['<leader>sw'] = { function() require("spectre").open_visual({ select_word = true }) end, "toggle spectre" },
--         ['<leader>sp'] = { function() require("spectre").open_file_search({ select_word = true }) end, "toggle spectre" },
--     },
--     v = {
--         ['<leader>sw'] = { function() require("spectre").open_visual() end, "toggle Spectre" },
--     }
-- }
