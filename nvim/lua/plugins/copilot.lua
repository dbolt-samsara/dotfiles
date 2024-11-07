return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    -- stylua: ignore
    keys = {
      { "<leader>aD", "<cmd>Copilot disable<cr>", desc = "Disable (Copilot)" },
      { "<leader>aE", "<cmd>Copilot enable<cr>", desc = "Enable (Copilot)" },
      { "<leader>aP", "<cmd>Copilot panel<cr>", desc = "Panel (Copilot)" },
      { "<leader>al", "<cmd>CopilotChatLoadPrompt<cr>", desc = "Load (CopilotChat)"},
      { "<leader>as", "<cmd>CopilotChatSavePrompt<cr>", desc = "Save (CopilotChat)"},
      { "<leader>ad", "<cmd>CopilotChatDeletePrompt<cr>", desc = "Delete (CopilotChat)"},

    },
    opts = function()
      vim.api.nvim_create_user_command("CopilotChatSavePrompt", function()
        local history_dir = require("CopilotChat").config.history_path

        -- Prompt the user to enter the chat name
        vim.ui.input({ prompt = "Enter Copilot Chat name to save: " }, function(input)
          if input then
            require("CopilotChat").save(input, history_dir)
          end
        end)
      end, {})

      vim.api.nvim_create_user_command("CopilotChatLoadPrompt", function()
        local history_dir = require("CopilotChat").config.history_path
        local actions = require("telescope.actions")
        local action_state = require("telescope.actions.state")

        -- Check if directory exists
        if vim.fn.isdirectory(history_dir) == 0 then
          vim.notify("Copilot history directory not found", vim.log.levels.ERROR)
          return
        end

        -- Function to open the selected file
        local function open_chat(prompt_bufnr)
          local selection = action_state.get_selected_entry()
          actions.close(prompt_bufnr)

          if selection then
            require("CopilotChat").load(selection.value:gsub("%.json$", ""), history_dir)
          else
            print("No file selected!")
          end
        end

        -- Telescope command to open a chat
        require("telescope.builtin").find_files({
          cwd = history_dir,
          prompt_title = "Select a Copilot chat to open",
          attach_mappings = function(_, map)
            -- Map <Enter> to open the selected chat
            map("i", "<Enter>", open_chat)
            map("n", "<Enter>", open_chat)
            return true
          end,
        })
      end, {})

      vim.api.nvim_create_user_command("CopilotChatDeletePrompt", function()
        local history_dir = require("CopilotChat").config.history_path
        local actions = require("telescope.actions")
        local action_state = require("telescope.actions.state")

        -- Check if the directory exists
        if vim.fn.isdirectory(history_dir) == 0 then
          vim.notify("Copilot history directory not found", vim.log.levels.ERROR)
          return
        end

        -- Function to delete selected files
        local function delete_selected_files(prompt_bufnr)
          local picker = action_state.get_current_picker(prompt_bufnr)
          local selections = picker:get_multi_selection()

          if #selections == 0 then
            print("No files selected! Use tab to select.")
            return
          end

          -- Confirm deletion and proceed
          for _, entry in ipairs(selections) do
            local file_path = entry.path or entry.value -- adjust as needed
            os.remove(file_path) -- this removes the file
            print("Deleted file: " .. file_path)
          end
        end

        -- Telescope command to select files for deletion
        require("telescope.builtin").find_files({
          cwd = history_dir,
          prompt_title = "Select files to delete (tab to select, enter to delete)",
          attach_mappings = function(_, map)
            -- Map <Tab> for multi-select and <Enter> to delete selected files
            map("i", "<Tab>", actions.toggle_selection + actions.move_selection_next)
            map("i", "<Enter>", delete_selected_files)
            map("n", "<Tab>", actions.toggle_selection + actions.move_selection_next)
            map("n", "<Enter>", delete_selected_files)
            return true
          end,
        })
      end, {})

      return {
        model = "claude-3.5-sonnet",
      }
    end,
  },
  {
    "zbirenbaum/copilot.lua",
    opts = {
      panel = {
        enabled = true,
        auto_refresh = true,
      },
    },
  },
}
