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

-- nvim-tree: Open files navigation panel in the left side
keymap("n", "<leader>e", ":NvimTreeToggle<cr>", noremap)

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
keymap("n", "<leader>f", "<cmd>lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({ previewer = false }))<cr>", noremap)
keymap("n", "<C-f>", "<cmd>Telescope live_grep<cr>", noremap)

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

--------------------------------------------------

M = {}

---------------------- cmp -----------------------

local check_backspace = function()
    local col = vim.fn.col "." - 1
    return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
end

function M.cmp_keymaps(cmp, luasnip)
    local opts = {
        ["<C-k>"] = cmp.mapping.select_prev_item(),
        ["<C-j>"] = cmp.mapping.select_next_item(),
        ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
        ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
        ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
        ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
        ["<C-e>"] = cmp.mapping {
            i = cmp.mapping.abort(),
            c = cmp.mapping.close()
        },
        -- Accept currently selected item. If none selected, `select` first item.
        -- Set `select` to `false` to only confirm explicitly selected items.
        ["<CR>"] = cmp.mapping.confirm {
            select = true
        },
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expandable() then
                luasnip.expand()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            elseif check_backspace() then
                fallback()
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" })
    }
    return opts
end

---------------------- lsp -----------------------

function M.lsp_keymaps(bufnr)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", noremap)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", noremap)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", noremap)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", noremap)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", noremap)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", noremap)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "[d", '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>', noremap)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gl",
        '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics({ border = "rounded" })<CR>', noremap)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "]d", '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>', noremap)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", noremap)
end

------------------- Telescope --------------------

function M.telescope_insert_keymaps(actions)
    local i = {
        ["<C-n>"] = actions.cycle_history_next,
        ["<C-p>"] = actions.cycle_history_prev,

        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,

        ["<C-c>"] = actions.close,

        ["<Down>"] = actions.move_selection_next,
        ["<Up>"] = actions.move_selection_previous,

        ["<CR>"] = actions.select_default,
        ["<C-x>"] = actions.select_horizontal,
        ["<C-v>"] = actions.select_vertical,
        ["<C-t>"] = actions.select_tab,

        ["<C-u>"] = actions.preview_scrolling_up,
        ["<C-d>"] = actions.preview_scrolling_down,

        ["<PageUp>"] = actions.results_scrolling_up,
        ["<PageDown>"] = actions.results_scrolling_down,

        ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
        ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
        ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
        ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
        ["<C-l>"] = actions.complete_tag,
        ["<C-_>"] = actions.which_key -- keys from pressing <C-/>
    }
    return i
end

function M.telescope_normal_keymaps(actions)
    local n = {
        ["<ESC>"] = actions.close,
        ["<CR>"] = actions.select_default,
        ["<C-x>"] = actions.select_horizontal,
        ["<C-v>"] = actions.select_vertical,
        ["<C-t>"] = actions.select_tab,

        ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
        ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
        ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
        ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,

        ["j"] = actions.move_selection_next,
        ["k"] = actions.move_selection_previous,
        ["H"] = actions.move_to_top,
        ["M"] = actions.move_to_middle,
        ["L"] = actions.move_to_bottom,

        ["<Down>"] = actions.move_selection_next,
        ["<Up>"] = actions.move_selection_previous,
        ["gg"] = actions.move_to_top,
        ["G"] = actions.move_to_bottom,

        ["<C-u>"] = actions.preview_scrolling_up,
        ["<C-d>"] = actions.preview_scrolling_down,

        ["<PageUp>"] = actions.results_scrolling_up,
        ["<PageDown>"] = actions.results_scrolling_down,

        ["?"] = actions.which_key
    }
    return n
end

------------------- Autopairs --------------------

M.autopairs_fast_wrap = "<A-e>"

-------------------- Comment ---------------------

-- Mappings in Normal mode
M.comment_toggler_keymaps = {
    -- Line-comment
    line = "gcc",
    -- Block-comment
    block = "gbc"
}

-- Mappings in Visual mode
M.comment_opleader_keymaps = {
    -- Line-comment
    line = "gc",
    -- Block-comment
    block = "gb"
}

M.comment_extra_keymaps = {
    -- Add comment on the line above
    above = "gcO",
    -- Add comment on the line below
    below = "gco",
    -- Add comment at the end of line
    eol = "gcA"
}

------------------- nvim-tree --------------------

function M.nvim_tree_keymaps(tree_cb)
    local opts = {
        { key = {"l", "<CR>", "o"}, cb = tree_cb "edit" },
        { key = "h", cb = tree_cb "close_node" },
        { key = "v", cb = tree_cb "vsplit" },
        { key = "n", cb = tree_cb "create" }
    }
    return opts
end

--------------------------------------------------

return M
