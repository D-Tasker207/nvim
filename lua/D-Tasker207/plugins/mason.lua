-- mason.lua - Installs LSP servers, linters, and formatters using mason.nvim

return {
  "mason-org/mason.nvim",
	dependencies = {
    "williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		require("mason").setup({
			ui = {
				check_outdated_packages_on_open = true,
				border = "rounded",
			},
		})

		-- Ensure all tools are installed
		require("mason-tool-installer").setup({
			ensure_installed = {
				-- LSP servers
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
				"terraformls",

				-- Formatters
				"black",
				"isort",
				"shfmt",
				"stylua",
				"prettier",

				-- Linters
				"yamllint",
				"markdownlint",
				"ruff",
				"shellcheck",
			},
			auto_update = false,
			run_on_start = true,
			start_delay = 3000, -- 3 second delay after VimEnter
			debounce_hours = 5, -- at least 5 hours between attempts
		})
	end,
}
