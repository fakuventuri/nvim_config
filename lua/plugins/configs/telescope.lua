local actions = require("telescope.actions")

local opts = {
    defaults = {
        mappings = {
            n = {
                ["o"] = actions.select_tab,
            }
        }
    }
}

require("telescope").setup(opts)
