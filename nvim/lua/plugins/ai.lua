vim.g.copilot_toggle_enabled = true

return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    -- stylua: ignore
    keys = {
      {"<leader>aa", false},
      {"<leader>aE", false},
      {"<leader>aD", false},
      { "<leader>ac", "<cmd>CopilotChatToggle<cr>", desc = "Toggle (CopilotChat)" },
      { "<leader>aC",
        function()
          vim.g.copilot_toggle_enabled = not vim.g.copilot_toggle_enabled
          if vim.g.copilot_toggle_enabled then
            vim.cmd("Copilot enable")
            vim.notify("Copilot enabled", vim.log.levels.INFO)
          else
            vim.cmd("Copilot disable")
            vim.notify("Copilot disabled", vim.log.levels.INFO)
          end
        end,
        desc = "Toggle Copilot"
      },
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
            vim.notify("No file selected!")
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
            vim.notify("No files selected! Use tab to select.")
            return
          end

          -- Confirm deletion and proceed
          for _, entry in ipairs(selections) do
            local file_path = entry.path or entry.value -- adjust as needed
            os.remove(file_path) -- this removes the file
            vim.notify("Deleted file: " .. file_path)
          end

          -- Close telescope after deletion
          actions.close(prompt_bufnr)
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
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = false,
    version = false, -- set this if you want to always pull the latest change
    opts = {
      provider = "copilot",
      auto_suggestions_provider = "copilot",
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = "make",
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      "zbirenbaum/copilot.lua", -- for providers='copilot'
      {
        -- support for image pasting
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
          },
        },
      },
      {
        -- Make sure to set this up properly if you have lazy=true
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
  },
}
