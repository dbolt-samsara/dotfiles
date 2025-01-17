return {
  {
    "LazyVim/LazyVim",
    opts = function(_, opts)
      -- Enable all plugins even in VSCode
      opts.vscode = {
        -- Enable LazyVim keymaps
        enabled = true,
        -- Keep all plugins enabled
        plugins = {
          -- Core plugins
          telescope = true,
          treesitter = true,
          -- UI plugins
          neo_tree = true,
          lualine = true,
          -- Editor plugins
          mini = true,
          which_key = true,
          -- LSP plugins
          lsp = true,
          cmp = true,
        },
      }
    end,
  },
  {
    "LazyVim/LazyVim",
    config = function()
      if vim.g.vscode then
        local function vscode(command)
          return string.format("<cmd>call VSCodeNotify('%s')<CR>", command)
        end

        -- Common LazyVim keymaps mapped to VSCode equivalents
        -- https://www.lazyvim.org/keymaps
        local keymaps = {
          -- File navigation
          { "n", "<leader><leader>", "workbench.action.quickOpen" },
          { "n", "<leader>ff", "workbench.action.quickOpen" },
          { "n", "<leader>fr", "workbench.action.openRecent" },
          { "n", "<leader>fb", "workbench.action.showAllEditors" },
          { "n", "<leader>,", "workbench.action.showAllEditors" },

          -- Search
          { "n", "<leader>sg", "workbench.action.findInFiles" },
          { "n", "<leader>sw", "workbench.action.findInFiles" },
          { "n", "<leader>/", "workbench.action.findInFiles" },

          -- File explorer
          { "n", "<leader>e", "workbench.action.toggleSidebarVisibility" },

          -- Buffer/Editor/Window management
          { "n", "<leader>w", "workbench.action.files.save" },
          -- Close editor group and window
          { "n", "<leader>q", "workbench.action.closeAllEditors" },
          { "n", "<leader>bd", "workbench.action.closeActiveEditor" },
          { "n", "<leader>wd", "workbench.action.closeActiveEditor" },
          -- Buffer navigation
          { "n", "<S-h>", "workbench.action.previousEditor" },
          { "n", "<S-l>", "workbench.action.nextEditor" },

          -- LSP features
          { "n", "gd", "editor.action.revealDefinition" },
          { "n", "gr", "editor.action.goToReferences" },
          { "n", "gI", "editor.action.goToImplementation" },
          { "n", "K", "editor.action.showHover" },
          { "n", "<leader>ca", "editor.action.quickFix" },
          { "n", "<leader>cr", "editor.action.rename" },

          -- Diagnostics
          { "n", "<leader>cd", "editor.action.showHover" },
          { "n", "[d", "editor.action.marker.prev" },
          { "n", "]d", "editor.action.marker.next" },

          -- Window splits
          { "n", "<leader>-", "workbench.action.splitEditorDown" },
          { "n", "<leader>|", "workbench.action.splitEditorRight" },

          -- Window navigation with conditional behavior
          { "n", "<c-h>", "workbench.action.navigateleft" },
          { "n", "<C-j>", "workbench.action.navigateDown" },
          { "n", "<C-k>", "workbench.action.navigateUp" },
          { "n", "<C-l>", "workbench.action.navigateRight" },

          -- Panel toggles
          { "n", "<leader>ue", "workbench.action.toggleSidebarVisibility" }, -- Toggle left sidebar
          { "n", "<leader>ub", "workbench.action.togglePanel" }, -- Toggle bottom panel
          { "n", "<leader>ur", "workbench.action.toggleAuxiliaryBar" }, -- Toggle right sidebar
        }

        -- Apply all keymaps
        for _, map in pairs(keymaps) do
          local mode, lhs, rhs = table.unpack(map)
          -- Handle both string and function values for rhs
          local cmd = type(rhs) == "function" and rhs() or vscode(rhs)
          vim.keymap.set(mode, lhs, cmd, { silent = true })
        end
      end
    end,
  },
}
