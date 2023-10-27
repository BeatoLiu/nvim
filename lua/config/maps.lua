-- n, v, i, t = mode names
local function map(mode, lhs, rhs, opts)
  -- local keys = require("lazy.core.handler").handlers.keys
  ---@cast keys LazyKeysHandler
  -- do not create the keymap if a lazy keys handler exists
  ---@diagnostic disable-next-line: missing-fields
  -- if not keys.active[keys.parse({ lhs, mode = mode }).id] then
  opts = opts or {}
  opts.silent = opts.silent ~= false
  vim.keymap.set(mode, lhs, rhs, opts)
  -- end
end


-- better up/down
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Move to window using the <ctrl> hjkl keys
map("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

-- Resize window using <ctrl> arrow keys
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- Move Lines
map("n", "<S-Down>", "<cmd>m .+1<cr>==", { desc = "Move down" })
map("n", "<S-Up>", "<cmd>m .-2<cr>==", { desc = "Move up" })
map("i", "<S-Down>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
map("i", "<S-Up>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
map("v", "<S-Down>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
map("v", "<S-Up>", ":m '<-2<cr>gv=gv", { desc = "Move up" })

-- buffers
-- if Util.has("bufferline.nvim") then
map("n", "<S-tab>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
map("n", "<tab>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
map("n", "[b", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
map("n", "]b", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
-- else
map("n", "<S-tab>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
map("n", "<S-tab>", "<cmd>bnext<cr>", { desc = "Next buffer" })
map("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
map("n", "]b", "<cmd>bnext<cr>", { desc = "Next buffer" })
-- end
map("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
map("n", "<leader>`", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })

-- Clear search with <esc>
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

-- Clear search, diff update and redraw
-- taken from runtime/lua/_editor.lua
map(
  "n",
  "<leader>ur",
  "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
  { desc = "Redraw / clear hlsearch / diff update" }
)

map({ "n", "x" }, "gw", "*N", { desc = "Search word under cursor" })

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map("n", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("n", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

-- Add undo break-points
map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", ";", ";<c-g>u")

-- save file
map({ "i", "v", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })

-- better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- lazy
map("n", "<leader>l", "<cmd>:Lazy<cr>", { desc = "Lazy" })

-- new file
map("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New File" })

map("n", "<leader>xl", "<cmd>lopen<cr>", { desc = "Location List" })
map("n", "<leader>xq", "<cmd>copen<cr>", { desc = "Quickfix List" })

-- quit
map("n", "<leader>q", "<cmd>qa<cr>", { desc = "Quit all" })

-- highlights under cursor
if vim.fn.has("nvim-0.9.0") == 1 then
  map("n", "<leader>ui", vim.show_pos, { desc = "Inspect Pos" })
end

-- floating terminal
map("t", "<esc>", "<c-\\><c-n><cmd>close<cr>", { desc = "Enter Normal Mode" })
map("t", "<esc><esc>", "<c-\\><c-n><cmd>close<cr>", { desc = "Enter Normal Mode" })

-- windows
map("n", "<leader>ww", "<C-W>p", { desc = "Other window" })
map("n", "<leader>wd", "<C-W>c", { desc = "Delete window" })
map("n", "<leader>w-", "<C-W>s", { desc = "Split window below" })
map("n", "<leader>w|", "<C-W>v", { desc = "Split window right" })
map("n", "<leader>-", "<C-W>s", { desc = "Split window below" })
map("n", "<leader>|", "<C-W>v", { desc = "Split window right" })

-- find todo
map("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find TODO" })

-- change colorscheme
map("n", "<leader>cs", "<cmd>Telescope colorscheme<CR>", { desc = "Telescope colorscheme" })
map("n", "<leader>mp", "<cmd>MarkdownPreviewToggle<CR>", { desc = "Markdown Preview" })

-- lsp
map("n", "gD", function()
  vim.lsp.buf.declaration()
end, { desc = "Lsp declaration" })

map("n", "<leader>cf", function()
  vim.lsp.buf.format({ async = true })
end, { desc = "Lsp format" })

map("n", "gd", function()
  vim.lsp.buf.definition()
end, { desc = "Lsp definition" })

map("n", "K", function()
  vim.lsp.buf.hover()
end, { desc = "LSp hover" })

map("n", "gi", function()
  vim.lsp.buf.implementation()
end, { desc = "Lsp implementation" })

map("n", "<leader>ls", function()
  vim.lsp.buf.signature_help()
end, { desc = "Lsp signature help" })

map("n", "<leader>D", function()
  vim.lsp.buf.type_definition()
end, { desc = "lsp definition type" })

map("n", "<leader>ca", function()
  vim.lsp.buf.code_action()
end, { desc = "Lsp code action" })

map("n", "gr", function()
  vim.lsp.buf.references()
end, { desc = "Lsp references" })

map("n", "<leader>d", function()
  vim.diagnostic.open_float({ border = "rounded" })
end, { desc = "Floating diagnostic" })

map("n", "]d", function()
  vim.diagnostic.goto_next({ border = "rounded" })
end, { desc = "goto next" })

map("n", "[d", function()
  vim.diagnostic.goto_prev({ border = "rounded" })
end, { desc = "goto prev" })

map("n", "<leader>q", function()
  vim.diagnostic.setloclist()
end, { desc = "Diagnostic setloclist" })

map("n", "<leader>wa", function()
  vim.lsp.buf.add_workspace_folder()
end, { desc = "add workspace folder" })

map("n", "<leader>wr", function()
  vim.lsp.buf.remove_workspace_folder()
end, { desc = "remove workspace folder" })

map("n", "<leader>wl", function()
  print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
end)

map("i", "<C-b>", "<ESC>I", { desc = "Beginning of line" })
map("i", "<C-e>", "<ESC>A", { desc = "end of line" })
map("i", "<C-h>", "<Left>", { desc = "move left" })
map("i", "<C-l>", "<Right>", { desc = "move right" })
map("i", "<C-j>", "<Down>", { desc = "move down" })
map("i", "<C-k>", "<Up>", { desc = "move up" })
map("n", "<Esc>", ":noh<CR>", { desc = "clear highlights" })
map("n", "<C-s>", ":w<CR>", { desc = "save" })

local M = {}

-- M.general = {
--   i = {
--     -- go to  beginning and end
--     ["<C-b>"] = { "<ESC>^i", "Beginning of line" },
--     ["<C-e>"] = { "<End>", "End of line" },
--
--     -- navigate within insert mode
--     ["<C-h>"] = { "<Left>", "Move left" },
--     ["<C-l>"] = { "<Right>", "Move right" },
--     ["<C-j>"] = { "<Down>", "Move down" },
--     ["<C-k>"] = { "<Up>", "Move up" },
--   },
--
--   n = {
--     ["<Esc>"] = { ":noh <CR>", "Clear highlights" },
--     -- switch between windows
--     ["<C-h>"] = { "<C-w>h", "Window left" },
--     ["<C-l>"] = { "<C-w>l", "Window right" },
--     ["<C-j>"] = { "<C-w>j", "Window down" },
--     ["<C-k>"] = { "<C-w>k", "Window up" },
--
--     -- save
--     ["<C-s>"] = { "<cmd> w <CR>", "Save file" },
--
--     -- Copy all
--     ["<C-c>"] = { "<cmd> %y+ <CR>", "Copy whole file" },
--
--     -- line numbers
--     --   ["<leader>n"] = { "<cmd> set nu! <CR>", "Toggle line number" },
--     ["<leader>rn"] = { "<cmd> set rnu! <CR>", "Toggle relative number" },
--
--     -- Allow moving the cursor through wrapped lines with j, k, <Up> and <Down>
--     -- http://www.reddit.com/r/vim/comments/2k4cbr/problem_with_gj_and_gk/
--     -- empty mode is same as using <cmd> :map
--     -- also don't use g[j|k] when in operator pending mode, so it doesn't alter d, y or c behaviour
--     ["j"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', "Move down", opts = { expr = true } },
--     ["k"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', "Move up", opts = { expr = true } },
--     ["<Up>"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', "Move up", opts = { expr = true } },
--     ["<Down>"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', "Move down", opts = { expr = true } },
--
--     -- new buffer
--     ["<leader>b"] = { "<cmd> enew <CR>", "New buffer" },
--     --   ["<leader>ch"] = { "<cmd> NvCheatsheet <CR>", "Mapping cheatsheet" },
--
--     ["<leader>fm"] = {
--       function()
--         vim.lsp.buf.format({ async = true })
--       end,
--       "LSP formatting",
--     },
--   },
--
--   t = {
--     ["<C-x>"] = { vim.api.nvim_replace_termcodes("<C-\\><C-N>", true, true, true), "Escape terminal mode" },
--   },
--
--   v = {
--     ["<Up>"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', "Move up", opts = { expr = true } },
--     ["<Down>"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', "Move down", opts = { expr = true } },
--   },
--
--   x = {
--     ["j"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', "Move down", opts = { expr = true } },
--     ["k"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', "Move up", opts = { expr = true } },
--     -- Don't copy the replaced text after pasting in visual mode
--     -- https://vim.fandom.com/wiki/Replace_a_word_with_yanked_text#Alternative_mapping_for_paste
--     ["p"] = { 'p:let @+=@0<CR>:let @"=@0<CR>', "Dont copy replaced text", opts = { silent = true } },
--   },
-- }
--
-- M.blankline = {
--   plugin = true,
--
--   n = {
--     ["<leader>cc"] = {
--       function()
--         local ok, start = require("indent_blankline.utils").get_current_context(
--           vim.g.indent_blankline_context_patterns,
--           vim.g.indent_blankline_use_treesitter_scope
--         )
--
--         if ok then
--           vim.api.nvim_win_set_cursor(vim.api.nvim_get_current_win(), { start, 0 })
--           vim.cmd([[normal! _]])
--         end
--       end,
--
--       "Jump to current context",
--     },
--   },
-- }

return M
