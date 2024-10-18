return {
  "nvim-neotest/neotest",
  dependencies = {
    "fredrikaverpil/neotest-golang",
  },
    -- stylua: ignore
    keys = {
      {"<leader>t", "", desc = "+test"},
      -- cd to the buffers current directory before running the tests, this tis to make it work with large monorepos
      { "<leader>tt", function() vim.cmd('cd ' .. vim.fn.expand('%:p:h')) require("neotest").run.run(vim.fn.expand("%")) end, desc = "Run File" },
      { "<leader>tT", function() vim.cmd('cd ' .. vim.fn.expand('%:p:h')) require("neotest").run.run(vim.uv.cwd()) end, desc = "Run All Test Files" },
      { "<leader>tr", function() vim.cmd('cd ' .. vim.fn.expand('%:p:h')) require("neotest").run.run() end, desc = "Run Nearest" },
      { "<leader>tl", function() vim.cmd('cd ' .. vim.fn.expand('%:p:h')) require("neotest").run.run_last() end, desc = "Run Last" },
      { "<leader>ts", function() vim.cmd('cd ' .. vim.fn.expand('%:p:h')) require("neotest").summary.toggle() end, desc = "Toggle Summary" },
      { "<leader>to", function() vim.cmd('cd ' .. vim.fn.expand('%:p:h')) require("neotest").output.open({ enter = true, auto_close = true }) end, desc = "Show Output" },
      { "<leader>tO", function() vim.cmd('cd ' .. vim.fn.expand('%:p:h')) require("neotest").output_panel.toggle() end, desc = "Toggle Output Panel" },
      { "<leader>tS", function() vim.cmd('cd ' .. vim.fn.expand('%:p:h')) require("neotest").run.stop() end, desc = "Stop" },
      { "<leader>tw", function() vim.cmd('cd ' .. vim.fn.expand('%:p:h')) require("neotest").watch.toggle(vim.fn.expand("%")) end, desc = "Toggle Watch" },
    },

  opts = {
    adapters = {
      "neotest-golang",
    },
  },
}
