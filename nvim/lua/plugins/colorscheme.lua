return {
  {
    "folke/tokyonight.nvim",
    lazy = true,
    opts = { style = "night" },
  },
  { "ellisonleao/gruvbox.nvim", lazy = true },
  {
    "AlexvZyl/nordic.nvim",
    lazy = true,
    config = function()
      require("nordic").setup({
        bright_border = true,
        cursorline = {
          theme = "light",

          blend = 0.5,
        },
      })
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      -- colorscheme = "tokyonight",
      colorscheme = "catppuccin-mocha",
      --colorscheme = "habamax",
      -- colorscheme = "gruvbox",
      -- colorscheme = "nordic",
    },
  },
}
