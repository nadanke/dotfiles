return {
	{ -- Highlight, edit, and navigate code
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		main = "nvim-treesitter.configs", -- Sets main module to use for opts
		-- [[ Configure Treesitter ]] See `:help nvim-treesitter`
		opts = {
			ensure_installed = {
				"bash",
				"c",
				"diff",
				"html",
				"lua",
				"luadoc",
				"markdown",
				"markdown_inline",
				"query",
				"vim",
				"vimdoc",
				"ocaml",
			},
			-- Autoinstall languages that are not installed
			auto_install = true,
			highlight = {
				enable = true,
				-- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
				--  If you are experiencing weird indenting issues, add the language to
				--  the list of additional_vim_regex_highlighting and disabled languages for indent.
				additional_vim_regex_highlighting = { "ruby" },
			},
			indent = { enable = true, disable = { "ruby", "ocaml" } },
		},
		-- There are additional nvim-treesitter modules that you can use to interact
		-- with nvim-treesitter. You should go explore a few and see what interests you:
		--
		--    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
		--    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
		--    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
	},
	"nvim-treesitter/nvim-treesitter-context",
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		event = "VeryLazy",
		enabled = true,
		config = function()
			-- When in diff mode, we want to use the default
			-- vim text objects c & C instead of the treesitter ones.
			local move = require("nvim-treesitter.textobjects.move") ---@type table<string,fun(...)>
			local configs = require("nvim-treesitter.configs")
			for name, fn in pairs(move) do
				if name:find("goto") == 1 then
					move[name] = function(q, ...)
						if vim.wo.diff then
							local config = configs.get_module("textobjects.move")[name] ---@type table<string,string>
							for key, query in pairs(config or {}) do
								if q == query and key:find("[%]%[][cC]") then
									vim.cmd("normal! " .. key)
									return
								end
							end
						end
						return fn(q, ...)
					end
				end
			end
		end,
	}
}
