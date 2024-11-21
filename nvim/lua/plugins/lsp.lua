return {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {},
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      opts.servers = vim.tbl_extend("force", opts.servers, {
        vtsls = {
          settings = {
            typescript = {
              tsserver = {
                maxTsServerMemory = 8192,
              },
            },
          },
        },
      })

      opts.servers = vim.tbl_extend("force", opts.servers, {
        cssls = {},
      })

      -- Eslint
      -- use .eslintrc-incremental.js if it exists
      local eslint_config_path = ".eslintrc-incremental.js"
      local eslint_options = {}
      if vim.fn.filereadable(eslint_config_path) == 1 then
        eslint_options = {
          overrideConfigFile = eslint_config_path,
        }
      end
      opts.servers = vim.tbl_extend("force", opts.servers, {
        eslint = {
          settings = {
            options = eslint_options,
          },
        },
      })
    end,
  },
}
