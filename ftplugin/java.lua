local jdtls = require("jdtls")

-- Use the current working directory as the project root.
-- This is similar to how VSCode handles it.
local root_dir = vim.fn.getcwd()

-- Compute a workspace directory based on the current folder.
local home = os.getenv("HOME")
local project_name = vim.fn.fnamemodify(root_dir, ":t")
local workspace_dir = home .. "/.local/share/jdtls/workspace/" .. project_name

-- Get the path for jdtls installed by mason
local mason_registry = require("mason-registry")
local jdtls_install_dir = mason_registry.get_package("jdtls"):get_install_path()
local config_dir = vim.fn.stdpath("data") .. "/mason/share/jdtls/config"
local lombok_path = vim.fn.stdpath("data") .. "/mason/packages/jdtls/lombok.jar"
local launcher_jar = vim.fn.glob(jdtls_install_dir .. "/plugins/org.eclipse.equinox.launcher_*.jar")

-- Build the command used to start jdtls with Lombok support.
local cmd = {
  "java",
  "-javaagent:" .. lombok_path,  -- Attach Lombok as a javaagent
  "-Declipse.application=org.eclipse.jdt.ls.core.id1",
  "-Dosgi.bundles.defaultStartLevel=4",
  "-Declipse.product=org.eclipse.jdt.ls.core.product",
  "-Dlog.protocol=true",
  "-Dlog.level=ALL",
  "-Xmx1G",
  "--add-modules=ALL-SYSTEM",
  "--add-opens", "java.base/java.util=ALL-UNNAMED",
  "--add-opens", "java.base/java.lang=ALL-UNNAMED",
  "-jar", launcher_jar,
  "-configuration", config_dir,
  "-data", workspace_dir,
}

-- Ensure JAVA_HOME is set; adjust the path if needed.
vim.env.JAVA_HOME = vim.env.JAVA_HOME or "/opt/homebrew/opt/openjdk@21/libexec/openjdk.jdk/Contents/Home"

local capabilities = require("cmp_nvim_lsp").default_capabilities()

local on_attach = function(client, bufnr)
  if client.server_capabilities.documentFormattingProvider then
    local augroup = vim.api.nvim_create_augroup("LspFormatting", { clear = true })
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
  cmd = cmd,
  root_dir = root_dir,
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    java = {
      configuration = {
        updateBuildConfiguration = "interactive",
      },
    },
  },
  init_options = {
    bundles = {},
  },
}

jdtls.start_or_attach(config)
