return {
  {
    "folke/tokyonight.nvim",
    opts = { style = "night" },
  },
  { "ellisonleao/gruvbox.nvim" },
  {
    "AlexvZyl/nordic.nvim",
    config = function()
      require("nordic").setup({
        bright_border = true,
        telescope = {
          style = "classic",
        },
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
      -- colorscheme = "catppuccin",
      --colorscheme = "habamax",
      -- colorscheme = "gruvbox",
      colorscheme = "nordic",
    },
  },
}
