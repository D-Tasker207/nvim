# Neovim Configuration

## Features

- **Lazy.nvim** plugin management
- **LSP support** with `mason.nvim`, `mason-lspconfig`, and language-specific configs
- **Formatter & Linter integration** with `none-ls.nvim` (formerly `null-ls`)
- **Autocompletion** using `nvim-cmp`, `LuaSnip`, and LSP sources
- **Syntax highlighting** and code manipulation with `nvim-treesitter`
- **File explorer** via `neo-tree`
- **Telescope** for fuzzy finding and workspace tools
- **Git signs**, **statusline (lualine)**, and **terminal integration**
- **Full Java support** using `jdtls`

## Plugin Manager

Uses [Lazy.nvim](https://github.com/folke/lazy.nvim) for fast, lazy-loading plugin management.
Plugin specs are organized in `lua/D-Tasker207/plugins/`.

## Directory Structure

```text
~/.config/nvim/
├── init.lua
├── lua/
│   └─ D-Tasker207/
│      ├── settings.lua – Core Neovim options
│      ├── maps.lua     – Keymaps
│      ├── lazy.lua     – Lazy.nvim bootstra
│      └── plugins/     – All plugin specs
└── ftplugin/
    └── java.lua        – Per-project config for jdtls
```

## Getting Started

1. Clone this repo into your `~/.config/nvim/` directory
2. Run `nvim` and Lazy.nvim will auto-install
3. Use `:Mason` to view/manage LSPs, formatters, linters

## Requirements

- **Neovim** >= 0.9
- **`git`**, **`make`**, and a functional compiler toolchain
- **Java 21+** (required for `jdtls`)

## Language Support Highlights

### LSPs (via `mason-lspconfig`)

- Lua (`lua_ls`)
- TypeScript/JavaScript (`ts_ls`)
- Python (`pyright`)
- HTML/CSS/JSON (`html`, `cssls`, `jsonls`)
- Rust (`rust_analyzer`)
- C/C++ (`clangd`)
- Java (`jdtls`)
- Docker/CMake (`dockerls`, `cmake`)

### Formatters & Linters (via `none-ls.nvim`)

- `prettier`, `stylua`, `black`, `isort`, `shfmt`, `clang-format`
- `pylint`, `flake8`, `luacheck`, `yamllint`, `markdownlint`
  (Some of these are broken but for now I don't feel like fixing it)

## Keymaps (Essential)

| Mode  | Keybind           | Action                             |
| ----- | ----------------- | ---------------------------------- |
| `n`   | `<leader>w`       | Save current buffer                |
| `n`   | `<leader>q`       | Quit Neovim                        |
| `n`   | `<leader>e`       | Toggle NeoTree                     |
| `n`   | `<leader>o/p`     | Vertical / Horizontal split        |
| `n`   | `<leader>H/J/K/L` | Resize window ← ↓ ↑ →              |
| `n`   | `<C-h/j/k/l>`     | Navigate window ← ↓ ↑ →            |
| `n`   | `<leader>bn/bp`   | Next / Previous buffer             |
| `n`   | `<leader>tt`      | Toggle floating terminal           |
| `t`   | `<Esc>`           | Exit terminal mode                 |
| `n/v` | `<leader>/`       | Toggle comment (line or selection) |
| `n`   | `<leader>ff`      | Telescope: find files              |
| `n`   | `<leader>fg`      | Telescope: live grep               |

_For a full list of custom mappings, see [`maps.lua`](lua/D-Tasker207/maps.lua)._
_(Theres also like 5 in [`cmp.lua`](lua/D-Tasker207/plugins/cmp.lua) and several more in [`telescope.lua`](lua/D-Tasker207/plugins/telescope.lua))_

## Java Support

- Java support uses `jdtls` via `ftplugin/java.lua`
- Requires `JAVA_HOME` pointing to JDK 21+
- Automatic per-project workspace creation

## TODO / Enhancements

- Optional dashboard
- Snippet collections
- DAP/debugging config (Python, Java, etc.)

---
