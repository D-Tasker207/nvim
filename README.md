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
│      ├── lazy.lua     – Lazy.nvim bootstrap
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
- **`git`**, **`make`**, **`gcc`**, **`lua`**, **`npm`**, **`yarn`**, **`python`**
- **Java 21+** (required for `jdtls`)

Probably additional things too but I don't have time to test this at the moment.

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
_More can be installed via :Mason_

## Keymaps

`<leader>` is by defualt the `<space>` key however this is configurable in [`maps.lua`](./lua/D-Tasker207/maps.lua)

### Vim actions

| Mode  | Keybind           | Action                             |
| ----- | ----------------- | ---------------------------------- |
| `n`   | `<leader>w`       | Save current buffer                |
| `n`   | `<leader>q`       | Quit Neovim                        |
| `i`   | `jk`              | Exit Insert Mode                   |

### Neotree (File explorer)

| Mode  | Keybind           | Action                             |
| ----- | ----------------- | ---------------------------------- |
| `n`   | `<leader>e`       | Toggle NeoTree                     |
| `n`   | `<leader>r`       | Focus NeoTree window               |
| `n`   | `<leader>tg`      | Toggle Empty Directory Grouping    |

### Window/Tab management

| Mode  | Keybind           | Action                             |
| ----- | ----------------- | ---------------------------------- |
| `n`   | `<leader>o`       | Vertical Split                     |
| `n`   | `<leader>p`       | Horizontal Split                   |
| `n`   | `<leader>H/J/K/L` | Resize window ← ↓ ↑ →              |
| `n`   | `<C-h/j/k/l>`     | Navigate window ← ↓ ↑ →            |
| `n`   | `<leader>bn/bp`   | Next / Previous buffer             |
| `n`   | `<leader>tn`      | New Tab                            |
| `n`   | `<leader>tc`      | Close Tab                          |
| `n`   | `<leader>tl`      | Next Tab                           |
| `n`   | `<leader>th`      | Previous Tab                       |

### Toggle Terminal

| Mode  | Keybind           | Action                             |
| ----- | ----------------- | ---------------------------------- |
| `n`   | `<leader>tt`      | Toggle floating terminal           |
| `t`   | `<Esc>`           | Exit terminal mode                 |

### Commenting

| Mode  | Keybind           | Action                             |
| ----- | ----------------- | ---------------------------------- |
| `n`   | `<leader>/`       | Toggle Line Comment                |
| `n`   | `<leader>/`       | Toggle Selection Comment           |

### Telescope (Fuzzy Finder & Live Grep)

| Mode  | Keybind           | Action                             |
| ----- | ----------------- | ---------------------------------- |
| `n`   | `<leader>le`      | Show Diagnostics Under Cusor       |
| `n`   | `<leader>ld`      | Show Diagnostics In Project        |
| `n`   | `<leader>ff`      | Live Find Files                    |
| `n`   | `<leader>fg`      | Life Grep Files                    |
| `n`   | `<leader>fb`      | Find Open Buffers                  |
| `n`   | `<leader>fs`      | Git Diff Modified Files            |
| `n`   | `<leader>fc`      | List Git Commit History            |
| `n`   | `<leader>gr`      | List references to symbol          |
| `n`   | `<leader>gd`      | Go To Symbol Definition            |
| `n`   | `<leader>gi`      | Go To Implementation               |
| `n`   | `<leader>gt`      | Go To Type Definition              |
| `n`   | `<C-u>`           | Scroll Grep Preview Up             |
| `n`   | `<C-d>`           | Scroll Grep Preview Down           |
| `n`   | `q`               | Close Telescope Window             |

## Treesitter
Provides syntax tree features. Specific features depend on language.
Use `:TSUpdate` to see a list of all available modules and install status.
Use `:checkhealth nvim-treesitter` to see capabilities of all installed modules.

Here are some keybinds that may or may not work depending on module capabilities.

| Mode  | Keybind           | Action                                 |
| ----- | ----------------- | -------------------------------------- |
| `v`   | `af`              | Select the whole function              |
| `v`   | `if`              | Select the inner part of the function  |
| `v`   | `ac`              | Select the whole class                 |
| `v`   | `ic`              | Select the inner part of the class     |
| `v`   | `as`              | Select the whole statement             |
| `v`   | `is`              | Select the inner part of the statement |
| `n`   | `]m`              | Go to next function start              |
| `n`   | `]c`              | Go to next class start                 |
| `n`   | `]M`              | Go to next function end                |
| `n`   | `]C`              | Go to next class end                   |
| `n`   | `[m`              | Go to previous function start          |
| `n`   | `[c`              | Go to previous class start             |
| `n`   | `[M`              | Go to previous function end            |
| `n`   | `[C`              | Go to previous class end               |

## Java Support

- Java support uses `jdtls` via `ftplugin/java.lua`
- Requires `JAVA_HOME` pointing to JDK 21+
- Automatic per-project workspace creation

## TODO / Enhancements

- Optional dashboard
- Snippet collections
- DAP/debugging config (Python, Java, etc.)

---
