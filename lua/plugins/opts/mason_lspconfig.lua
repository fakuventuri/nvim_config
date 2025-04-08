local server_opts = {
    lua_ls        = {
        settings = {
            Lua = {
                diagnostics = {
                    globals = { "vim", "s", "t", "i", "d", "ls", "sn", "f", "fmt", "fmta", "rep" },
                },
                workspace = {
                    library = {
                        [vim.fn.expand "$VIMRUNTIME/lua"] = true,
                        [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
                        -- [vim.fn.stdpath "data" .. "/lazy/ui/nvchad_types"] = true,
                        -- [vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy"] = true,
                    },
                    maxPreload = 100000,
                    preloadFileSize = 10000,
                },
            },
        },
    },
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
            require("lspconfig")[server_name].setup(server_opts[server_name] or {})
        end,
    },
}

return opts
