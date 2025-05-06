return {
    "williamboman/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUpdate" },
    opts = {
        ensure_installed = {
            "black",
            "bash-language-server",
            "clangd",
            "codelldb",
            "glsl_analyzer",
            "html-lsp",
            "java-debug-adapter",
            "java-test",
            "jdtls",
            "lemminx",
            "lua-language-server",
            "ltex-ls",
            "mypy",
            "pyright",
            "sqlls",
            "zls",
        },
    },
    config = function(opts)
        -- taken from nvchad
        vim.api.nvim_create_user_command("MasonInstallAll", function()
            if opts.ensure_installed and #opts.ensure_installed > 0 then
                vim.cmd("MasonInstall " .. table.concat(opts.ensure_installed, " "))
            end
        end, {})
        vim.g.mason_binaries_list = opts.ensure_installed
        require("mason").setup(opts)
    end
}
