-- [[Configure LSP]] --
require("neodev").setup()

local on_attach = function(_, bufnr)
	local nmap = function(keys, func, desc)
		if desc then
			desc = "LSP: " .. desc
		end

		vim.keymap.set("n", keys, func, {buffer=bufnr, desc=desc})
	end

	local builtin = require("telescope.builtin")

    vim.lsp.inlay_hint.enable(true, {bufnr = bufnr})

	nmap("<leader>rn", vim.lsp.buf.rename, "[r]e[n]ame")
	nmap("<leader>ca", vim.lsp.buf.code_action, "[c]ode [a]ction")

	nmap("<leader>gd", builtin.lsp_definitions, "[g]oto [d]efinition")
	nmap("<leader>gi", builtin.lsp_implementations, "[g]oto [i]mplementation")
	nmap("<leader>gt", builtin.lsp_type_definitions, "[g]et [t]ype definitions")

	nmap("<leader>K", vim.lsp.buf.hover, "Hover Documentation")
	nmap("<leader>E", vim.diagnostic.open_float, "Hover Error Diagnostic")
end

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

vim.lsp.config("*", {
	on_attach = on_attach,
	capabilities = capabilities
})
vim.lsp.config("clangd", {
	on_attach = on_attach,
	root_markers = {
		"compile_commands.json",
	},
	capabilities = capabilities,
	cmd = {
		"clangd",
		"-j=8",
		"--background-index",
		"--limit-references=0",
		"-header-insertion=never",
		"--log=verbose",
	},
})
vim.lsp.config("rust_analyzer", {
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		rustfmt = { enable = true },
		semanticHighlighting = { doc = { comment = { inject = { enable = false }}}}
	}
})

vim.diagnostic.config({
	virtual_text = true,
})

-- Configure nvim-cmp while we're at it
-- See `:help cmp`

local cmp = require("cmp")
local luasnip = require("luasnip")
require("luasnip.loaders.from_vscode").lazy_load()
luasnip.config.setup({})

cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		['<C-n>'] = cmp.mapping.select_next_item(),
		['<C-p>'] = cmp.mapping.select_prev_item(),
		['<C-b>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.abort(),
		['<CR>'] = cmp.mapping.confirm({ select = true }),
	}),
	sources = cmp.config.sources(
		{
			{name = "nvim_lsp"},
			{name = "luasnip"},
			{name = "buffer"},
		}
	),
})

