return {
	{
		"neovim/nvim-lspconfig",
		dependencies = { "saghen/blink.cmp" },

		-- example using `opts` for defining servers
		opts = {
			servers = {
				lua_ls = {},
				ts_ls = {},
				svelte = {},
				ocamllsp = {},
			},
		},
		config = function(_, opts)
			local lspconfig = require("lspconfig")
			for server, config in pairs(opts.servers) do
				-- passing config.capabilities to blink.cmp merges with the capabilities in your
				-- `opts[server].capabilities, if you've defined it
				config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
				lspconfig[server].setup(config)
			end

			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
				callback = function(event)
					local map = function(keys, func, desc, mode)
						mode = mode or "n"
						vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end
					map("gd", ":lua Snacks.picker.lsp_definitions()<CR>", "Go to definition")
					map("gD", ":lua Snacks.picker.lsp_references()<CR>", "Go to references")
					map("\"", ":lua Snacks.picker.registers()<CR>", "Registers")
					map("<leader>ld", ":lua Snacks.picker.diagnostics_buffer()<CR>", "Diagnostics Buffer")
					map("<leader>rn", ":lua vim.lsp.buf.rename<CR>", "Rename")
					map("<leader>ca", ":lua vim.lsp.buf.code_action()<CR>", "Code Action")
				end
			})
		end,

	},
}
