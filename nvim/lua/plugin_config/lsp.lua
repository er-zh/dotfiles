-- [[Configure LSP]] --
local on_attach = function(_, bufnr)
	local nmap = function(keys, func, desc)
		if desc then
			desc = "LSP: " .. desc
		end

		vim.keymap.set("n", keys, func, {buffer=bufnr, desc=desc})
	end

	local builtin = require("telescope.builtin")

	nmap("<leader>rn", vim.lsp.buf.rename, "[r]e[n]ame")
	nmap("<leader>ca", vim.lsp.buf.code_action, "[c]ode [a]ction")

	nmap("<leader>gd", builtin.lsp_definitions, "[g]oto [d]efinition")
	nmap("<leader>gi", builtin.lsp_implementations, "[g]oto [i]mplementation")
	nmap("<leader>gt", builtin.lsp_type_definitions, "[g]et [t]ype definitions")
	
	nmap("<leader>K", vim.lsp.buf.hover, "Hover Documentation")
end

require("mason").setup()
local mason_lspconfig = require("mason-lspconfig")
mason_lspconfig.setup()

local servers = {
	clangd = {},
	gopls = {},
	pyright = {},
	rust_analyzer = {},
	lua_ls = {
		Lua = {
			workspace = {checkThirdParty = false},
			telemetry = {enable=false},
		},
	},
}

require("neodev").setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

mason_lspconfig.setup({
	ensure_installed = vim.tbl_keys(servers),
})
mason_lspconfig.setup_handlers({
	function(server_name)
		require("lspconfig")[server_name].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			settings = servers[server_name],
			filetypes = (servers[server_name] or {}).filetypes,
		})
	end,
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
	},
	{
		{name = "buffer"},
	}
	),
})

