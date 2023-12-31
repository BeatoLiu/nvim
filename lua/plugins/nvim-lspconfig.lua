---@diagnostic disable: param-type-mismatch, duplicate-set-field
return {
  "neovim/nvim-lspconfig",
  lazy = true,
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    { "folke/neoconf.nvim", cmd = "Neoconf", config = false, dependencies = { "nvim-lspconfig" } },
    { "folke/neodev.nvim",  opts = {} },
    "mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    version = false, -- last release is way too old
  },
  ---@class PluginLspOpts
  -- opts = function()
  --   return {
  --     diagnostics = {
  --       underline = true,
  --       update_in_insert = false,
  --       virtual_text = {
  --         spacing = 4,
  --         source = "if_many",
  --         prefix = "●",
  --         -- this will set set the prefix to a function that returns the diagnostics icon based on the severity
  --         -- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
  --         -- prefix = "icons",
  --       },
  --       severity_sort = true,
  --     },
  --     inlay_hints = {
  --       enabled = false,
  --     },
  --     -- add any global capabilities here
  --     capabilities = {},
  --     -- options for vim.lsp.buf.format
  --     -- `bufnr` and `filter` is handled by the LazyVim formatter,
  --     -- but can be also overridden when specified
  --     format = {
  --       formatting_options = nil,
  --       timeout_ms = nil,
  --     },
  --     -- LSP Server Settings
  --     -- servers = lsp_servers,
  --     setup = {
  --       ruff_lsp = function()
  --         require("lazyvim.util").lsp.on_attach(function(client, _)
  --           if client.name == "ruff_lsp" then
  --             -- Disable hover in favor of Pyright
  --             client.server_capabilities.hoverProvider = false
  --           end
  --         end)
  --       end,
  --     },
  --   }
  -- end,
  config = function()
    local lspconfig = require "lspconfig"
    local mason_lspconfig = require("mason-lspconfig")
    -- local lsp_servers = {}
    for _, server_name in ipairs(mason_lspconfig.get_installed_servers()) do
      local require_path = string.format("%s%s", "server_configs/", server_name)
      local ok, settings = pcall(require, require_path)
      if not ok then
        settings = {}
      end

      settings.on_attach = function(client, _)
        client.server_capabilities.documentFormattingProvider = false
        -- close semantic tokens
        client.server_capabilities.semanticTokensProvider = nil
      end
      settings.mason = true
      lspconfig[server_name].setup({ settings })
      -- lsp_servers[server_name] = settings
    end
    -- lsp_servers.tailwindcss = { filetypes_exclude = { "markdown" } }
    -- lsp_servers.dockerls = {}
    -- lsp_servers.docker_compose_language_service = {}
    lspconfig.rust_analyzer.setup{}
    lspconfig.lua_ls.setup({
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" },
          },
          workspace = {
            library = {
              [vim.fn.expand "$VIMRUNTIME/lua"] = true,
              [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
              [vim.fn.stdpath "data" .. "/lazy/ui/nvchad_types"] = true,
              [vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy"] = true,
            },
            maxPreload = 100000,
            preloadFileSize = 10000,
          },
        },
      },
    })
  end
}
