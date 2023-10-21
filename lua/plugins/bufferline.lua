local options = {
  diagnostics = "nivm_lsp",
  indicator = { style = "underline" },
  tab_size = 10,
  doagnostics = "nvim_lsp",
  diagnostics_update_in_inset = true,
  -- diagnostics_indicator = function(count, level, diagnostics_dict, context)
  --   local icon = level:match("error") and " " or " "
  --   return " " .. icon .. count
  -- end,
  offsets = {
    {
      filetype = "NvimTree",
      text = "File Explorer",
      highlight = "Directory",
      text_align = "left",
    },
  },
}

return options
