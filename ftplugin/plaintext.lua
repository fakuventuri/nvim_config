vim.opt.wrap = true
vim.opt.linebreak = true

local remap = vim.keymap.set

remap({ "n", "v" }, "j", "gj", { desc = "navigate down in visual lines", remap = true, buffer = true })
remap({ "n", "v" }, "k", "gk", { desc = "navigate up in visual lines", remap = true, buffer = true })
remap({ "n", "v" }, "$", "g$", { desc = "navigate to end of visual line", remap = true, buffer = true })
remap({ "n", "v" }, "^", "g^", { desc = "navigate to start of visual line", remap = true, buffer = true })

remap("n", "d$", "dg$", { desc = "navigate to end of visual line", remap = true, buffer = true })
remap("n", "d^", "dg^", { desc = "navigate to start of visual line", remap = true, buffer = true })
remap("n", "dL", "dg$", { desc = "navigate to end of visual line", remap = true, buffer = true })
remap("n", "dH", "dg^", { desc = "navigate to start of visual line", remap = true, buffer = true })

remap("n", "dd", "g^dgj", { desc = "navigate to start of visual line", remap = true, buffer = true })
