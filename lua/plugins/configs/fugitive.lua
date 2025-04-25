local remap = vim.keymap.set
local user_cmd = vim.api.nvim_create_user_command

remap("n", "<leader>gs", "<cmd>tab Git<cr>", { desc = "Git status" })

remap("n", "<leader>gv", "tab Gdiffsplit", { desc = "Git diffsplit (with HEAD)" })

user_cmd("Glog", function(params)
    vim.cmd("tab Git log " .. (params.args or ""))
end, { desc = "Git log on other tab", nargs = "?" })
user_cmd("Ggraph", "Glog --all --decorate --oneline --graph", { desc = "Git graph" })
user_cmd("Ggraphv", "Glog --all --decorate --graph", { desc = "Git graph verbose" })

vim.cmd("set diffopt+=vertical")
