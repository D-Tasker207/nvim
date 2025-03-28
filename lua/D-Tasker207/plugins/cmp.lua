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
        -- <Tab>: Select the next completion item
        ["<Tab>"] = cmp.mapping.select_next_item(),

        -- <S-Tab>: Select the previous completion item
        ["<S-Tab>"] = cmp.mapping.select_prev_item(),

        -- <CR>: Confirm selected completion item
        -- If no item is selected, selects the first one
        ["<CR>"] = cmp.mapping.confirm({ select = true }),

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
        format = lspkind.cmp_format({
          mode = "symbol_text", -- Show symbol + text (e.g. "  variable")
          maxwidth = 50,   -- Limit popup width
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

