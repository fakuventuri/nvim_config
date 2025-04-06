local opts = { history = true, updateevents = "TextChanged,TextChangedI" }

vim.keymap.set("n", "<leader>L", function()
    require("luasnip.loaders.from_lua")
        .load({ paths = "~/.config/nvim/lua/snippets/" })
end, { desc = "reload snippets" })

require("luasnip").setup(opts)
