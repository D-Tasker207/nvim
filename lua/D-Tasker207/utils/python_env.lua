-- Resolves project Python environment details for LSP and diagnostics tools.
local M = {}

local venv_names = { ".venv", "venv", "env", ".env" }
local root_markers = {
  "pyproject.toml",
  "setup.py",
  "setup.cfg",
  "requirements.txt",
  "Pipfile",
  ".git",
}

local function path_join(...)
  return table.concat({ ... }, "/")
end

local function executable(path)
  return path and vim.fn.executable(path) == 1
end

local function is_file_or_dir(path)
  return path and vim.uv.fs_stat(path) ~= nil
end

local function dir_name(path)
  return path:match("(.+)/[^/]+$")
end

local function base_name(path)
  return path:match("([^/]+)$")
end

local function normalize_dir(path)
  if not path or path == "" then
    return nil
  end
  local stat = vim.uv.fs_stat(path)
  if stat and stat.type == "file" then
    return dir_name(path)
  end
  return path
end

local function iter_parents(start_dir)
  local current = normalize_dir(start_dir)
  return function()
    if not current then
      return nil
    end
    local out = current
    local parent = dir_name(current)
    if not parent or parent == current then
      current = nil
    else
      current = parent
    end
    return out
  end
end

local function find_local_venv_upwards(start_dir)
  for current in iter_parents(start_dir) do
    for _, name in ipairs(venv_names) do
      local venv_dir = path_join(current, name)
      local python_path = path_join(venv_dir, "bin", "python")
      if executable(python_path) then
        return {
          venv_dir = venv_dir,
          python_path = python_path,
        }
      end
    end
  end
  return nil
end

local function detect_project_root(start_dir)
  for current in iter_parents(start_dir) do
    for _, marker in ipairs(root_markers) do
      if is_file_or_dir(path_join(current, marker)) then
        return current
      end
    end
  end
  return nil
end

local function fallback_python()
  local py = vim.fn.exepath("python3")
  if py == "" then
    py = vim.fn.exepath("python")
  end
  if py == "" then
    py = "python"
  end
  return py
end

function M.resolve(root_dir, file_path)
  local file_dir = normalize_dir(file_path)
  local project_root = detect_project_root(file_dir or root_dir)
  local local_venv = find_local_venv_upwards(file_dir)
    or find_local_venv_upwards(project_root)
    or find_local_venv_upwards(root_dir)

  if local_venv then
    return {
      python_path = local_venv.python_path,
      venv = base_name(local_venv.venv_dir),
      venv_path = dir_name(local_venv.venv_dir),
    }
  end

  local active_venv = vim.env.VIRTUAL_ENV or vim.env.CONDA_PREFIX
  if active_venv and active_venv ~= "" then
    local python_path = path_join(active_venv, "bin", "python")
    if executable(python_path) then
      return {
        python_path = python_path,
        venv = base_name(active_venv),
        venv_path = dir_name(active_venv),
      }
    end
  end

  return {
    python_path = fallback_python(),
    venv = nil,
    venv_path = nil,
  }
end

function M.find_python(root_dir, file_path)
  local env = M.resolve(root_dir, file_path)
  return env.python_path
end

return M