---@diagnostic disable: need-check-nil
-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

-- save
map("n", "<Leader>w", ":w<CR>", { desc = "save", silent = true })

-- delete key
map("i", "<C-d>", "<Esc>lxi", { desc = "del", silent = true })

-- Resize window using <alt> arrow keys
map("n", "<A-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
map("n", "<A-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
map("n", "<A-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
map("n", "<A-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

map("v", "p", "<s-p>", { desc = "Paste using system clipboard, and over selected text without yanking it." })
map("v", "p", "<s-p>", { desc = "Paste using system clipboard, and over selected text without yanking it." })
map("v", "p", "<s-P>", { desc = "Paste using system clipboard, and over selected text without yanking it." })
map("v", "P", "<s-P>", { desc = "Paste using system clipboard, and over selected text without yanking it." })
---------------------------------------------------------------------------------------------------------
--------------------------------- Get GitHub link for selected code -------------------------------------
---------------------------------------------------------------------------------------------------------
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
