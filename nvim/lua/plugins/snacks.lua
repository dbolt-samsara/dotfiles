return {
  "folke/snacks.nvim",

  -- stylua: ignore
  keys = {
  },

  opts = {
    dashboard = {
      preset = {
        -- https://patorjk.com/software/taag/#p=display&f=ANSI%20Shadow&t=BOLT%20VIM
        header = [[
        ██████╗  ██████╗ ██╗  ████████╗    ██╗   ██╗██╗███╗   ███╗
        ██╔══██╗██╔═══██╗██║  ╚══██╔══╝    ██║   ██║██║████╗ ████║
        ██████╔╝██║   ██║██║     ██║       ██║   ██║██║██╔████╔██║
        ██╔══██╗██║   ██║██║     ██║       ╚██╗ ██╔╝██║██║╚██╔╝██║
        ██████╔╝╚██████╔╝███████╗██║        ╚████╔╝ ██║██║ ╚═╝ ██║
        ╚═════╝  ╚═════╝ ╚══════╝╚═╝         ╚═══╝  ╚═╝╚═╝     ╚═╝
 ]],
      },
      sections = {
        { section = "header" },
        { section = "keys", gap = 1 },
        { icon = " ", title = "Projects", section = "projects", indent = 2, padding = { 2, 2 } },
        { section = "startup" },
      },
    },
  },
}
