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
            
              -- Linters
              "pylint",
              "yamllint",
              "markdownlint",
            },
            automatic_installation = true,
        })

        null_ls.setup({
            sources = {
                -- Formatters
                null_ls.builtins.formatting.prettier,
                null_ls.builtins.formatting.stylua,
                null_ls.builtins.formatting.black,
                null_ls.builtins.formatting.isort,
                null_ls.builtins.formatting.shfmt,
                null_ls.builtins.formatting.clang_format,

                -- Linters
                null_ls.builtins.diagnostics.pylint,
                null_ls.builtins.diagnostics.yamllint,
                null_ls.builtins.diagnostics.markdownlint,
            },

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