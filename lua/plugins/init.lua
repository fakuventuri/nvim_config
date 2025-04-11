local get_config = function(config_file)
    return function()
        require("plugins.configs." .. config_file)
    end
end
local get_opts = function(config_file)
    return require("plugins.opts." .. config_file)
end

return {
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            "saadparwaiz1/cmp_luasnip",
            { "windwp/nvim-autopairs", config = get_config("autopairs"), },
            "hrsh7th/cmp-nvim-lua",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
        },
        config = get_config("cmp"),
    },
    {
        'neovim/nvim-lspconfig',
        config = get_config("lspconfig"),
    },
    { "nvim-treesitter/nvim-treesitter", config = get_config("treesitter") },
    {
        "christoomey/vim-tmux-navigator",
        config = get_config("tmux_navigation"),
    },
    {
        "mbbill/undotree",
        config = get_config("undotree"),
    },
    {
        "tpope/vim-fugitive",
        config = get_config("fugitive"),
    },
    { "lewis6991/gitsigns.nvim", },
    {
        'nvim-pack/nvim-spectre',
        config = get_config("spectre"),
    },
    { 'mfussenegger/nvim-jdtls', },
    { "folke/trouble.nvim", cmd = "Trouble", config = true,
    },
    {
        'lervag/vimtex',
        config = get_config("vimtex")
    },
    {
        "L3MON4D3/LuaSnip",
        dependencies = "rafamadriz/friendly-snippets",
        config = get_config("luasnip")
    },
    {
        "williamboman/mason.nvim",
        config = get_config("mason"),
        cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUpdate" },
        -- TODO
        -- config = require("plugins.configs.mason"),
    },
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
        config = get_config("mason_lspconfig"),
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
        dependencies = 'hrsh7th/nvim-cmp',
        config = true,
        -- TODO insert crate sources in nvim-cmp
    },
    {
        "simrat39/rust-tools.nvim",
        ft = "rust",
        dependencies = "neovim/nvim-lspconfig",
        config = true,
    },
    {
        "rust-lang/rust.vim",
        ft = "rust",
        init = function() vim.g.rustfmt_autosave = 1 end,
    },
    {
        "mfussenegger/nvim-dap",
        config = get_config("nvim_dap")
    },
}
