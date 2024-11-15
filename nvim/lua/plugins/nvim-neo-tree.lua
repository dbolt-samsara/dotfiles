return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    keys = {
      {
        "<leader>cS",
        function()
          require("neo-tree.command").execute({
            source = "document_symbols",
            toggle = true,
            position = "right",
            follow_cursor = true,
          })
        end,
        desc = "Symbols (neo-tree)",
      },
    },
    opts = function(_, opts)
      opts.sources = vim.tbl_extend("force", opts.sources or {}, {
        "filesystem",
        "buffers",
        "git_status",
        "document_symbols",
      })
    end,
  },
}
