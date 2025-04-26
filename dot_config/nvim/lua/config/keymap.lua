-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

vim.keymap.set('n', '<M-n>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<M-o>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<M-e>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<M-i>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })

vim.keymap.set("n", "<Tab>", ":bn<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<M-Tab>", ":bp<CR>", { noremap = true, silent = true })

vim.keymap.set("t", "<C-q>", "<C-\\><C-n><C-w>p", { desc = "Exit terminal and go to previous window" })

if vim.g.neovide then
	-- vim.keymap.set('v', '<D-c>', '"+y') -- Copy
	vim.keymap.set('n', '<C-v>', '"+P')        -- Paste normal mode
	vim.keymap.set('v', '<C-v>', '"+P')        -- Paste visual mode
	vim.keymap.set('c', '<C-v>', '<C-R>+')     -- Paste command mode
	vim.keymap.set('i', '<C-v>', '<ESC>l"+Pli') -- Paste insert mode
end

-- Allow clipboard copy paste in neovim
vim.api.nvim_set_keymap('', '<C-v>', '+p<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('!', '<C-v>', '<C-R>+', { noremap = true, silent = true })
vim.api.nvim_set_keymap('t', '<C-v>', '<C-R>+', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<C-v>', '<C-R>+', { noremap = true, silent = true })
