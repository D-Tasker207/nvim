-- lsp.lua - Language server configuration

return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "folke/neodev.nvim", opts = {} },
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
  },
  config = function()
    -- Required modules
    local mason = require("mason")
    local mlsp = require("mason-lspconfig")
    local python_env = require("D-Tasker207.utils.python_env")

    -- Start Mason
    mason.setup()
    mlsp.setup({
      ensure_installed = {
        "lua_ls",
        "ts_ls",
        "pyright",
        "html",
        "cssls",
        "jsonls",
        "eslint",
        "tailwindcss",
        "rust_analyzer",
        "clangd",
        "dockerls",
        "cmake",
        "terraformls",
      },
    })

    -- Capabilities for nvim-cmp
    local capabilities = require("cmp_nvim_lsp").default_capabilities()
    capabilities.offsetEncoding = { "utf-16" } -- for clangd

    -- Common on_attach: enable inlay hints for rust-analyzer
    local function on_attach(client, bufnr)
      if client.name == "rust_analyzer"
        and client.server_capabilities.inlayHintProvider
      then
        -- Neovim 0.10+ API
        vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
      end
    end

    -- Set defaults for ALL servers
    -- (your previous "defaults" string doesn't do anything; use "*" here)
    vim.lsp.config("*", {
      capabilities = capabilities,
      on_attach = on_attach,
    })

    -- rust-analyzer specific settings (explicitly turn on type hints)
    vim.lsp.config("rust_analyzer", {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        ["rust-analyzer"] = {
          inlayHints = {
            typeHints = {
              enable = true,
              hideClosureInitialization = false,
              hideNamedConstructor = false,
            },
            parameterHints = { enable = true },
            chainingHints  = { enable = true },
            bindingModeHints = { enable = true },
            closingBraceHints = {
              enable = true,
              minLines = 0,
            },
            renderColons = true,
            maxLength = 25,
          },
        },
      },
    })

    -- Optional: specific Neovim config for Lua LSP
    require("neodev").setup({
      library = {
        enabled = true,
        runtime = true,
        types = true,
        plugins = true,
      },
      setup_jsonls = true,
      pathStrict = true,
      debug = false,
    })

    vim.lsp.config("lua_ls", {
      capabilities = capabilities,
      settings = {
        Lua = {
          workspace = { checkThirdParty = false },
          telemetry = { enable = false },
        },
      },
    })

    vim.lsp.config("pyright", {
      capabilities = capabilities,
      on_attach = on_attach,
      before_init = function(_, config)
        local resolved = python_env.resolve(config.root_dir)

        config.settings = config.settings or {}
        config.settings.python = config.settings.python or {}
        config.settings.python.pythonPath = resolved.python_path

        if resolved.venv and resolved.venv_path then
          config.settings.python.venv = resolved.venv
          config.settings.python.venvPath = resolved.venv_path
        end
      end,
      on_new_config = function(new_config, new_root_dir)
        local resolved = python_env.resolve(new_root_dir)

        new_config.settings = new_config.settings or {}
        new_config.settings.python = new_config.settings.python or {}
        new_config.settings.python.pythonPath = resolved.python_path

        if resolved.venv and resolved.venv_path then
          new_config.settings.python.venv = resolved.venv
          new_config.settings.python.venvPath = resolved.venv_path
        end
      end,
      settings = {
        python = {
          analysis = {
            autoSearchPaths = true,
            useLibraryCodeForTypes = true,
            diagnosticMode = "workspace",
          },
        },
      },
    })

    -- Enable all installed servers
    for _, server_name in ipairs(mlsp.get_installed_servers()) do
      if server_name ~= "jdtls" then
        vim.lsp.enable(server_name)
      end
    end

    local fmt = require("D-Tasker207.utils.format")
    fmt.setup_autosave()
    fmt.setup_user_commands()
  end,
}
