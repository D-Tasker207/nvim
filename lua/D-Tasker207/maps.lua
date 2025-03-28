vim.g.mapleader = " "

local function map(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, { silent = true, desc = desc })
end

-- Save
map("n", "<leader>w", "<CMD>update<CR>", "Save current buffer")

-- Quit
map("n", "<leader>q", "<CMD>q<CR>", "Quit neovim")

-- Exit insert mode
map("i", "jk", "<ESC>", "Exit insert mode")

-- Toggle Term
map("n", "<F7>", "<cmd>ToggleTerm<cr>", "Toggle a terminal window")

-- Exit terminal mode
map("t", "<Esc>", [[<C-\><C-n>]], "Exit terminal mode")

-- NeoTree
map("n", "<leader>e", "<CMD>Neotree toggle<CR>", "Toggle Neotree window")
map("n", "<leader>r", "<CMD>Neotree focus<CR>", "Focus on Neotree window")

-- New Windows
map("n", "<leader>o", "<CMD>vsplit<CR>", "Create a new vertical split window")
map("n", "<leader>p", "<CMD>split<CR>", "Create new horizontal split window")

-- Window Navigation
map("n", "<C-h>", "<C-w>h", "Focus window left")
map("n", "<C-l>", "<C-w>l", "Focus window right")
map("n", "<C-k>", "<C-w>k", "Focus window up")
map("n", "<C-j>", "<C-w>j", "Focus window down")

-- Resize Windows
map("n", "<A-h>", "<C-w><", "Resize window left")
map("n", "<A-l>", "<C-w>>", "Resize window right")
map("n", "<A-k>", "<C-w>+", "Resize window up")
map("n", "<A-j>", "<C-w>-", "Resize window down")

-- Buffer Management
map("n", "<leader>bn", "<cmd>bnext<cr>", "Next buffer")
map("n", "<leader>bp", "<cmd>bprevious<cr>", "Previous buffer")
map("n", "<leader>bd", "<cmd>bd<cr>", "Close buffer")

-- Tab Management
map("n", "<leader>tn", "<cmd>tabnew<cr>", "New tab")
map("n", "<leader>tl", "<cmd>tabnext<cr>", "Next tab")
map("n", "<leader>th", "<cmd>tabprevious<cr>", "Previous tab")
map("n", "<leader>tc", "<cmd>tabclose<cr>", "Close tab")

-- Comment
map("n", "<leader>/", "<cmd>lua require('Comment.api').toggle.linewise.current()<CR>", "Toggle comment (line)")
map("v", "<leader>/", "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>", "Toggle comment (selection)")