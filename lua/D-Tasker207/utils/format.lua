-- Utility function for formatting
local M = {}

if vim.g.autoformat == nil then vim.g.autoformat = false end

function M.format(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  local clients = vim.lsp.get_clients({ bufnr = bufnr })
  local have_real = false
  for _, c in ipairs(clients) do
    if c.name ~= "null-ls" then have_real = true break end
  end
  vim.lsp.buf.format({
    bufnr = bufnr,
    async = true,
    filter = function(c)
      if have_real then return c.name ~= "null-ls" end
      return c.name == "null-ls"
    end,
  })
end

function M.setup_autosave()
  local grp = vim.api.nvim_create_augroup("FormatOnSave", { clear = true })
  vim.api.nvim_create_autocmd("LspAttach", {
    group = grp,
    callback = function(args)
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = grp,
        buffer = args.buf,
        callback = function(ev)
          if vim.g.autoformat then M.format(ev.buf) end
        end,
      })
    end,
  })
end

function M.enable()  vim.g.autoformat = true  end
function M.disable() vim.g.autoformat = false end
function M.toggle()  vim.g.autoformat = not vim.g.autoformat end

function M.setup_user_commands()
  vim.api.nvim_create_user_command("AutoFormatEnable",  M.enable,  { desc = "Enable autoformat on save" })
  vim.api.nvim_create_user_command("AutoFormatDisable", M.disable, { desc = "Disable autoformat on save" })
  vim.api.nvim_create_user_command("AutoFormatToggle",  M.toggle,  { desc = "Toggle autoformat on save" })
end

return M