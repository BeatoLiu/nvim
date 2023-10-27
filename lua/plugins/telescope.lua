return {
  "nvim-telescope/telescope.nvim",
  cmd = "Telescope",
  version = false,
  lazy = true,
  config = function()
    require("telescope").setup({
      defaults = {
        -- prompt_prefix = "  ",
        prompt_prefix = "   ",
        selection_caret = "  ",
        initial_mode = "insert",
        selection_strategy = "reset",
        -- sorting_strategy = "descending",
        sorting_strategy = "ascending",
        layout_strategy = "horizontal", -- bottom_pane
        color_devicons = true,
        entry_prefix = " ",
        multi_icon = "  ",
        file_ignore_patterns = { "node_modules", ".git", ".svn", ".vscode" },
        -- config
        layout_config = {
          bottom_pane = {
            height = 15,
            preview_cutoff = 100,
            prompt_position = "top",
          },
        },
      },
      extensions = {},
    })
  end,
  opts = function(_, opts)
    local function flash(prompt_bufnr)
      require("flash").jump({
        pattern = "^",
        highlight = { label = { after = { 0, 0 } } },
        search = {
          mode = "search",
          exclude = {
            function(win)
              return vim.bo[vim.api.nvim_win_get_buf(win)].filetype ~= "TelescopeResults"
            end,
          },
        },
        action = function(match)
          local picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
          picker:set_selection(match.pos[1] - 1)
        end,
      })
    end
    opts.defaults = vim.tbl_deep_extend("force", opts.defaults or {}, {
      mappings = {
        n = { s = flash },
        i = { ["<c-s>"] = flash },
      },
    })
  end,
  keys = {
    { "<leader>ff", ":Telescope find_files<CR>", desc = "Find files in the current workspace" },
    { "<leader>fw", ":Telescope live_grep<CR>", desc = "Find string in the current workspace" },
    { "<leader>fo", ":Telescope oldfiles<CR>", desc = "Find telescope history" },
    { "<leader>fr", ":Telescope resume<CR>", desc = "Find last lookup" },
    { "<leader>fh", ":Telescope help_tags<CR>", desc = "Find all help document tags" },
    { "<leader>fm", ":Telescope marks<CR>", desc = "Find marks in the current workspace" },
    { "<leader>fi", ":Telescope highlights<CR>", desc = "Find all neovim highlights" },
    { "<leader>fb", ":Telescope buffers<CR>", desc = "Find all buffers" },
    { "<leader>f/", ":Telescope search_history<CR>", desc = "Find all search history" },
    { "<leader>f:", ":Telescope command_history<CR>", desc = "Find all command history" },
    { "<leader>fe", ":Telescope diagnostics<CR>", desc = "Find all search history" },
    { "<leader>f:", ":Telescope command_history<CR>", desc = "Find all command history" },
    { "<leader>fz", ":Telescope current_buffer_fuzzy_find<CR>", desc = "Find in current buffer" },
    { "<leader>fe", ":Telescope diagnostics<CR>", desc = "Find diagnostics in the current workspace" },
    -- git
    { "<leader>gc", ":Telescope git_commits<CR>", desc = "git commits" },
    { "<leader>gs", ":Telescope git_status<CR>", desc = "git status" },
    -- pick a hidden term
    -- { "<leader>tf", ":Telescope terms<CR>", desc = "pick hidden term" },
    -- theme switcher
    { "<leader>ft", ":Telescope themes<CR>", desc = "swith themes" },
  },
}
