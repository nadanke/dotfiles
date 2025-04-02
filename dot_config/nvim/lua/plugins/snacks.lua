return {
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		---@type snacks.Config
		opts = {
			picker = {},
			bigfile = {},
			-- explorer = {},
			indent = {
				priority = 1,
				enabled = true,
				animate = {
					enabled = false,
				},
			},
			terminal = {},
			words = {},
			notifier = {},
			quickfile = {},
			scroll = {
				enabled = vim.g.neovide and false or true,
				animate = {
					duration = { step = 10, total = 100 },
					easing = "linear",
				},
				animate_repeat = {
					delay = 100,
					duration = { step = 5, total = 50 }
				},
			},
		},
		keys = {
			{ "<leader>\\",      function() Snacks.terminal() end,               desc = "Open Terminal" },
			{ "<leader><space>", function() Snacks.picker.smart() end,           desc = "Smart Find Files" },
			{ "<leader>,",       function() Snacks.picker.buffers() end,         desc = "Buffers" },
			{ "<leader>/",       function() Snacks.picker.grep() end,            desc = "Grep" },
			{ "<leader>:",       function() Snacks.picker.command_history() end, desc = "Command History" },
			{ "<leader>n",       function() Snacks.picker.notifications() end,   desc = "Notification History" },
			{ "<leader>p",       function() Snacks.picker.projects() end,        desc = "Projects" },
			{ "<leader>s/",      function() Snacks.picker.search_history() end,  desc = "Search History" },
		}
	},
}
