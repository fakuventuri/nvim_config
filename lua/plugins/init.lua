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
        'numToStr/Comment.nvim',
        config = true,
    },
    {
        "folke/trouble.nvim",
        cmd = "Trouble",
        config = true,
    },
    {
        'akinsho/bufferline.nvim',
        version = "*",
        dependencies = 'nvim-tree/nvim-web-devicons',
    },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
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
        'mrcjkb/rustaceanvim',
        lazy = false, -- This plugin is already lazy
    },
    {
        "saecki/crates.nvim",
        ft = { "rust", "toml" },
        dependencies = { 'hrsh7th/nvim-cmp' },
        config = true,
        -- TODO insert crate sources in nvim-cmp
    },
    {
        "rust-lang/rust.vim",
        ft = "rust",
        init = function() vim.g.rustfmt_autosave = 1 end,
    },
    { "mfussenegger/nvim-dap", },
    {
        "jay-babu/mason-nvim-dap.nvim",
        event = "VeryLazy",
        dependencies = { "williamboman/mason.nvim", "mfussenegger/nvim-dap", },
        config = true,
    },
    {
        "rcarriga/nvim-dap-ui",
        event = "VeryLazy",
        config = true,
        dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" }
    },
    {
        "julianolf/nvim-dap-lldb",
        dependencies = { "mfussenegger/nvim-dap" },
        config = true,
    },
    {
        "folke/lazydev.nvim",
        ft = "lua",
    },
}

require("config.plugins").add_configs(plugins)

return plugins
