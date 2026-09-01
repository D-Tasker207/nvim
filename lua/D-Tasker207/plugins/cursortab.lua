-- cursortab.lua - Local AI completions through LM Studio

return {
  "cursortab/cursortab.nvim",
  event = "InsertEnter",
  build = "cd server && go build",

  config = function()
    require("cursortab").setup({
      enabled = true,

      keymaps = {
        -- Do not touch <Tab>; it remains free for indentation
        accept = "<C-l>", -- Accept the current suggestion

        -- Optional: accept only part of a suggestion
        partial_accept = "<M-l>",

        -- Completions are automatic
        trigger = false,
      },

      provider = {
        -- Start with "inline"
        --
        -- if model supports FIM, change this to "fim"
        type = "fim",

        url = "http://localhost:8467", -- LM Studio server URL
        completion_path = "/v1/completions",

        -- curl http://localhost:8467/v1/models
        model = "qwen/qwen2.5-coder-14b",

        -- Good starting values for a fast local model
        max_tokens = 128,
        context_size = 4096,

        temperature = 0.0,

        -- Local models can occasionally take longer to prefill
        completion_timeout = 10000,

        privacy_mode = true,
      },
    })
  end,
}