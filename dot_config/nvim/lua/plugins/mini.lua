return {
	{ -- Collection of various small independent plugins/modules
		"echasnovski/mini.nvim",
		config = function()
			-- Better Around/Inside textobjects
			--
			-- Examples:
			--  - va)  - [V]isually select [A]round [)]paren
			--  - yinq - [Y]ank [I]nside [N]ext [Q]uote
			--  - ci'  - [C]hange [I]nside [']quote
			require("mini.ai").setup({ n_lines = 500 })

			-- Add/delete/replace surroundings (brackets, quotes, etc.)
			--
			-- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
			-- - sd'   - [S]urround [D]elete [']quotes
			-- - sr)'  - [S]urround [R]eplace [)] [']
			require("mini.surround").setup()
			require("mini.pairs").setup()
			require("mini.starter").setup()
			require("mini.sessions").setup()
			require("mini.bufremove").setup()
			require("mini.files").setup({
				mappings = {
					go_in = "<Right>",
					go_out = "<Left>",
				},
			})
			vim.keymap.set("n", "<leader>a", function()
				local path = vim.api.nvim_buf_get_name(0)
				if path == "" or path:match("Starter") then
					path = vim.fn.getcwd()
				end
				MiniFiles.open(path, false)
				MiniFiles.reveal_cwd()
			end, { noremap = true, silent = true })

			-- ... and there is more!
			--  Check out: https://github.com/echasnovski/mini.nvim
		end,
	},
}
