-- copilot.lua - handles github copilot setup

return {
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "BufReadPost",
		config = function()
			require("copilot").setup({
				suggestion = { enabled = false },
				panel = { enabled = false },
			})
		end,
	},

	{
		"zbirenbaum/copilot-cmp",
		dependencies = { "zbirenbaum/copilot.lua" },
		config = function()
			require("copilot_cmp").setup()
		end,
	},
}
