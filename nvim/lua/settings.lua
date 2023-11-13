vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Misc options
vim.g.noswapfile = true
vim.g.noerrorbells = true
--- disable the mouse
vim.opt.mouse = ""
--- allow switching from buffers with changes
vim.opt.hidden = true
vim.opt.scrolloff = 6
--- allow local vimrcs
vim.opt.exrc = true
--- show line numbers
vim.opt.number = true
--- show whitespace
vim.opt.list = true
---
vim.opt.laststatus = 2

-- Search options
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.hlsearch = true

-- Tab options
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true

-- Fix backspacing
--vim.opt.backspace = indent, eol, start

-- Window creation
--- FIXME: find where these options are actually located
--vim.opt.setbelow = true
--vim.opt.setright = true

-- Terminal colors
--- FIXME: should check if the terminal actually suports colors
vim.o.termguicolors = true

