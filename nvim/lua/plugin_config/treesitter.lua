-- [[Configure Treesitter]] --
-- See `:help nvim-treesitter`
vim.defer_fn(function()
	require("nvim-treesitter").setup({
		ensure_installed = {"c", "cpp", "rust", "lua", "python", "vim"},
		sync_install = false,
		auto_install = false,
		highlight = { enable = true },
	})
end, 0)

