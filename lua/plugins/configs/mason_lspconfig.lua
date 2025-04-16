local lspconfig = require("lspconfig")
local base_config = require("plugins.configs.lspconfig")

local server_opts = {
    glsl_analyzer = {
        filetypes = { "glsl" }
    },
    pyright       = {
        filetypes = { "python" },
    },
    bashls        = {
        filetypes = { "bash", "zsh", "sh" },
    },
    gopls         = {
        cmd = { "gopls" },
        filetypes = { "go", "gomod", "gowork", "gotmpl" },
        -- root_dir = util.root_pattern("go.work", "go.mod", "git"),
        settings = {
            gopls = {
                completeUnimported = true,
                analyses = {
                    unusedparams = true,
                }
            }
        }
    },
}

local opts = {
    handlers = {
        function(server_name)
            local options = server_opts[server_name] or {}
            vim.tbl_extend("keep", options, base_config)
            lspconfig[server_name].setup(options)
        end,
        -- discard setups done by plugins
        jdtls = function() end,
        rust_analyzer = function() end,
    },
}

require("mason-lspconfig").setup(opts)
