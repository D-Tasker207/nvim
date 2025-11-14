-- none-ls.lua - Integrates formatters, linters

return {
	"nvimtools/none-ls.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"jay-babu/mason-null-ls.nvim",
	},
	config = function()
		local null_ls = require("null-ls")
		local mnull = require("mason-null-ls")

		mnull.setup({
			ensure_installed = {
				-- Formatters
				"black",
				"isort",
				"shfmt",

				-- Linters
				"yamllint",
				"markdownlint",
			},
			automatic_installation = true,
			handlers = { function(source_name, methods) mnull.default_setup(source_name, methods) end }
		})

		null_ls.setup({})
	end,
}
