return {
	-- "nvimtools/none-ls.nvim",
	"jose-elias-alvarez/null-ls.nvim",
	-- enabled = false,
	event = { "BufReadPre", "BufNewFile" },
	dependencies = { "mason.nvim" },
	config = function()
		local nls = require("null-ls")
		table.insert(nls.builtins.formatting.shfmt.filetypes, "zsh")
		local sources = {
			-- nls.builtins.formatting.prettierd,
			nls.builtins.diagnostics.flake8.with({ extra_args = { "--max-line-length", "120" } }),
			-- nls.builtins.formatting.gofmt,
			-- nls.builtins.formatting.shfmt,
			nls.builtins.formatting.clang_format.with({ filetypes = { "c", "cpp" } }),
			nls.builtins.formatting.rustfmt,

			nls.builtins.formatting.prettier,
			-- nls.builtins.formatting.isort.with({
			--   extra_args = {
			--     "--line-length=120",
			--   },
			-- }),
			-- nls.builtins.formatting.black.with({
			--   extra_args = {
			--     "--line-length=120",
			--   },
			-- }),
			nls.builtins.formatting.sql_formatter,
			nls.builtins.formatting.stylua.with({
				extra_args = {
					"--indent-type=Spaces",
					"--indent-width=2",
				},
			}),
			-- nls.builtins.code_actions.gomodifytags,
			-- nls.builtins.code_actions.impl,
			-- nls.builtins.formatting.gofumpt,
			-- nls.builtins.formatting.goimports_reviser,
			-- nls.builtins.diagnostics.hadolint, -- for dockerfile
		}
		nls.setup({ sources = sources })
	end,
}
