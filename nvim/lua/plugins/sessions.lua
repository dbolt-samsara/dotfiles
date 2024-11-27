return {
  {
    "folke/persistence.nvim",
    enabled = false,
    opts = {
      branch = true, -- use git branch to save session
    },
  },
  {
    "olimorris/persisted.nvim",
    lazy = false,
    config = function()
      require("persisted").setup({
        autostart = true,
        should_save = function()
          return true
        end,
        save_dir = vim.fn.expand(vim.fn.stdpath("data") .. "/sessions/"),
        follow_cwd = true,
        use_git_branch = true,
        autoload = false,
        on_autoload_no_session = function() end,
        allowed_dirs = {},
        ignored_dirs = {},
        telescope = {
          mappings = {
            copy_session = "<C-c>",
            change_branch = "<C-b>",
            delete_session = "<C-d>",
          },
          icons = { -- icons displayed in the Telescope picker
            selected = " ",
            dir = "  ",
            branch = " ",
          },
        },
      })

      -- use the Telescope extension to load a session, saving the current session before clearing all of the open buffers
      vim.api.nvim_create_autocmd("User", {
        pattern = "PersistedTelescopeLoadPre",
        callback = function(_)
          -- Save the currently loaded session using the global variable
          require("persisted").save({ session = vim.g.persisted_loaded_session })

          -- Delete all of the open buffers
          vim.api.nvim_input("<ESC>:%bd!<CR>")
        end,
      })
    end,

    -- stylua: ignore
    keys = {
      { "<leader>qs", "<cmd>SessionLoadLast<cr>", desc = "Load Last Session" },
      {
        "<leader>qS",
        function() require("telescope.command").load_command("persisted") end,
        desc = "Pick Session",
      },
      { "<leader>ql",
        function()
          vim.cmd('silent! %bdelete!')
          vim.cmd("SessionLoad")

        end,
        desc = "Load session for current directory and branch",
      },
      { "<leader>qd", "<cmd>SessionStop<cr>", desc = "Don't Save Current Session" },
    },
  },
}
