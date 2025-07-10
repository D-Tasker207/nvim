-- treesitter.lua - sets up syntax highlighting 

return {
    "nvim-treesitter/nvim-treesitter",
    branch = main,
    lazy = false, -- Load immediately on startup
    build = ":TSUpdate",
    dependencies = {
        "windwp/nvim-ts-autotag",
        "JoosepAlviste/nvim-ts-context-commentstring",
        "nvim-treesitter/nvim-treesitter-textobjects",
        "nvim-treesitter/playground",
        "nvim-treesitter/nvim-treesitter-context",
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
                    node_decremental = "<bs>",
                    scope_incremental = "<C-s>",
                },
            },
            textobjects = {
                select = {
                    enable = true,
                    lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
                    keymaps = {
                        ["af"] = "@function.outer", -- Select the whole function
                        ["if"] = "@function.inner", -- Select the inner part of the function
                        ["ac"] = "@class.outer", -- Select the whole class
                        ["ic"] = "@class.inner", -- Select the inner part of the class
                        ["as"] = "@statement.outer", -- Select the whole statement
                        ["is"] = "@statement.inner", -- Select the inner part of the statement
                    },
                },
                move = {
                    enable = true,
                    set_jumps = true, -- Whether to set jumps in the jumplist
                    goto_next_start = {
                        ["]m"] = "@function.outer", -- Go to next function start
                        ["]c"] = "@class.outer", -- Go to next class start
                    },
                    goto_next_end = {
                        ["]M"] = "@function.outer", -- Go to next function end
                        ["]C"] = "@class.outer", -- Go to next class end
                    },
                    goto_previous_start = {
                        ["[m"] = "@function.outer", -- Go to previous function start
                        ["[c"] = "@class.outer", -- Go to previous class start
                    },
                    goto_previous_end = {
                        ["[M"] = "@function.outer", -- Go to previous function end
                        ["[C"] = "@class.outer", -- Go to previous class end
                    },
                },
            },
            playground = {
                enable = true,
                updatetime = 25, -- Debounced time for highlighting nodes in the playground
                persist_queries = false, -- Whether the query persists across vim sessions
            },
            ts_context_commentstring = {
                enable = true,
                enable_autocmd = false,
            },
        })
    end,
}