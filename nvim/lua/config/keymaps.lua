---@diagnostic disable: need-check-nil
-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set
local unpack = table.unpack or unpack

-- save
map("n", "<Leader>w", ":w<CR>", { desc = "save", silent = true })

-- delete key
map("i", "<C-d>", "<Esc>lxi", { desc = "del", silent = true })

-- Resize window using <alt> arrow keys
map("n", "<A-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
map("n", "<A-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
map("n", "<A-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
map("n", "<A-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

-- Copy / paste
map("v", "<C-c>", '"+y', { desc = "Ctrl+C will copy onto clipboard, assumes terminal replaces Cmd+c -> Ctrl+c" })
map("v", "p", "<s-p>", { desc = "Paste using system clipboard, and over selected text without yanking it." })
map("v", "p", "<s-p>", { desc = "Paste using system clipboard, and over selected text without yanking it." })
map("v", "p", "<s-P>", { desc = "Paste using system clipboard, and over selected text without yanking it." })
map("v", "P", "<s-P>", { desc = "Paste using system clipboard, and over selected text without yanking it." })

---------------------------------------------------------------------------------------------------------
--------------------------------- VSCode Mappings  ------------------------------------------------------
---------------------------------------------------------------------------------------------------------
if vim.g.vscode then
  local function vscode(command)
    -- Add debug print
    vim.notify("VSCode command: " .. command, vim.log.levels.INFO)
    return string.format("<cmd>call VSCodeNotify('%s')<CR>", command)
  end

  -- State for file explorer toggle
  local explorer_focused = false
  local function toggle_explorer()
    explorer_focused = not explorer_focused
    local command = explorer_focused and "workbench.files.action.focusFilesExplorer" or "workbench.action.closeSidebar"
    vim.fn.VSCodeNotify(command)
  end

  -- Common LazyVim keymaps mapped to VSCode equivalents
  -- https://www.lazyvim.org/keymaps
  local keymaps = {
    -- Undo/Redo
    { "n", "u", "undo" },
    { "n", "<C-r>", "redo" },

    -- File navigation
    { "n", "<leader><leader>", "workbench.action.quickOpen" },
    { "n", "<leader>ff", "workbench.action.quickOpen" },
    { "n", "<leader>ff", "workbench.action.quickOpen" },
    { "n", "<leader>fb", "workbench.action.showAllEditors" },
    { "n", "<leader>,", "workbench.action.showAllEditors" },

    -- Search
    { "n", "<leader>/", "workbench.action.findInFiles" },

    -- File explorer (stateful toggle)
    { "n", "<leader>e", toggle_explorer },

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

    -- Window splits
    { "n", "<leader>-", "workbench.action.splitEditorDown" },
    { "n", "<leader>|", "workbench.action.splitEditorRight" },

    -- Window navigation with conditional behavior
    { "n", "<c-h>", "workbench.action.navigateLeft" },
    { "n", "<C-j>", "workbench.action.navigateDown" },
    { "n", "<C-k>", "workbench.action.navigateUp" },
    { "n", "<C-l>", "workbench.action.navigateRight" },

    -- Panel toggles
    { "n", "<leader>ue", "workbench.action.toggleSidebarVisibility" },
    { "n", "<leader>ub", "workbench.action.togglePanel" },
    { "n", "<leader>ur", "workbench.action.toggleAuxiliaryBar" },

    -- Open File On Remote
    { "n", "<leader>cx", "gitlens.openFileOnRemote" },
    { "v", "<leader>cx", "gitlens.openFileOnRemote" },
  }

  -- Apply all keymaps
  for _, keymap in pairs(keymaps) do
    local mode, lhs, rhs = unpack(keymap)
    if type(rhs) == "function" then
      vim.keymap.set(mode, lhs, rhs, { silent = true })
    else
      vim.keymap.set(mode, lhs, vscode(rhs), { silent = true })
    end
  end
end

---------------------------------------------------------------------------------------------------------
--------------------------------- Get GitHub link for selected code -------------------------------------
---------------------------------------------------------------------------------------------------------
if not vim.g.vscode then
  local function link_to_github()
    local repo_root = vim.fn.trim(vim.fn.system("git rev-parse --show-toplevel"))
    local url_root = vim.fn.trim(vim.fn.system('git remote get-url origin | sed "s/.*git@//" | sed "s/.git$//"'))

    -- Convert git URL to web URL format
    url_root = url_root
      :gsub("^git@", "https://")
      :gsub("^https://", "https://")
      :gsub("%.git$", "")
      :gsub("github.com:", "github.com/")

    -- Get the upstream tracking branch's commit hash
    -- If no upstream is set, fallback to origin/HEAD
    local hash_cmd = "git rev-parse @{upstream} 2>/dev/null || git rev-parse origin/HEAD"
    local commit_hash = vim.fn.trim(vim.fn.system(hash_cmd))

    local file_path_relative_to_repo_root = vim.fn.expand("%:p"):gsub(repo_root, "")

    -- Get the visual selection coordinates from the current selection
    local start_pos = vim.fn.getpos("v")
    local end_pos = vim.fn.getpos(".")
    local start_line = math.min(start_pos[2], end_pos[2])
    local end_line = math.max(start_pos[2], end_pos[2])

    local url = string.format(
      "https://%s/blob/%s%s#L%d-L%d",
      url_root,
      commit_hash,
      file_path_relative_to_repo_root,
      start_line,
      end_line
    )

    -- Copy to clipboard
    vim.fn.setreg("+", url)
    vim.notify("URL copied: " .. url, vim.log.levels.INFO)

    -- Open in browser
    vim.fn.jobstart({ "open", url }, { detach = true })
  end

  map("v", "<leader>cx", link_to_github, { noremap = true, silent = true, desc = "Link to GitHub" })
end
