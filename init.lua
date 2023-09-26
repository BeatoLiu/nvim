require("opts")
require("utils").load_mappings()

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- which-key set

-- local wk = require("which-key")
-- As an example, we will create the following mappings:
-- --  * <leader>ff find files
-- --  * <leader>fr show recent files
-- --  * <leader>fb Foobar
-- -- we'll document:
-- --  * <leader>fn new file
-- --  * <leader>fe edit file
-- -- and hide <leader>1
--

-- wk.register({
-- ["<leader>f"] = {
-- name = "+file",
-- f = { "<cmd>Telescope find_files<cr>", "Find File" },
-- r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
-- n = { "<cmd>enew<cr>", "New File" },
-- },
-- })

require("plugins")
