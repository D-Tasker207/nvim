-- lsp.lua - Language server configuration

return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "folke/neodev.nvim", opts = {} },
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
	},
	config = function()
		-- Required modules
		local lspconfig = require("lspconfig")
		local mason = require("mason")
		local mason_lspconfig = require("mason-lspconfig")

		-- Start Mason
		mason.setup()
		mason_lspconfig.setup({
			ensure_installed = {
				"lua_ls",
				"ts_ls",
				"pyright",
				"html",
				"cssls",
				"jsonls",
				"eslint",
				"tailwindcss",
				"rust_analyzer",
				"clangd",
				"dockerls",
				"cmake",
			},
		})

		-- Capabilities for nvim-cmp
		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		-- on_attach function, applies to every LSP
		local on_attach = function(client, bufnr)
			-- Enable format on save
			if client.server_capabilities.documentFormattingProvider then
				-- Only create the autocommand group once
				local augroup = vim.api.nvim_create_augroup("LspFormatting", { clear = false })

				vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
				vim.api.nvim_create_autocmd("BufWritePre", {
					group = augroup,
					buffer = bufnr,
					callback = function()
						vim.lsp.buf.format({ bufnr = bufnr })
					end,
				})
			end
		end

		-- Default setup handler
		mason_lspconfig.setup_handlers({
			function(server_name)
				if server_name == "jdtls" then
					return -- we manage this in ftplugin/java.lua
				end

				lspconfig[server_name].setup({
					capabilities = capabilities,
					on_attach = on_attach,
				})
			end,

			-- Optional: Custom setup per server if needed
			-- ["tsserver"] = function()
			--   lspconfig.tsserver.setup({
			--     capabilities = capabilities,
			--     on_attach = on_attach,
			--     settings = { ... }
			--   })
			-- end,
		})

		-- Optional: specific Neovim config for Lua LSP
		require("neodev").setup({
			library = {
				enabled = true,
				runtime = true,
				types = true,
				plugins = true,
			},
			setup_jsonls = true,
			override = {},
			lspconfig = true,
			pathStrict = true,
			debug = false,
		}) -- enhances Lua workspace understanding

		lspconfig.lua_ls.setup({
			capabilities = capabilities,
			on_attach = on_attach,
			settings = {
				Lua = {
					workspace = { checkThirdParty = false },
					telemetry = { enable = false },
				},
			},
		})
	end,
}
