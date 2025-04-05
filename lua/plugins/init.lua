local plugins = {
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/nvim-cmp' },
    {
        'neovim/nvim-lspconfig',
        config = function()
            require("plugins.configs.lspconfig")
        end
    },

    { "christoomey/vim-tmux-navigator", lazy = false, },
    { "mbbill/undotree",                lazy = false, },
    { "tpope/vim-fugitive",             lazy = false, },
    { "lewis6991/gitsigns.nvim",        lazy = false, },
    -- { 'nvim-pack/nvim-spectre',         lazy = false, },
    { 'mfussenegger/nvim-jdtls', },
    { "folke/trouble.nvim", },
    { 'lervag/vimtex',                  lazy = false, },
    {
        "L3MON4D3/LuaSnip",
        dependencies = "rafamadriz/friendly-snippets",
        opts = { history = true, updateevents = "TextChanged,TextChangedI" },
    },
    {
        "williamboman/mason.nvim",
        opts = require("plugins.opts.mason"),
        cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUpdate" },
        -- TODO
        -- config = require("plugins.configs.mason"),
    },
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
        opts = require("plugins.opts.mason_lspconfig"),
    },

    { "nvim-treesitter/nvim-treesitter", opts = require("plugins.opts.treesitter") },
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        lazy = false,
        cmd = "Telescope",
    },
    {
        "tiagovla/tokyodark.nvim",
        config = function(_, _) vim.cmd [[colorscheme tokyodark]] end,
    },
    {
        "rust-lang/rust.vim",
        ft = "rust",
        init = function() vim.g.rustfmt_autosave = 1 end,
    },
    { "mfussenegger/nvim-dap" },
    {
        "saecki/crates.nvim",
        ft = { "rust", "toml" },
        dependencies = 'hrsh7th/nvim-cmp',
        -- TODO insert crate sources in nvim-cmp
    },
}

return plugins
