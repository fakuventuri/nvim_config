local plugins = {
	{ "lewis6991/gitsigns.nvim" },
	{
		"numToStr/Comment.nvim",
		config = true,
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = true,
	},
	{
		"tiagovla/tokyodark.nvim",
		config = function(_, _)
			vim.cmd([[colorscheme tokyodark]])
		end,
	},
	{
		"mrcjkb/rustaceanvim",
		lazy = false, -- This plugin is already lazy
	},
	{
		"saecki/crates.nvim",
		ft = { "rust", "toml" },
		dependencies = { "hrsh7th/nvim-cmp" },
		config = true,
		-- TODO insert crate sources in nvim-cmp
	},
	{
		"rust-lang/rust.vim",
		ft = "rust",
		init = function()
			vim.g.rustfmt_autosave = 1
		end,
	},
}

return plugins
