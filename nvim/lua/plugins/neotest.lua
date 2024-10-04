return {
  "nvim-neotest/neotest",
  depenendencies = {
    "fredrikaverpil/neotest-golang",
  },
  adapters = {
    ["neotest-golang"] = {
      go_test_args = { "-v", "-race", "-count=1" },
      dap_go_enabled = false,
    },
  },
}
