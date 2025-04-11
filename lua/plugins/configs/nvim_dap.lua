vim.keymap.set("n", "<leader>b", vim.cmd.DapToggleBreakpoint, { desc = "toggle break point" })
vim.keymap.set("n", "<leader>db", function()
    local widgets = require("dap.ui.widgets")
    local sidebar = widgets.sidebar(widgets.scopes)
    sidebar.open()
end, { desc = "open debugging sidebar" })

local dap = require("dap")
dap.configurations.java = {
    {
        type = "java",
        request = "attach",
        name = "Debug (Attach) - Remote",
        hostName = "127.0.0.1",
        port = 5005,
    },
}
