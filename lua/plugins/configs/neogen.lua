local neogen = require("neogen")
local opts = {}
local remap = vim.keymap.set

remap("n", "do", neogen.generate, { noremap = true, silent = true })

neogen.setup(opts)
