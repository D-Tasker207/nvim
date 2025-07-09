-- none-ls.lua - Integrates formatters, linters

return {
	"nvimtools/none-ls.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"jay-babu/mason-null-ls.nvim",
	},
	config = function()
		local null_ls = require("null-ls")

		require("mason-null-ls").setup({
			ensure_installed = {
				-- Formatters
				"prettier",
				"stylua",
				"black",
				"isort",
				"shfmt",
				"clang-format",
				"terraform",

				-- Linters
				"pylint",
				"yamllint",
				"markdownlint",
				"terraform",
				"cpplint",
				"eslint_d"
			},
			automatic_installation = true,

			handlers = {
				function(source_name, methods)
					require("mason-null-ls").default_setup(source_name, methods)
				end,
			}
		})

		null_ls.setup({
			-- sources = {
			-- 	-- Formatters
			-- 	null_ls.builtins.formatting.prettier.with({
			-- 		extra_args = { "--insert-final-newline" },
			-- 	}),
			-- 	null_ls.builtins.formatting.stylua,
			-- 	null_ls.builtins.formatting.black,
			-- 	null_ls.builtins.formatting.isort,
			-- 	null_ls.builtins.formatting.shfmt,
			-- 	null_ls.builtins.formatting.clang_format,
			-- 	null_ls.builtins.formatting.terraform,

			-- 	-- Linters
			-- 	null_ls.builtins.diagnostics.pylint,
			-- 	null_ls.builtins.diagnostics.yamllint,
			-- 	null_ls.builtins.diagnostics.markdownlint,
			-- 	null_ls.builtins.diagnostics.terraform,
			-- 	null_ls.builtins.diagnostics.cpplint,
			-- 	null_ls.builtins.diagnostics.eslint_d,
			-- },

			on_attach = function(client, bufnr)
				if client.supports_method("textDocument/formatting") then
					local group = vim.api.nvim_create_augroup("LspFormatting", { clear = true })
					vim.api.nvim_clear_autocmds({ group = group, buffer = bufnr })
					vim.api.nvim_create_autocmd("BufWritePre", {
						group = vim.api.nvim_create_augroup("LspFormatting", { clear = true }),
						buffer = bufnr,
						callback = function()
							vim.lsp.buf.format({ bufnr = bufnr })
						end,
					})
				end
			end,
		})
	end,
}
