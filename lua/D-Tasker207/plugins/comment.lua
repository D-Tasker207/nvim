-- comment.lua - API for toggling comment blocks
return {
    {
        "JoosepAlviste/nvim-ts-context-commentstring",
        config = function()
            vim.g.skip_ts_context_commentstring_module = true
            require("ts_context_commentstring").setup({
                enable_autocmd = false,
            })
        end,
    },
    {
        "numToStr/Comment.nvim",
        keys = {
            { 
                "<leader>/", 
                function() 
                    require("Comment.api").toggle.linewise.current()
                end,
                mode = "n",
                desc = "Toggle comment (line)"
            },
            {
                "<leader>/",
                function()
                    local esc = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)
                    vim.api.nvim_feedkeys(esc, "nx",  false)
                    require("Comment.api").toggle.linewise(vim.fn.visualmode())
                end,
                mode = "v",
                desc = "Toggle comment (selection)"
            }
        },
        dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
        config = function()
            local pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook()
            require("Comment").setup({
                pre_hook = function(ctx)
                    return pre_hook(ctx) or vim.bo.commentstring
                end,
            })
        end,
    }
}