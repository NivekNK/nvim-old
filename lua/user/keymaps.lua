-- Nvim Modes
--    Normal Mode: "n"
--    Insert Mode: "i"
--    Visual Mode: "v"
--    Visual Block Mode: "x"
--    Terminal Mode: "t"
--    Command Mode: "c"

local noremap = { noremap = true, silent = true }

local terminal = { silent = true }

-- Keymap function
local keymap = vim.api.nvim_set_keymap

-- Leader Key
keymap("", "<Space>", "<Nop>", noremap)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-------------------- Normal ----------------------

-- Change between panels in window
keymap("n", "<leader>h", "<C-w>h", noremap)
keymap("n", "<leader>j", "<C-w>j", noremap)
keymap("n", "<leader>k", "<C-w>k", noremap)
keymap("n", "<leader>l", "<C-w>l", noremap)

-- Open Files navigation panel in the left side
keymap("n", "<leader>e", ":Lex 30<CR>", noremap)

-- Resize selected panel
keymap("n", "<C-Up>", ":resize +2<CR>", noremap)
keymap("n", "<C-Down>", ":resize -2<CR>", noremap)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", noremap)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", noremap)

-- Swap buffers / Change window
keymap("n", "<S-l>", ":bnext<CR>", noremap)
keymap("n", "<S-h>", ":bprevious<CR>", noremap)

-- Split panel
keymap("n", "<C-L>", ":vsplit<CR>", noremap)
keymap("n", "<C-J>", ":split<CR>", noremap)

-- Move text up and down
keymap("n", "<A-j>", "<ESC>:m .+1<CR>", noremap)
keymap("n", "<A-k>", "<ESC>:m .-2<CR>", noremap)
keymap("n", "<CA-j>", "<ESC>:m .+1<CR><a>", noremap)
keymap("n", "<CA-k>", "<ESC>:m .-2<CR><a>", noremap)

-- Telescope: Find files and text
--keymap("n", "<leader>f", "<cmd>lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({ previewer = false }))<cr>", noremap)
--keymap("n", "<C-f>", "<cmd>Telescope live_grep<cr>", noremap)

-------------------- Insert ----------------------

-- Fast escape from insert mode
keymap("i", "jk", "<ESC>", noremap)

-- Move text up and down
keymap("i", "<A-j>", "<ESC>:m .+1<CR><a>", noremap)
keymap("i", "<A-k>", "<ESC>:m .-2<CR><a>", noremap)

-------------------- Visual ----------------------

-- Stay in indent mode
keymap("v", "<", "<gv", noremap)
keymap("v", ">", ">gv", noremap)

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", noremap)
keymap("v", "<A-k>", ":m .-1<CR>==", noremap)
keymap("v", "p", '"_dP', noremap)

----------------- Visual Block -------------------

-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", noremap)
keymap("x", "K", ":move '<-2<CR>gv-gv", noremap)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", noremap)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", noremap)

------------------- Terminal ---------------------

-- Better terminal navigation
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", terminal)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", terminal)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", terminal)
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", terminal)
