local opt = vim.opt
local g = vim.g

-- Example using a list of specs with the default options
g.mapleader = " " -- Make sure to set `mapleader` before lazy so your mappings are correct
-- disable netrw at the very start of your init.lua
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1
-- -- set termguicolors to enable highlight groups
opt.termguicolors = true
opt.showmode=false

opt.clipboard="unnamedplus"
opt.cursorline=true

opt.expandtab=true
opt.shiftwidth=2
opt.smartindent=true
opt.tabstop=2
opt.softtabstop=2

opt.fillchars={eob=" "}
opt.ignorecase=true
opt.smartcase=true

opt.number=true
opt.numberwidth=2

opt.termguicolors=true

vim.wo.foldmethod = 'expr'
vim.wo.foldlevel =1
vim.go.foldlevelstart=99
vim.wo.foldexpr="nvim_treesitter#foldexpr()"

-- disable some default providers
for _, provider in ipairs { "node", "perl",  "ruby" } do
  g["loaded_" .. provider .. "_provider"] = 0
end

-- add binaries installed by mason.nvim to path
local is_windows = vim.loop.os_uname().sysname == "Windows_NT"
vim.env.PATH = vim.fn.stdpath "data" .. "/mason/bin" .. (is_windows and ";" or ":") .. vim.env.PATH
