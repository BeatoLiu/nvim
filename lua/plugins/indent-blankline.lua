return {
  "lukas-reineke/indent-blankline.nvim",
  event = {"BufRead", "BufWinEnter", "BufNewFile"},
  -- version = "2.20.7",
  -- lazy = true,
  -- main = "ibl",
  -- init = function()
  -- require("utils").lazy_load("indent-blankline.nvim")
  -- end,
  -- opts = function()
  -- 	return {
  -- 		indentLine_enabled = 1,
  -- 		filetype_exclude = {
  -- 			"help",
  -- 			"terminal",
  -- 			"lazy",
  -- 			"lspinfo",
  -- 			"TelescopePrompt",
  -- 			"TelescopeResults",
  -- 			"mason",
  -- 			"nvdash",
  -- 			"nvcheatsheet",
  -- 			"",
  -- 		},
  -- 		buftype_exclude = { "terminal" },
  -- 		show_trailing_blankline_indent = false,
  -- 		show_first_indent_level = false,
  -- 		show_current_context = true,
  -- 		show_current_context_start = true,
  -- 	}
  -- end,
  config = function()
    -- require("utils").load_mappings("blankline")
    require("indent_blankline").setup({
      indent_blankline_char = "| ",
      indentLine_enabled = 1,
      filetype_exclude = {
        "help",
        "terminal",
        "lazy",
        "lspinfo",
        "TelescopePrompt",
        "TelescopeResults",
        "mason",
        "nvdash",
        "nvcheatsheet",
        "",
      },
      buftype_exclude = { "terminal" },
      show_trailing_blankline_indent = false,
      show_first_indent_level = false,
      show_current_context = true,
      show_current_context_start = true,
    })
  end
}
