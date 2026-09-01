-- codecompanion.lua - Local LLM chat and coding assistance through LM Studio

return {
  "olimorris/codecompanion.nvim",
  cmd = {
    "CodeCompanion",
    "CodeCompanionChat",
    "CodeCompanionActions",
  },

  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },

  keys = {
    {
      "<leader>cc",
      "<cmd>CodeCompanionChat Toggle<CR>",
      desc = "Open Code Companion",
    },
    {
      "<leader>cc",
      "<cmd>CodeCompanionChat Add<CR>",
      mode = "v",
      desc = "Add selection to AI Chat",
    },
    {
      "<leader>ca",
      "<cmd>CodeCompanionActions<CR>",
      mode = { "n", "v" },
      desc = "Open Code Companion Actions",
    },
  },

  config = function()
    local adapters = require("codecompanion.adapters")

    local function lmstudio_adapter(name, max_tokens, reasoning_effort)
      return adapters.extend("openai_compatible", {
        name = name,

        env = {
          url = "http://127.0.0.1:8467",
          api_key = "lm-studio",
          chat_url = "/v1/chat/completions",
        },

        schema = {
          model = {
            default = "qwen/qwen3.8-27b",
          },

          temperature = {
            default = 0.2,
          },

          max_tokens = {
            default = max_tokens,
          },

          reasoning_effort = {
            order = 4,
            mapping = "parameters",
            type = "string",
            optional = true,
            default = reasoning_effort,
          },
        },
      })
    end

    require("codecompanion").setup({
      display = {
        chat = {
          window = {
            layout = "vertical",
            position = "right",
            width = 0.4,
            full_height = true,

            border = "single",

            opts = {
              wrap = true,
              linebreak = true,
              breakindent = true,
            },
          },

          start_in_insert_mode = false,
          show_token_count = true,
          show_settings = false,

          -- You may prefer this since Qwen emits reasoning_content
          fold_reasoning = true,
          show_reasoning = false,
        },
      },

      adapters = {
        http = {
          lmstudio = function()
            return lmstudio_adapter("lmstudio", 800, "low")
          end,

          lmstudio_deep = function()
            return lmstudio_adapter("lmstudio_deep", 4096, "medium")
          end,
        },
      },

      interactions = {
        chat = {
          adapter = "lmstudio",
        },
        inline = {
          adapter = "lmstudio",
        },
      },
    })
  end,
}