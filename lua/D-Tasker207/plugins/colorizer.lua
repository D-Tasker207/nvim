-- colorizer.lua - replaces hex color codes with a preview

return {
    "norcalli/nvim-colorizer.lua",
    event = "BufReadPre",
    config = function()
        require("colorizer").setup({ "*" }) -- apply to all filetypes
    end,
}