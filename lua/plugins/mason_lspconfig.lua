return {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
    opts = {
        auto_enable = {
            exclude = {
                "jdtls"
            }
        }
    }
}
