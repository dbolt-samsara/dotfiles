return {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "prettier",
        "stylelint",
      },
    },
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        css = { "prettier", "stylelint" },
      },
      formatters = {
        goimports = {
          prepend_args = { "-local", "samsaradev.io" },
        },
      },
    },
  },
}
