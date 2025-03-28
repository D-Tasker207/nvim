-- treesitter.lua - sets up syntax highlighting 

return {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPre", "BufNewFile" },
    build = ":TSUpdate",
    dependencies = {
        "windwp/nvim-ts-autotag",
        "JoosepAlviste/nvim-ts-context-commentstring",
    },
    config = function ()
        local treesitter = require("nvim-treesitter.configs")

        treesitter.setup({
            ensure_installed = {
                "json",
                "javascript",
                "typescript",
                "tsx",
                "yaml",
                "html",
                "css",
                "markdown",
                "markdown_inline",
                "bash",
                "lua",
                "vim",
                "dockerfile",
                "gitignore",
                "c",
                "cpp",
                "rust",
                "cmake",
                "make",
            },
            highlight = {
                enabled = true,
                additional_vim_regex_highlighting = false,
            },
            indent = { enabled = true },
            autotag = { enabled = true },
            incremental_selection = {
                enabled = true,
                keymaps = {
                    init_selection = "<C-space>",
                    node_incremental = "<C-space>",
                    scope_incremental = false,
                    node_decremental = "<bs>",
                },
            },
            comment_commentstring = {
                enable = true,
                enable_autocmd = false,
            },
        })
    end,
}