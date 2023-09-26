-- local on_attach = require("plugins.configs.lspconfig").on_attach
-- local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require("lspconfig")

-- if you just want default config for the servers then put them in a table
local servers = { "lua_ls", "clangd", "rust_analyzer" }

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup({
    -- on_attach = on_attach,
    -- capabilities = capabilities,
  })
end

-- lspconfig.pyright.setup { blabla}

lspconfig.lua_ls.setup({
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = {
          [vim.fn.expand("$VIMRUNTIME/lua")] = true,
        },
      },
    },
  },
})
