local jdtls = require("jdtls")

local home = os.getenv("HOME")
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = home .. "/.local/share/jdtls/workspace/" .. project_name
local mason_registry = require("mason-registry")
local jdtls_path = mason_registry.get_package("jdtls"):get_install_path() .. "/bin/jdtls"

vim.env.JAVA_HOME = vim.env.JAVA_HOME or "/opt/homebrew/opt/openjdk@21/libexec/openjdk.jdk/Contents/Home"

local capabilities = require("cmp_nvim_lsp").default_capabilities()

local on_attach = function(client, bufnr)
  if client.server_capabilities.documentFormattingProvider then
    local augroup = vim.api.nvim_create_augroup("LspFormatting", { clear = false })

    vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = augroup,
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format({ bufnr = bufnr })
      end,
    })
  end
end

local config = {
  cmd = { jdtls_path },
  root_dir = jdtls.setup.find_root({ ".git", "mvnw", "gradlew", "pom.xml" }),
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    java = {},
  },
  init_options = {
    bundles = {},
  },
}

jdtls.start_or_attach(config)