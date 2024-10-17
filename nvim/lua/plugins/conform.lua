return {
  "stevearc/conform.nvim",
  opts = {
    formatters = {
      goimports = {
        prepend_args = { "-local", "samsaradev.io" },
      },
    },
  },
}
