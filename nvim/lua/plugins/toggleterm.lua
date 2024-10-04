return {
  "akinsho/toggleterm.nvim",
  config = function()
    require("toggleterm").setup({
      open_mapping = [[<c-\>]],
      shade_terminals = false,
      -- add --login so ~/.zprofile is loaded
      -- https://vi.stackexchange.com/questions/16019/neovim-terminal-not-reading-bash-profile/16021#16021
      shell = "zsh --login",
    })
  end,
  keys = {
    { "<leader>bt", "<cmd>ToggleTerm direction=float<CR>", desc = "Open floating terminal" },
    { "<leader>bT", "<cmd>ToggleTerm direction=horizontal<CR>", desc = "Open split terminal" },
  },
}
