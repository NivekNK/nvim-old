local K = require("user.keymaps.utils.keymap")

M = {}

function M.setup()

-------------------- Normal ----------------------

    -- Save file
    K.nmap("<C-s>", ":w<CR>")

    -- Change between panels in window
    K.nmap("<leader>h", "<C-w>h")
    K.nmap("<leader>j", "<C-w>j")
    K.nmap("<leader>k", "<C-w>k")
    K.nmap("<leader>l", "<C-w>l")

    -- nvim-tree: Open files navigation panel in the left side
    K.nmap("<leader>e", ":NvimTreeToggle<cr>")

    -- Resize selected panel
    K.nmap("<C-Up>", ":resize +2<CR>")
    K.nmap("<C-Down>", ":resize -2<CR>")
    K.nmap("<C-Left>", ":vertical resize -2<CR>")
    K.nmap("<C-Right>", ":vertical resize +2<CR>")

    -- Swap buffers / Change window
    K.nmap("<S-l>", ":bnext<CR>")
    K.nmap("<S-h>", ":bprevious<CR>")

    -- Split panel
    K.nmap("<C-L>", ":vsplit<CR>")
    K.nmap("<C-J>", ":split<CR>")

    -- Move text up and down
    K.nmap("<A-j>", "<ESC>:m .+1<CR>")
    K.nmap("<A-k>", "<ESC>:m .-2<CR>")
    K.nmap("<CA-j>", "<ESC>:m .+1<CR><a>")
    K.nmap("<CA-k>", "<ESC>:m .-2<CR><a>")

    -- Select text
    K.nmap("<C-a>", "ggVG")

-------------------- Insert ----------------------

    -- Save file
    K.imap("<C-s>", ":w<CR>")

    -- Fast escape from insert mode
    K.imap("jk", "<ESC>")

    -- Move text up and down
    K.imap("<A-j>", "<ESC>:m .+1<CR><a>")
    K.imap("<A-k>", "<ESC>:m .-2<CR><a>")

    -------------------- Visual ----------------------

    -- Stay in indent mode
    K.vmap("<", "<gv")
    K.vmap(">", ">gv")

    -- Move text up and down
    K.vmap("<A-j>", ":m .+1<CR>==")
    K.vmap("<A-k>", ":m .-1<CR>==")
    K.vmap("p", '"_dP')

----------------- Visual Block -------------------

    -- Move text up and down
    K.xmap("J", ":move '>+1<CR>gv-gv")
    K.xmap("K", ":move '<-2<CR>gv-gv")
    K.xmap("<A-j>", ":move '>+1<CR>gv-gv")
    K.xmap("<A-k>", ":move '<-2<CR>gv-gv")

end

return M
