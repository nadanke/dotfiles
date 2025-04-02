require("config/vars")
require("config/neovide")
require("config/lazy")
require("config/keymap")
require("config/autocommands")

vim.cmd.colorscheme("catppuccin-mocha")

local function send_to_kitty()
	-- re-select last visual selection, yank to unnamed register
	-- doing it this way handles char/line/block modes reasonably well
	vim.cmd('noautocmd normal! ""y')
	local selected_text = vim.fn.getreg('"')

	if selected_text == '' then
		vim.notify("visual selection empty?", vim.log.levels.WARN)
		return
	end

	-- append your ocaml terminators
	local text_to_send = selected_text .. ';;' .. '\n'

	-- use jobstart for async execution. no blocking nvim pls.
	vim.fn.jobstart({
		'kitten', '@', 'send-text',
		'--to', 'unix:/tmp/mykitty', -- hardcoded as u wanted
		'--', text_to_send
	}, {
		on_exit = function(_, code, _)
			if code ~= 0 then
				vim.notify("failed to yeet text to kitty (code: " .. code .. ")", vim.log.levels.ERROR)
				-- could print stderr here if u capture it, but meh
			end
		end,
		-- important: detach the process so nvim doesn't wait/care if it lingers
		detached = true,
	})
end

-- map in visual mode. <leader>rr is maybe 'repl run'? idk.
-- the function() wrapper is needed to call our lua function correctly from mapping
vim.keymap.set('v', '<leader>rr', send_to_kitty, { noremap = true, silent = true, desc = 'Send selection to kitty repl' })
