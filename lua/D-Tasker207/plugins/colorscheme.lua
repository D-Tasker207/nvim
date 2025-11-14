-- colorscheme.lua - Sets the color palatte

return {
    -- "ayu-theme/ayu-vim",
    "olimorris/onedarkpro.nvim",
    priority = 1000,
    config = function()
    -- vim.g.ayucolor = "mirage"
    -- vim.o.background = "dark"
    vim.cmd("colorscheme onedark")
    end,
}