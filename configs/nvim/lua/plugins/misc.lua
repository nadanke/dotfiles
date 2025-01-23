return {
	"tpope/vim-sleuth",
	{ -- Autoformat
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				"<leader>f",
				function()
					require("conform").format({ async = true, lsp_format = "fallback" })
				end,
				mode = "",
				desc = "[F]ormat buffer",
			},
		},
		opts = {
			notify_on_error = false,
			format_on_save = function(bufnr)
				-- Disable "format_on_save lsp_fallback" for languages that don't
				-- have a well standardized coding style. You can add additional
				-- languages here or re-enable it for the disabled ones.
				local disable_filetypes = { c = true, cpp = true }
				local lsp_format_opt
				if disable_filetypes[vim.bo[bufnr].filetype] then
					lsp_format_opt = "never"
				else
					lsp_format_opt = "fallback"
				end
				return {
					timeout_ms = 500,
					lsp_format = lsp_format_opt,
				}
			end,
			formatters_by_ft = {
				lua = { "stylua" },
				-- Conform can also run multiple formatters sequentially
				-- python = { "isort", "black" },
				--
				-- You can use 'stop_after_first' to run the first available formatter from the list
				-- javascript = { "prettierd", "prettier", stop_after_first = true },
			},
		},
	},
	{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },
	{
		"smoka7/hop.nvim",
		version = "*",
		config = function()
			local hop = require("hop")
			hop.setup({
				keys = "netsiroahuywf",
			})
			vim.keymap.set("", "s", ":HopChar1<CR>", { remap = true })
			vim.keymap.set("v", "s", "<cmd>HopChar1<CR>", { remap = true })
			vim.keymap.set("", "S", ":HopWord<CR>", { remap = true })
			vim.keymap.set("v", "S", "<cmd>HopWord<CR>", { remap = true })
		end,
	},
	{
		"bwpge/homekey.nvim",
		opts = {},
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
	},
	{
		"norcalli/nvim-colorizer.lua",
		opts = {},
	},
	"RRethy/vim-illuminate",
	{ "akinsho/bufferline.nvim", version = "*", dependencies = "nvim-tree/nvim-web-devicons", opts = {} },
}
