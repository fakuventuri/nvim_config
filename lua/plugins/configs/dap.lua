local dap = require("dap")

vim.keymap.set("n", "<leader>b", vim.cmd.DapToggleBreakpoint, { desc = "toggle break point" })
vim.keymap.set("n", "<leader>db", function()
    local widgets = require("dap.ui.widgets")
    local sidebar = widgets.sidebar(widgets.scopes)
    sidebar.open()
end, { desc = "open debugging sidebar" })
vim.keymap.set("n", "<leader>so", vim.cmd.DapStepOver, { desc = "dap step over" })
vim.keymap.set("n", "<leader>si", vim.cmd.DapStepInto, { desc = "dap step into" })
vim.keymap.set("n", "<leader>su", vim.cmd.DapStepOut, { desc = "dap step out" })
vim.keymap.set("n", "<leader>dc", vim.cmd.DapStepOut, { desc = "dap continue" })

-- dap.configurations.cpp = {
--     {
--         name = 'Launch',
--         type = 'lldb',
--         request = 'launch',
--         program = function()
--             return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
--         end,
--         cwd = '${workspaceFolder}',
--         stopOnEntry = false,
--         args = {},
--     },
-- }
-- dap.configurations.c = dap.configurations.cpp
-- dap.configurations.rust = dap.configurations.cpp

dap.configurations.java = {
    {
        type = "java",
        request = "attach",
        name = "Debug (Attach) - Remote",
        hostName = "127.0.0.1",
        port = 5005,
    },
}
