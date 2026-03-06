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
			handlers = {
        function(source_name, methods)
          -- default for everything else
          mnull.default_setup(source_name, methods)
        end,

        -- custom setup for markdownlint (disables MD013)
        markdownlint = function()
          null_ls.register(null_ls.builtins.diagnostics.markdownlint.with({
            extra_args = { "--disable", "MD013" },
          }))
        end,
      },
		})

		null_ls.setup({})
	end,
}
