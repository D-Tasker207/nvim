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
		local mason = require("mason")
		local mlsp = require("mason-lspconfig")

		-- Start Mason
		mason.setup()
		mlsp.setup({
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
        "terraformls",
			},
		})

		-- Capabilities for nvim-cmp
		local caps = require("cmp_nvim_lsp").default_capabilities()
		caps.offsetEncoding = {"utf-16"} -- for clangd
		vim.lsp.config("defaults", { capabilities = caps, on_attach = function() end })

		-- Optional: specific Neovim config for Lua LSP
		require("neodev").setup({
			library = {
				enabled = true,
				runtime = true,
				types = true,
				plugins = true,
			},
			setup_jsonls = true,
			pathStrict = true,
			debug = false,
		}) -- enhances Lua workspace understanding

		vim.lsp.config("lua_ls", {
			capabilities = capabilities,
			settings = {
				Lua = {
					workspace = { checkThirdParty = false },
					telemetry = { enable = false },
				},
			},
		})

		for _, server_name in ipairs(mlsp.get_installed_servers()) do
			if server_name ~= "jdtls" then
				vim.lsp.enable(server_name)
			end
		end

		local fmt = require("D-Tasker207.utils.format")
		fmt.setup_autosave()
		fmt.setup_user_commands()
	end,
}
