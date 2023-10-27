local colors = {
  bg = "#202328",
  fg = "#bbc2cf",
  yellow = "#ECBE7B",
  cyan = "#008080",
  darkblue = "#081633",
  green = "#98be65",
  orange = "#FF8800",
  violet = "#a9a1e1",
  magenta = "#c678dd",
  blue = "#51afef",
  red = "#ec5f67",
  vimGreen = "#007f00",
}

return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  opts = function()
    -- local icons = require("lazyvim.config").icons

    local function diff_source()
      ---@diagnostic disable-next-line: undefined-field
      local gitsigns = vim.b.gitsigns_status_dict
      if gitsigns then
        return {
          added = gitsigns.added,
          modified = gitsigns.changed,
          removed = gitsigns.removed,
        }
      end
    end

    return {
      options = {
        theme = "auto",
        -- theme = {
        --   -- We are going to use lualine_c an lualine_x as left and
        --   -- right section. Both are highlighted by c theme .  So we
        --   -- are just setting default looks o statusline
        --   normal = { c = { fg = colors.fg, bg = colors.bg } },
        --   inactive = { c = { fg = colors.fg, bg = colors.bg } },
        -- },
        icons_enabled = true,
        -- component_separators = { left = "", right = "" },
        -- section_separators = { left = "", right = "" },
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        globalstatus = true,
        disabled_filetypes = { statusline = { "dashboard", "lazy", "alpha" } },
      },
      sections = {
        lualine_a = {
          {
            "mode",
            fmt = function(str)
              return " " .. str --string.upper(vim.fn.mode())
            end,
            -- color = { fg = mode_color[vim.fn.mode()] },
            padding = { right = 1 },
          },
        },
        lualine_b = {
          {
            "branch",
            icon = "",
            color = { fg = colors.violet, gui = "bold" },
          },
          {
            "diff",
            colored = true, -- Displays a colored diff status if set to true
            symbols = {
              added = "+",
              modified = "~",
              removed = "-",
            },
            diff_color = {
              added = { fg = colors.green },
              modified = { fg = colors.orange },
              removed = { fg = colors.red },
            },
            source = diff_source,
          },
        },
        lualine_c = {
          {
            function()
              return "%="
            end,
          },
          { "filetype",  icon_only = true, separator = "", padding = { left = 1, right = 0 } },
          {
            "filename",
            path = 1,
            symbols = { modified = "  ", readonly = "", unnamed = "" },
            color = { fg = colors.magenta },
          },
          {
            "diagnostics",
            symbols = {
              error = "E",
              warn = "W",
              info = "I",
              hint = "H",
            },
          },
        },
        lualine_x = {
          { "searchcount" },
        },
        lualine_y = {
          { "encoding" },
          { "fileformat" },
          {
            -- filesize component
            "filesize",
            -- cond = conditions.buffer_not_empty,
          },
          { "progress", separator = "  ",                 padding = { left = 1, right = 0 } },
          { "location", padding = { left = 0, right = 1 } },
        },
        lualine_z = {
          {
            "datetime",
            style = " " .. "%H:%M", -- '%A, %B %d | %H:%M' '%Y-%m-%d'
          },
        },
      },
      extensions = { "nvim-tree", "aerial", "toggleterm", "nvim-dap-ui" },
    }
  end,
}
