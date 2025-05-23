local user_cmd = vim.api.nvim_create_user_command

user_cmd("CleanSwap", function()
    vim.cmd("silent !rm ~/.local/state/nvim/swap/*")
end, { desc = "clean swap" })
