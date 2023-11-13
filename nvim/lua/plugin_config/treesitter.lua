-- [[Configure Treesitter]] --
-- See `:help nvim-treesitter`
vim.defer_fn(function()
	require("nvim-treesitter.configs").setup({
		ensure_installed = {"c", "cpp", "go", "lua", "python", "rust", "vim"},
		sync_install = false,
		auto_install = false,
		highlight = { enable = true },
	})
end, 0)

