-- neotree_toggle.lua - toggles directory group in neotree

local M = {}

M.opts = {
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
			group_empty_dirs = true,
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
}
-- Toggle state variable (not persistant between sessions or windoww)

local group_dirs_enabled = true

function M.toggle_group_empty_dirs()
  local current = M.opts.filesystem.group_empty_dirs
  M.opts.filesystem.group_empty_dirs = not current

  require("neo-tree").setup(M.opts)

  vim.notify("NeoTree: group_empty_dirs = " .. tostring(M.opts.filesystem.group_empty_dirs), vim.log.levels.INFO)
  vim.cmd("Neotree close")
  vim.cmd("Neotree show")
end

return M
