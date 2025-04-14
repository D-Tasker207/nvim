-- copilot_chat.lua - This configures the copilot text chat plugin

return {
	"CopilotC-Nvim/CopilotChat.nvim",
	cmd = { "CopilotChat", "CopilotChatVisual" },
	dependencies = {
		{ "zbirenbaum/copilot.lua" },
		{ "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions}
	},
	build = "make tiktoken", -- Only on MacOS or Linux
	keys = {
		-- Normal mode
		{ "<leader>cc", "<cmd>CopilotChat<CR>", desc = "Open Copilot Chat" },
		-- Visual Mode
		{ "<leader>cc", "<cmd>CopilotChatVisual<CR>", mode = "v", desc = "Chat about selection" },
	},
	opts = {
		window = {
			layout = "float",
			border = "rounded",
			width = 0.8,
			height = 0.6,
		},
	},
	config = function(_, opts)
		local chat = require("CopilotChat")
		chat.setup(opts)

		vim.api.nvim_create_autocmd("FileType", {
			pattern = "copilot_chat",
			callback = function()
				vim.keymap.set("n", "q", "<cmd>close<CR>", { buffer = true, silent = true })
			end,
		})
	end,
}
