return {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "stylelint",
      },
    },
  },
  {
    "mfussenegger/nvim-lint",
    linters_by_ft = {
      css = { "stylelint" },
    },
  },
}
