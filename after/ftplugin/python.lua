vim.keymap.set({ 'n', 'x' }, '<leader>fm', function()
    require("conform").format({ async = true })
end, { buffer = true })
