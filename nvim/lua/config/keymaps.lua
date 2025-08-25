local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

vim.g.mapleader = ' '

-- NORMAL MODE
keymap("n", "<C-d>", "<C-d>zz", opts)
keymap("n", "<C-u>", "<C-u>zz", opts)

-- split window
keymap("n", "<leader>/", "<C-w>v", opts)
keymap("n", "<leader>-", "<C-w>s", opts)

-- splits navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- buffers navigation
keymap("n", "<C-n>", "<cmd>bnext<cr>", opts)
keymap("n", "<C-p>", "<cmd>bprevious<cr>", opts)

-- lsp go-to
keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
keymap("n", "gs", "<cmd>ClangdSwitchSourceHeader<cr>", opts)

-- lsp actions
keymap("n", "<leader>d", "<cmd>lua vim.diagnostic.open_float()<cr>", opts)
keymap("n", "<leader>h", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
keymap("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
keymap("n", "<leader>=", "<cmd>lua vim.lsp.buf.format()<cr>", opts)

-- INSERT MODE
keymap("i", ",", ",<C-g>u", opts)
keymap("i", ".", ".<C-g>u", opts)
keymap("i", ";", ";<C-g>u", opts)
keymap("i", ":", ":<C-g>u", opts)
keymap("i", "!", "!<C-g>u", opts)
keymap("i", "?", "?<C-g>u", opts)
keymap("i", "(", "(<C-g>u", opts)
keymap("i", "[", "[<C-g>u", opts)
keymap("i", "{", "{<C-g>u", opts)
keymap("i", "<tab>", "<tab><C-g>u", opts)
keymap("i", "<space>", "<C-g>u ", opts)
keymap("i", "<enter>", "<C-g>u<enter>", opts)
keymap("i", "<C-backspace>", "<C-w>", opts)

-- keymap("i", ";", 	"<end>;", opts)
-- keymap("i", "<C-;>", 	";", opts)
