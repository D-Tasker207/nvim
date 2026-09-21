local M = {}

function M.resolve(root_dir)
  if root_dir then
    local project_python = root_dir .. "/.venv/bin/python"

    if vim.fn.executable(project_python) == 1 then
      return {
        python_path = project_python,
      }
    end
  end

  return {
    python_path = vim.fn.exepath("python3"),
  }
end

return M
