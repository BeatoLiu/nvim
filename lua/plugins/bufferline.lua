local api = vim.api

local function bufilter()
	local bufs = vim.t.bufs or nil

	if not bufs then
		return {}
	end

	for i, nr in ipairs(bufs) do
		if not vim.api.nvim_buf_is_valid(nr) then
			table.remove(bufs, i)
		end
	end

	vim.t.bufs = bufs
	return bufs
end

local function getBufIndex(bufnr)
	for i, value in ipairs(bufilter()) do
		if value == bufnr then
			return i
		end
	end
end
local close_buffer = function(bufnr)
	if vim.bo.buftype == "terminal" then
		vim.cmd(vim.bo.buflisted and "set nobl | enew" or "hide")
	else
		if not vim.t.bufs then
			vim.cmd("bd")
			return
		end

		bufnr = bufnr or api.nvim_get_current_buf()
		local curBufIndex = getBufIndex(bufnr)
		local bufhidden = vim.bo.bufhidden

		-- force close floating wins
		if bufhidden == "wipe" then
			vim.cmd("bw")
			return

		-- handle listed bufs
		elseif curBufIndex and #vim.t.bufs > 1 then
			local newBufIndex = curBufIndex == #vim.t.bufs and -1 or 1
			vim.cmd("b" .. vim.t.bufs[curBufIndex + newBufIndex])

		-- handle unlisted
		elseif not vim.bo.buflisted then
			local tmpbufnr = vim.t.bufs[1]

			if vim.g.nv_previous_buf and vim.api.nvim_buf_is_valid(vim.g.nv_previous_buf) then
				tmpbufnr = vim.g.nv_previous_buf
			end

			vim.cmd("b" .. tmpbufnr .. " | bw" .. bufnr)
			return
		else
			vim.cmd("enew")
		end

		if not (bufhidden == "delete") then
			vim.cmd("confirm bd" .. bufnr)
		end
	end

	vim.cmd("redrawtabline")
end
return {
  "akinsho/bufferline.nvim",
  event = "VeryLazy",
  opts = {
    options = {
      themable = true,
      show_close_icon = true,
      -- ordinal
      numbers = "ordinal",
      -- buffer_close_icon = "",
      -- modified_icon = "●",
      -- close_icon = "",
      left_trunc_marker = "",
      right_trunc_marker = "",
      separator_style = "thin",
      indicator = { icon = "▎", style = "icon" },
      diagnostics = "nvim_lsp",
      always_show_bufferline = true,
      offsets = {
        {
          filetype = "neo-tree",
          text = "Neo-tree",
          highlight = "Directory",
          text_align = "center",
        },
        {
          filetype = "NvimTree",
          text = "Explorer",
          highlight = "Directory",
          text_align = "center",
          padding = 1,
        },
        {
          filetype = "aerial",
          text = "Outline Explorer",
          highlight = "Directory",
          text_align = "center",
        },
        {
          filetype = "undotree",
          text = "Undo Explorer",
          highlight = "Directory",
          text_align = "center",
        },
        {
          filetype = "dbui",
          text = "Database Explorer",
          highlight = "Directory",
          text_align = "center",
        },
        {
          filetype = "spectre_panel",
          text = "Project Blurry Search",
          highlight = "Directory",
          text_align = "center",
        },
        {
          filetype = "toggleterm",
          text = "Integrated Terminal",
          highlight = "Directory",
          text_align = "center",
        },
      },
    },
  },
  keys = {
    { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>",            desc = "Toggle pin" },
    { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete non-pinned buffers" },
    -- {
    --   "<c-q>",
    --   "<cmd>BufferDelete<CR>",
    --   desc = "Close current buffer",
    -- },
    {
      "<leader>x",
      function ()
        close_buffer()
      end,
      desc = "Close current buffer",
    },
    {

      "<leader>bq",
      "<cmd>BufferLinePickClose<cr>",
      desc = "Close target buffer",
    },
    {
      "<leader>bn",
      "<cmd>enew<cr>",
      desc = "Create new buffer",
    },
    {
      "<leader>bh",
      "<cmd>BufferLineCloseLeft<cr>",
      desc = "Close all left buffers",
    },
    {
      "<leader>bl",
      "<cmd>BufferLineCloseRight<cr>",
      desc = "Close all right buffers",
    },
    {
      "<leader>bo",
      function()
        vim.cmd("BufferLineCloseLeft")
        vim.cmd("BufferLineCloseRight")
      end,
      desc = "Close all other buffers",
    },
    {
      "<leader>ba",
      function()
        vim.cmd("BufferLineCloseLeft")
        vim.cmd("BufferLineCloseRight")
        -- vim.cmd("BufferDelete")
        close_buffer()
      end,
      desc = "Close all buffers",
    },
    {
      "<leader>bt",
      "<cmd>BufferLinePick<cr>",
      desc = "Go to buffer *",
    },
    {
      "<leader>bs",
      "<cmd>BufferLineSortByExtension<cr>",
      desc = "Buffers sort (by extension)",
    },
    {
      "<A-1>",
      "<cmd>BufferLineGoToBuffer 1<cr>",
      desc = "Go to buffer 1",
    },
    {
      "<A-2>",
      "<cmd>BufferLineGoToBuffer 2<cr>",
      desc = "Go to buffer 2",
    },
    {
      "<A-3>",
      "<cmd>BufferLineGoToBuffer 3<cr>",
      desc = "Go to buffer 3",
    },
    {
      "<A-4>",
      "<cmd>BufferLineGoToBuffer 4<cr>",
      desc = "Go to buffer 4",
    },
    {
      "<A-5>",
      "<cmd>BufferLineGoToBuffer 5<cr>",
      desc = "Go to buffer 5",
    },
    {
      "<A-6>",
      "<cmd>BufferLineGoToBuffer 6<cr>",
      desc = "Go to buffer 6",
    },
    {
      "<A-7>",
      "<cmd>BufferLineGoToBuffer 7<cr>",
      desc = "Go to buffer 7",
    },
    {
      "<A-8>",
      "<cmd>BufferLineGoToBuffer 8<cr>",
      desc = "Go to buffer 8",
    },
    {
      "<A-9>",
      "<cmd>BufferLineGoToBuffer 9<cr>",
      desc = "Go to buffer 9",
    },
    {
      "<A-0>",
      "<cmd>BufferLineGoToBuffer -1<cr>",
      desc = "Go to buffer last",
    },
    -- {
    --   "<tab>",
    --   "<cmd>BufferLineCycleNext<cr>",
    --   desc = "Go to buffer next",
    -- },
    -- {
    --   "<S-tab>",
    --   "<cmd>BufferLineCyclePrev<cr>",
    --   desc = "Go to buffer pre",
    -- },
    {
      "<A-h>",
      "<cmd>BufferLineMovePrev<cr>",
      desc = "Move current buffer to left",
    },
    {
      "<A-l>",
      "<cmd>BufferLineMoveNext<cr>",
      desc = "Move current buffer to right",
    },
  },
}
-- return options
