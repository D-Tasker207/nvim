-- treesitter.lua - sets up syntax highlighting 

local parsers = {
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
}

return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false, -- Load immediately on startup
    build = ":TSUpdate",
    dependencies = {
        "windwp/nvim-ts-autotag",
        {
            "nvim-treesitter/nvim-treesitter-textobjects",
            branch = "main",
        },
        "nvim-treesitter/nvim-treesitter-context",
    },
    config = function ()
        local ts = require("nvim-treesitter")

        ts.setup()
        ts.install(parsers)

        vim.api.nvim_create_autocmd("FileType", {
            pattern = parsers,
            callback = function()
                vim.treesitter.start()
                vim.bo.indentxpr = "v.lua.require'nvim-treesitter'.indentexpr()"
            end,
        })

        require("nvim-treesitter-textobjects").setup({
            select = {
                lookahead = true,
            },
            move = {
                set_jumps = true,
            },
        })

        local select = require("nvim-treesitter-textobjects.select")
        local move = require("nvim-treesitter-textobjects.move")

        vim.keymap.set({"x", "o"}, "af", function()
            select.select_textobject("@function.outer", "textobjects")
        end, { desc = "Select around function" })
        vim.keymap.set({"x", "o"}, "if", function()
            select.select_textobject("@function.inner", "textobjects")
        end, { desc = "Select inside function" })
        vim.keymap.set({"x", "o"}, "ac", function()
            select.select_textobject("@class.outer", "textobjects")
        end, { desc = "Select around class" })
        vim.keymap.set({"x", "o"}, "ic", function()
            select.select_textobject("@class.inner", "textobjects")
        end, { desc = "Select inside class" })
        vim.keymap.set({"x", "o"}, "as", function()
            select.select_textobject("@statement.outer", "textobjects")
        end, { desc = "Select around statement" })
        vim.keymap.set({"x", "o"}, "is", function()
            select.select_textobject("@statement.inner", "textobjects")
        end, { desc = "Select inside statement" })

        vim.keymap.set({"n", "x", "o"}, "]m", function()
            move.goto_next_start("@function.outer", "textobjects")
        end, { desc = "Go to next function start" })
        vim.keymap.set({"n", "x", "o"}, "]c", function()
            move.goto_next_start("@class.outer", "textobjects")
        end, { desc = "Go to next class start" })
        vim.keymap.set({"n", "x", "o"}, "]M", function()
            move.goto_next_end("@function.outer", "textobjects")
        end, { desc = "Go to next function end" })
        vim.keymap.set({"n", "x", "o"}, "]C", function()
            move.goto_next_end("@class.outer", "textobjects")
        end, { desc = "Go to next class end" })
        vim.keymap.set({"n", "x", "o"}, "[m", function()
            move.goto_previous_start("@function.outer", "textobjects")
        end, { desc = "Go to previous function start" })
        vim.keymap.set({"n", "x", "o"}, "[c", function()
            move.goto_previous_start("@class.outer", "textobjects")
        end, { desc = "Go to previous class start" })
        vim.keymap.set({"n", "x", "o"}, "[M", function()
            move.goto_previous_end("@function.outer", "textobjects")
        end, { desc = "Go to previous function end" })
        vim.keymap.set({"n", "x", "o"}, "[C", function()
            move.goto_previous_end("@class.outer", "textobjects")
        end, { desc = "Go to previous class end" })
    end,
}
<<<<<<< HEAD
=======

--         ts.setup({
--             ensure_installed = {
--                 "json",
--                 "javascript",
--                 "typescript",
--                 "tsx",
--                 "yaml",
--                 "html",
--                 "css",
--                 "markdown",
--                 "markdown_inline",
--                 "bash",
--                 "lua",
--                 "vim",
--                 "dockerfile",
--                 "gitignore",
--                 "c",
--                 "cpp",
--                 "rust",
--                 "cmake",
--                 "make",
--             },
--             highlight = {
--                 enabled = true,
--                 additional_vim_regex_highlighting = false,
--             },
--             indent = { enabled = true },
--             autotag = { enabled = true },
--             incremental_selection = {
--                 enabled = true,
--                 keymaps = {
--                     init_selection = "<C-space>",
--                     node_incremental = "<C-space>",
--                     node_decremental = "<bs>",
--                     scope_incremental = "<C-s>",
--                 },
--             },
--             textobjects = {
--                 select = {
--                     enable = true,
--                     lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
--                     keymaps = {
--                         ["af"] = "@function.outer", -- Select the whole function
--                         ["if"] = "@function.inner", -- Select the inner part of the function
--                         ["ac"] = "@class.outer", -- Select the whole class
--                         ["ic"] = "@class.inner", -- Select the inner part of the class
--                         ["as"] = "@statement.outer", -- Select the whole statement
--                         ["is"] = "@statement.inner", -- Select the inner part of the statement
--                     },
--                 },
--                 move = {
--                     enable = true,
--                     set_jumps = true, -- Whether to set jumps in the jumplist
--                     goto_next_start = {
--                         ["]m"] = "@function.outer", -- Go to next function start
--                         ["]c"] = "@class.outer", -- Go to next class start
--                     },
--                     goto_next_end = {
--                         ["]M"] = "@function.outer", -- Go to next function end
--                         ["]C"] = "@class.outer", -- Go to next class end
--                     },
--                     goto_previous_start = {
--                         ["[m"] = "@function.outer", -- Go to previous function start
--                         ["[c"] = "@class.outer", -- Go to previous class start
--                     },
--                     goto_previous_end = {
--                         ["[M"] = "@function.outer", -- Go to previous function end
--                         ["[C"] = "@class.outer", -- Go to previous class end
--                     },
--                 },
--             },
--             playground = {
--                 enable = true,
--                 updatetime = 25, -- Debounced time for highlighting nodes in the playground
--                 persist_queries = false, -- Whether the query persists across vim sessions
--             },
--         })
--     end,
-- }
>>>>>>> eab629e (migrate treesitter over to main branch from master)
