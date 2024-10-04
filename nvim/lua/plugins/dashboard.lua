return {
  "nvimdev/dashboard-nvim",
  opts = function(_, opts)
    -- https://patorjk.com/software/taag/#p=display&f=ANSI%20Shadow&t=BOLT%20VIM
    local logo = [[
        ██████╗  ██████╗ ██╗  ████████╗    ██╗   ██╗██╗███╗   ███╗
        ██╔══██╗██╔═══██╗██║  ╚══██╔══╝    ██║   ██║██║████╗ ████║
        ██████╔╝██║   ██║██║     ██║       ██║   ██║██║██╔████╔██║
        ██╔══██╗██║   ██║██║     ██║       ╚██╗ ██╔╝██║██║╚██╔╝██║
        ██████╔╝╚██████╔╝███████╗██║        ╚████╔╝ ██║██║ ╚═╝ ██║
        ╚═════╝  ╚═════╝ ╚══════╝╚═╝         ╚═══╝  ╚═╝╚═╝     ╚═╝
    ]]

    logo = string.rep("\n", 8) .. logo .. "\n\n"
    opts.config.header = vim.split(logo, "\n")
  end,
}
