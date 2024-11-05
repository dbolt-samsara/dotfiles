return {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "eslint_d",
        "stylelint",
      },
    },
  },
  {
    "mfussenegger/nvim-lint",
    linters_by_ft = {
      css = { "stylelint" },
      javascript = { "eslint_d" },
      typescript = { "eslint_d" },
      javascriptreact = { "eslint_d" },
      typescriptreact = { "eslint_d" },
    },
  },
}
