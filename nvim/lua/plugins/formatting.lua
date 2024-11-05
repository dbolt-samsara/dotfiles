return {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {},
    },
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters = {
        goimports = {
          prepend_args = { "-local", "samsaradev.io" },
        },
      },
    },
  },
}
