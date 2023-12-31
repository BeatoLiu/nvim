local opt = vim.opt
local g = vim.g

-- Example using a list of specs with the default options
g.mapleader = " " -- Make sure to set `mapleader` before lazy so your mappings are correct
-- disable netrw at the very start of your init.lua
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1
-- -- set termguicolors to enable highlight groups
opt.termguicolors = true
opt.showmode = false

opt.clipboard = "unnamedplus"
opt.cursorline = true

opt.expandtab = true
opt.shiftwidth = 2
opt.smartindent = true
opt.tabstop = 2
opt.softtabstop = 2

opt.fillchars = { eob = " " }
opt.ignorecase = true
opt.smartcase = true

opt.number = true
opt.numberwidth = 2

vim.wo.foldmethod = "expr"
vim.wo.foldlevel = 1
vim.go.foldlevelstart = 99
vim.wo.foldexpr = "nvim_treesitter#foldexpr()"

-- disable some default providers
for _, provider in ipairs({ "node", "perl", "ruby" }) do
  g["loaded_" .. provider .. "_provider"] = 0
end

-- 切换buffer
-- for i = 1, 9, 1 do
--   vim.keymap.set("n", string.format("<leader>%s", i), string.format("<Cmd>BufferLineGoToBuffer %s<CR>", i))
-- end
-- add binaries installed by mason.nvim to path
local is_windows = vim.loop.os_uname().sysname == "Windows_NT"
vim.env.PATH = vim.fn.stdpath("data") .. "/mason/bin" .. (is_windows and ";" or ":") .. vim.env.PATH
vim.env.PATH = vim.fn.stdpath("data") .. "/mason/bin" .. (is_windows and ";" or ":") .. vim.env.PATH

-- 为lsp.buf.hover()增加边框
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = "single",
})

-- custmo config
local options = {}
options.transparent = false
options.float_border = true
options.show_winbar = true

-- auto command manager
options.auto_save = false
options.auto_reload = false
options.auto_switch_input = true
options.auto_restore_cursor_position = true
options.auto_remove_new_lines_comment = true
return options
