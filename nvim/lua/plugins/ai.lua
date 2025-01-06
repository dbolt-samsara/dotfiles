vim.g.copilot_toggle_enabled = true

return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    -- version = "v2.16.0",
    -- stylua: ignore
    keys = {
      -- {"<leader>aa", true},
      -- {"<leader>aE", true},
      -- {"<leader>aD", true},
      -- { "<leader>ac", "<cmd>CopilotChatToggle<cr>", desc = "Toggle (CopilotChat)" },
      -- { "<leader>aC",
      --   function()
      --     vim.g.copilot_toggle_enabled = not vim.g.copilot_toggle_enabled
      --     if vim.g.copilot_toggle_enabled then
      --       vim.cmd("Copilot enable")
      --       vim.notify("Copilot enabled", vim.log.levels.INFO)
      --     else
      --       vim.cmd("Copilot disable")
      --       vim.notify("Copilot disabled", vim.log.levels.INFO)
      --     end
      --   end,
      --   desc = "Toggle Copilot"
      -- },
    },
    opts = {
      model = "claude-3.5-sonnet",
    },
  },
  {
    "zbirenbaum/copilot.lua",
    opts = {
      panel = {
        enabled = true,
        auto_refresh = true,
      },
    },
  },
  -- {
  --   "yetone/avante.nvim",
  --   event = "VeryLazy",
  --   lazy = false,
  --   version = false, -- set this if you want to always pull the latest change
  --   opts = {
  --     provider = "copilot",
  --     auto_suggestions_provider = "copilot",
  --   },
  --   -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  --   build = "make",
  --   -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
  --   dependencies = {
  --     "nvim-treesitter/nvim-treesitter",
  --     "stevearc/dressing.nvim",
  --     "nvim-lua/plenary.nvim",
  --     "MunifTanjim/nui.nvim",
  --     --- The below dependencies are optional,
  --     "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
  --     "zbirenbaum/copilot.lua", -- for providers='copilot'
  --     {
  --       -- support for image pasting
  --       "HakonHarnes/img-clip.nvim",
  --       event = "VeryLazy",
  --       opts = {
  --         -- recommended settings
  --         default = {
  --           embed_image_as_base64 = false,
  --           prompt_for_file_name = false,
  --           drag_and_drop = {
  --             insert_mode = true,
  --           },
  --         },
  --       },
  --     },
  --     {
  --       -- Make sure to set this up properly if you have lazy=true
  --       "MeanderingProgrammer/render-markdown.nvim",
  --       opts = {
  --         file_types = { "markdown", "Avante" },
  --       },
  --       ft = { "markdown", "Avante" },
  --     },
  --   },
  -- },
}
