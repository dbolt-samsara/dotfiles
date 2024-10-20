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

map("v", "p", "<s-p>", { desc = "Paste over currently selected text without yanking it" })

---------------------------------------------------------------------------------------------------------
--------------------------------- Get GitHub link for selected code -------------------------------------
---------------------------------------------------------------------------------------------------------
local function chomped_system(cmd)
  local handle = io.popen(cmd)
  local result = handle:read("*a")
  handle:close()
  return result:gsub("\n$", "")
end

local function link_to_github()
  local repo_root = chomped_system("git rev-parse --show-toplevel")
  local url_root =
    chomped_system('git config --get remote.origin.url | sed "s/git@github.com:/github.com\\//" | sed "s/.git$//"')
  local branch = chomped_system('git status -sb | grep "...origin/" | sed "s/.*origin\\///"')
  local file_path_relative_to_repo_root = vim.fn.expand("%:p"):gsub(repo_root, "")
  local start_line = vim.fn.getpos("'<")[2]
  local end_line = vim.fn.getpos("'>")[2]

  local url =
    string.format("%s/tree/%s/%s#L%d-L%d", url_root, branch, file_path_relative_to_repo_root, start_line, end_line)
  vim.fn.setreg("+", url)
  print(url)
end

-- stylua: ignore
vim.api.nvim_create_user_command("LinkToGitHub", link_to_github, { range = true })
map("v", "<leader>cx", ":LinkToGitHub<CR>", { noremap = true, silent = true, desc = "Link to GitHub" })
