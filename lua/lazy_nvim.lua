-- All plugins have lazy=true by default,to load a plugin on startup just lazy=false
-- List of all default plugins & their definitions
local default_plugins = {
	 -- { "LazyVim/LazyVim", import = "lazyvim.plugins" },

	"nvim-lua/plenary.nvim",

	{
		"nvim-tree/nvim-web-devicons",
		config = function(_, opts)
			require("nvim-web-devicons").setup(opts)
		end,
	},
}

--local config = require("utils").load_config()

-- if #config.plugins > 0 then
-- table.insert(default_plugins, { import = config.plugins })
-- end

table.insert(default_plugins, { import = "plugins" })

-- require("lazy").setup(default_plugins)

require("lazy").setup({
	spec = default_plugins,
	defaults = {
		lazy = true,
		version = false,
	},
	install = { colorscheme = { "tokyonight" } },
	ui = {
		border = "rounded",
	},
	performance = {
		rtp = {
			default_plugins = {
				"2html_plugin",
				"tohtml",
				"getscript",
				"getscriptPlugin",
				"gzip",
				"logipat",
				"netrw",
				"netrwPlugin",
				"netrwSettings",
				"netrwFileHandlers",
				"matchit",
				"tar",
				"tarPlugin",
				"rrhelper",
				"spellfile_plugin",
				"vimball",
				"vimballPlugin",
				"zip",
				"zipPlugin",
				"tutor",
				"rplugin",
				"syntax",
				"synmenu",
				"optwin",
				"compiler",
				"bugreport",
				"ftplugin",
			},
		},
	},
})
