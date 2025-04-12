local plugins = {
    { "windwp/nvim-autopairs" },
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            "saadparwaiz1/cmp_luasnip",
            "windwp/nvim-autopairs",
            "hrsh7th/cmp-nvim-lua",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
        },
    },
    { 'neovim/nvim-lspconfig', },
    { "nvim-treesitter/nvim-treesitter", },
    { "christoomey/vim-tmux-navigator", },
    { "mbbill/undotree", },
    { "tpope/vim-fugitive", },
    { "lewis6991/gitsigns.nvim", },
    { 'nvim-pack/nvim-spectre', },
    { 'mfussenegger/nvim-jdtls', },
    {
        "folke/trouble.nvim",
        cmd = "Trouble",
        config = true,
    },
    { 'lervag/vimtex', },
    {
        "L3MON4D3/LuaSnip",
        dependencies = { "rafamadriz/friendly-snippets" },
    },
    {
        "williamboman/mason.nvim",
        cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUpdate" },
    },
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
    },
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        cmd = "Telescope",
    },
    {
        "tiagovla/tokyodark.nvim",
        config = function(_, _) vim.cmd [[colorscheme tokyodark]] end,
    },
    {
        "saecki/crates.nvim",
        ft = { "rust", "toml" },
        dependencies = { 'hrsh7th/nvim-cmp' },
        config = true,
        -- TODO insert crate sources in nvim-cmp
    },
    {
        "simrat39/rust-tools.nvim",
        ft = "rust",
        dependencies = { "neovim/nvim-lspconfig" },
        config = true,
    },
    {
        "rust-lang/rust.vim",
        ft = "rust",
        init = function() vim.g.rustfmt_autosave = 1 end,
    },
    { "mfussenegger/nvim-dap", },
}

require("config.plugins").add_configs(plugins)

return plugins
