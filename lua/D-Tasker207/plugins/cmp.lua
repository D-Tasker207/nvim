-- cmp.lua - Autocompletions

return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/cmp-nvim-lua",
		{
			"L3MON4D3/LuaSnip",
			version = "v2.*",
			build = "make install_jsregexp",
		},
		"saadparwaiz1/cmp_luasnip",
		"rafamadriz/friendly-snippets",
		"onsails/lspkind.nvim",
	},
	config = function()
		local cmp = require("cmp")
		local luasnip = require("luasnip")
		local lspkind = require("lspkind")

		require("luasnip.loaders.from_vscode").lazy_load()

		cmp.setup({
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body) -- expand snippet body
				end,
			},
			mapping = cmp.mapping.preset.insert({
				-- <C-j>: Select the next completion item
				["<C-j>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
					else
						fallback()
					end
				end, { "i", "s" }),

				-- <C-k>: Select the previous completion item
				["<C-k>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					else
						fallback()
					end
				end, { "i", "s" }),

				-- <C-l>: Confirm completion
				-- 
				-- CursorTab will also use <C-l>, but its completion
				-- should only be accepted when the cmp menu is not
				-- actively being used
				["<C-l>"] = cmp.mapping(function(fallback)
					if cmp.visible() and entry then
						cmp.confirm({ select = true })
					else
						fallback()
					end
				end, { "i", "s" }),

				-- <C-Space>: Manually trigger the completion menu
				["<C-Space>"] = cmp.mapping.complete(),

				-- <C-e>: Abort completion or close menu
				["<C-e>"] = cmp.mapping.close(),
			}),
			sources = cmp.config.sources({
				{ name = "nvim_lsp" }, -- LSP completions
				{ name = "luasnip" }, -- Snippets from LuaSnip
				{ name = "buffer" }, -- Words from current buffer
				{ name = "path" }, -- File paths
			}),
			formatting = {
				fields = { "kind", "abbr", "menu" },
				expandable_indicator = true,
				format = lspkind.cmp_format({
					mode = "symbol_text", -- Show symbol + text (e.g. "  variable")
					maxwidth = 50, -- Limit popup width
					ellipsis_char = "...",
				}),
			},
		})

		-- Cmdline `:` setup (e.g. for :e, :! etc)
		cmp.setup.cmdline(":", {
			mapping = cmp.mapping.preset.cmdline(),
			sources = cmp.config.sources({
				{ name = "path" }, -- Paths for commands like `:e`
				{ name = "cmdline" }, -- Command history
			}),
		})

		-- Cmdline `/` or `?` setup (search in buffer)
		cmp.setup.cmdline("/", {
			mapping = cmp.mapping.preset.cmdline(),
			sources = {
				{ name = "buffer" }, -- Search words in buffer
			},
		})

		-- Recommended completion behavior
		vim.cmd([[
        set completeopt=menuone,noinsert,noselect
        highlight! default link CmpItemKind CmpItemMenuDefault
      ]])
	end,
}
