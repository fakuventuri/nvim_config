local get_config = function(config_file)
    return function()
        require("plugins.configs." .. config_file)
    end
end
local get_opts = function(config_file)
    return require("plugins.opts." .. config_file)
end

local plugins = {
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/nvim-cmp' },
    { "jose-elias-alvarez/null-ls.nvim", config = get_config("null_ls"), },
    {
        'neovim/nvim-lspconfig',
        config = get_config("lspconfig"),
        dependencies = { "jose-elias-alvarez/null-ls.nvim", },
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
        opts = get_opts("mason"),
        cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUpdate" },
        -- TODO
        -- config = require("plugins.configs.mason"),
    },
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
        opts = get_opts("mason_lspconfig"),
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
        "windwp/nvim-autopairs",
        opts = {
            fast_wrap = {},
            disable_filetype = { "TelescopePrompt", "vim" },
        },
        config = function(_, opts)
            require("nvim-autopairs").setup(opts)
            -- setup cmp for autopairs
            local cmp_autopairs = require "nvim-autopairs.completion.cmp"
            require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
        end,
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
