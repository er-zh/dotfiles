return {
	-- Git related plugins
	--"tpope/vim-fugitive",
	--"tpope/vim-rhubarb",
	-- Detect tabstop
	--"tpope/vim-sleuth",
	{
		-- Color theme
		"navarasu/onedark.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require('onedark').setup {
				style = 'dark'
			}
			require('onedark').load()
		end,
	},

	{
		-- statusline
		"nvim-lualine/lualine.nvim",
		-- see ':help lualine.txt'
		opts = {
			options = {
				icons_enabled = false,
				theme = "onedark",
				component_separators = "|",
				section_separators = "",
			}
		},
	},

	-- LSP configuration and plugins
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			-- Useful status updates for LSP
			{ "j-hui/fidget.nvim", tag = "legacy", opts = {} },

			-- Additional lua configuration stuff
			-- docs and completion for nvim api
			"folke/neodev.nvim"
		},
	},
	{
		"mason-org/mason-lspconfig.nvim",
		opts = {
			ensure_installed={"rust_analyzer", "lua_ls"}
		},
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"neovim/nvim-lspconfig",
		},
	},
	-- Autocompletion
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			-- Snippet engine and its associated nvim-cmp
			{"L3MON4D3/LuaSnip", build = "make install_jsregexp"},
			"saadparwaiz1/cmp_luasnip",

			-- Adds LSP completion capabilities
			"hrsh7th/cmp-nvim-lsp",
		},
	},

	-- Fuzzy finder
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			-- fuzzy finder algo requires local deps to be built
			-- only load if `make` is available
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
				cond = function()
					return vim.fn.executable 'make' == 1
				end,
			},
		},
	},

	-- code highlighting plus
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		build = ":TSUpdate",
	},
}

