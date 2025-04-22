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
				tailwindcss = {},
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
					map("gd", Snacks.picker.lsp_definitions, "Go to definition")
					map("gr", Snacks.picker.lsp_references, "Go to references")
					map("<leader>ld", Snacks.picker.diagnostics_buffer, "Diagnostics Buffer")
					map("<leader>rn", vim.lsp.buf.rename, "Rename")
				end
			})
		end,
	},
}
