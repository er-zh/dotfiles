-- [[ Configure Telescope ]] --
-- See `:help telescope`
require("telescope").setup({
	defaults = {
		mappings = {},
	},
})

-- Enable telescope fzf native if installed
pcall(require("telescope").load_extension, "fzf")

local builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader>ff", builtin.find_files, {desc="[f]ind [f]iles"})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {desc="[f]ind by [g]rep"})
vim.keymap.set("n", "<leader>lb", function() builtin.buffers({sort_mru=true, ignore_current_buffer=true}) end, {desc="[l]ist [b]uffers"})

