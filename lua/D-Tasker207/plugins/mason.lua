-- mason.lua - Installs LSP servers, linters, and formatters using mason.nvim

return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		require("mason").setup()

		require("mason-lspconfig").setup({
			ensure_installed = {
				-- Web
				"cssls",
				"html",
				"jsonls",
				"ts_ls",
				"eslint",
				"tailwindcss",

				-- Python
				"pyright",

				-- Systems/Infra
				"dockerls",	
				"clangd",
				"cmake",
				-- "makefile_language_server",
				"rust_analyzer",

				-- Lua
				"lua_ls",

				-- Java
				"jdtls",
			},
		})

		require("mason-tool-installer").setup({
			ensure_installed = {
				-- Formatters
				"prettier",
				"stylua",
				"black",
				"isort",
				"shfmt",
				"clang-format",

				-- Linters
				"pylint",
				"yamllint",
				"markdownlint",
			},
		})
	end,
}
