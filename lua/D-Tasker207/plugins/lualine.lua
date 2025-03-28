-- lualine.lua - replaces status line with better formatting

return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("lualine").setup({
			options = {
				theme = "auto",
				section_separators = "",
				component_separators = "|",
				always_divide_middle = true,
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = {
					"branch",
					"diff",
					{
						"diagnostics",
						sources = { "nvim_diagnostic" },
						sections = { "error", "warn", "info", "hint" },
						symbols = { error = "❌ ", warn = "⚠️ ", info = "❔ ", hint = "💡 " },
						colored = true,
						update_in_insert = false,
						always_visible = false,
					},
				},
				lualine_c = {
					{ "filename", path = 1 }, -- relative path
				},
				lualine_w = {
					function()
						local ok, copilot = pcall(vim.fn["copilot#Enabled"])
						return ok and copilot == 1 and " Copilot" or ""
					end,
				},
				lualine_x = {
					"searchcount",
					"filesize",
					"fileformat",
					"encoding",
					"filetype",
				},
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},

			tabline = {
				lualine_a = { "buffers" },
				lualine_z = { "tabs" },
			},

			extensions = { "lazy" },
		})
	end,
}
