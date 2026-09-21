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
    local mason = require("mason")
    local mlsp = require("mason-lspconfig")
    local python_env = require("D-Tasker207.utils.python_env")

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

    -- Keep all LSP clients on the same position encoding.
    capabilities.general = capabilities.general or {}
    capabilities.general.positionEncodings = { "utf-16" }

    local function on_attach(client, bufnr)
      if client.name == "rust_analyzer"
        and client.server_capabilities.inlayHintProvider
      then
        vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
      end
    end

    -- Defaults for all servers
    vim.lsp.config("*", {
      capabilities = capabilities,
      on_attach = on_attach,
    })

    -- Rust
    vim.lsp.config("rust_analyzer", {
      settings = {
        ["rust-analyzer"] = {
          inlayHints = {
            typeHints = {
              enable = true,
              hideClosureInitialization = false,
              hideNamedConstructor = false,
            },
            parameterHints = {
              enable = true,
            },
            chainingHints = {
              enable = true,
            },
            bindingModeHints = {
              enable = true,
            },
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

    -- Neovim/Lua
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
      settings = {
        Lua = {
          workspace = {
            checkThirdParty = false,
          },
          telemetry = {
            enable = false,
          },
        },
      },
    })

    -- Python
    vim.lsp.config("pyright", {
      root_markers = {
        "pyproject.toml",
        "setup.py",
        "setup.cfg",
        "requirements.txt",
        "Pipfile",
        ".git",
        ".venv",
      },
      
      before_init = function(_, config)
        local resolved = python_env.resolve(config.root_dir)

        config.settings = config.settings or {}
        config.settings.python = config.settings.python or {}

        config.settings.python.pythonPath = resolved.python_path
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

    -- Enable all Mason-managed servers.
    -- jdtls is normally started separately by nvim-jdtls.
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
