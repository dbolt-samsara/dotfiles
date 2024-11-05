return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "fredrikaverpil/neotest-golang",
      "leoluz/nvim-dap-go",
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

      -- test debug
      { "<leader>td", function() vim.cmd('cd ' .. vim.fn.expand('%:p:h')) require("neotest").run.run({strategy = "dap"}) end, desc = "Debug Nearest" },

      -- test coverage
      -- https://github.com/andythigpen/nvim-coverage/blob/main/doc/nvim-coverage.txt
      { "<leader>tc", "", desc = "+coverage"},
      { "<leader>tcc", function() require("coverage").clear() end, desc = "Clear coverage report"},
      { "<leader>tct", function() require("coverage").toggle() end, desc = "Toggle coverage report"},
      { "<leader>tcs", function() require("coverage").summary() end, desc = "Summary coverage report"},
      { "<leader>tcl", function() require("coverage").load(true) end, desc = "Load coverage report"},
    },
    opts = function(_, opts)
      -- local root = vim.fn.system("git rev-parse --show-toplevel")
      -- local coveragePath
      -- if root ~= "" then
      --   root = root:gsub("\n", "")
      --   coveragePath = root .. "/coverage.out"
      -- else
      --   coveragePath = "./coverage.out"
      -- end

      table.insert(
        opts.adapters,
        require("neotest-golang")({
          go_test_args = { "-v", "-count=1", "-coverprofile=./coverage.out" },
          dap_go_enabled = true,
        })
      )
    end,
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    opts = {
      ensure_installed = {
        -- :MasonInstall delve@v1.20.0
        "delve@v1.20.0",
      },
    },
  },
  {
    "andythigpen/nvim-coverage",
    lazy = false,
    config = function()
      require("coverage").setup()
    end,
  },
}
