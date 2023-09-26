local null_ls = require "null-ls"
-- local cspell = require "cspell"

local b = null_ls.builtins

-- local cspell_config = vim.fn.expand "E:/cspell.json"
-- local shared_config = {
--   find_json = function()
--     return cspell_config
--   end,
-- }

local sources = {

  -- web dev stuff
  -- b.diagnostics.deno_lint,
  -- b.diagnostics.stylelint.with { filetypes = { "html", "css", "less", "scss", "sass", "vue" } },
  -- b.formatting.deno_fmt, -- choosed deno for ts/js files cuz its very fast!
  -- b.formatting.prettier,
  -- b.code_actions.eslint_d,
  -- b.formatting.prettier.with { filetypes = { "html", "markdown", "css", "vue","js","tsx","ts" } }, -- so prettier works only on these filetypes

  -- Lua
  b.formatting.stylua,

  -- cpp
  b.formatting.clang_format, --.with { filetypes = { "c", "cpp" } },

  --  cspell太卡
  -- cspell.diagnostics.with {
  --   config = shared_config,
  -- },
  -- cspell.code_actions.with {
  --   config = shared_config,
  -- },
}

null_ls.setup {
  debug = true,
  sources = sources,
}
