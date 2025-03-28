-- comment.lua - API for toggling comment blocks
return {
    "numToStr/Comment.nvim",
    config = function()
        require("Comment").setup()
    end,
}