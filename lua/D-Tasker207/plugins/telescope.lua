-- telescope.lua -- fuzzy finder, enables searching and opening files,

return {
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.6",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("telescope").setup({
                defaults = {
                    initial_mode = "normal",
                    file_ignore_patterns = {
                        "node_modules",
                        "%.git",
                        "dist",
                        "build",
                        "target",
                        "__pycache__",
                        "env",
                        "venv",
                        "%.venv",
                        "%.idea",
                        "%.vscode",
                        "site-packages",
                        ".*%.lock",
                        ".*%.min.js",
                        ".*%.min.css",
                        ".*%.log",
                        ".*%.pyc",
                        ".*%.class",
                        ".*%.zip",
                        ".*%.tar.gz",
                        "%.terraform.*",
                     },
                    mappings = {
                        i = {
                            ["<C-h>"] = "which_key",
                            ["<C-j>"] = "move_selection_next",
                            ["<C-k>"] = "move_selection_previous",
                        },
                        n = {
                            ["q"] = require("telescope.actions").close,  
                        }
                    },
                },
                pickers = {
                    find_files = {
                        hidden = true,
                    },
                },
            })

            local keymap = vim.keymap
            keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
            keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Live grep in cwd" })
            keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Find open buffers" })
            keymap.set("n", "<leader>fs", "<cmd>Telescope git_status<cr>", { desc = "Git status (modified files)" })
            keymap.set("n", "<leader>fc", "<cmd>Telescope git_commits<cr>", { desc = "View git commit history" })
            keymap.set("n", "<leader>gr", "<cmd>Telescope lsp_references<cr>", { desc = "Find references" })
            keymap.set("n", "<leader>gd", "<cmd>Telescope lsp_definitions<cr>", { desc = "Go to definition" })
            keymap.set("n", "<leader>gi", "<cmd>Telescope lsp_implementations<cr>", { desc = "Go to implementation" })
            keymap.set("n", "<leader>gt", "<cmd>Telescope lsp_type_definitions<cr>", { desc = "Type definition" })
            keymap.set("n", "<leader>ld", "<cmd>Telescope diagnostics<cr>", { desc = "Document diagnostics" })
        end,
    },
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        config = function()
            require("telescope").load_extension("fzf")
        end,
    },
    {
        "nvim-telescope/telescope-file-browser.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("telescope").load_extension("file_browser")
        end,
    },
    {
        "ahmedkhalf/project.nvim",
        config = function()
            require("project_nvim").setup({})
            require("telescope").load_extension("projects")
        end,
    },
}