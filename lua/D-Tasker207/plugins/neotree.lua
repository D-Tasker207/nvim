-- neotree.lua - file explorer for nvim

return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	event = "VeryLazy",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	opts = {
		filesystem = {
			filtered_items = {
				visible = true,
				show_hidden_count = true,
				hide_dotfiles = false,
				hide_gitignored = true,
				hide_by_name = {
					".git",
					".DS_Store",
					"thumbs.db",
				},
				never_show = {},
			},
		},
		window = {
			mappings = {
				["l"] = "open",
				["h"] = "close_node",
				["<CR>"] = "open",
				["?"] = "show_help",
			},
		},
		git_status_symbols = {
			added = "A",
			modified = "M",
			deleted = "D",
			renamed = "R",
			untracked = "U",
			ignored = "!",
			staged = "✓", -- Optional
			conflict = "?",
		},
	},
}
