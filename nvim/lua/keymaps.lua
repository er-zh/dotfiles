-- key remappings
local map = vim.api.nvim_set_keymap
local silentnoremap = {noremap=true, silent=true}

-- unmap leader key
map("n", "<Space>", "<Nop>", {silent=true})

-- moving around
--- treat visual lines as actual lines
map("n", "j", "gj", silentnoremap)
map("n", "k", "gk", silentnoremap)
--- move around windows
map("n", "<C-l>", "<C-w><C-l>", silentnoremap)
map("n", "<C-k>", "<C-w><C-k>", silentnoremap)
map("n", "<C-j>", "<C-w><C-j>", silentnoremap)
map("n", "<C-h>", "<C-w><C-h>", silentnoremap)
map("n", "<S-Tab>", "<C-w>w", silentnoremap)

