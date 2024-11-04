return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    -- stylua: ignore
    keys = {
      { "<leader>aD", "<cmd>Copilot disable<cr>", desc = "Disable (Copilot)" },
      { "<leader>aE", "<cmd>Copilot enable<cr>", desc = "Enable (Copilot)" },
      { "<leader>aP", function() require("copilot.panel").open() end, desc = "Panel (Copilot)" },
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
}
