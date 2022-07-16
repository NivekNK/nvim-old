-- Nvim Modes Normal Mode: "n"
--    Insert Mode: "i"
--    Visual Mode: "v"
--    Visual Block Mode: "x"
--    Terminal Mode: "t"
--    Command Mode: "c"

local noremap = { noremap = true, silent = true }

local silent = { silent = true }

-- Keymap function
local keymap = vim.api.nvim_set_keymap

-- Leader Key
keymap("", "<Space>", "<Nop>", noremap)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-------------------- Normal ----------------------

-- Save file
keymap("n", "<C-s>", ":w<CR>", noremap)

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

-- Select text
keymap("n", "<C-a>", "ggVG", noremap)

-- Telescope: Find files and text
keymap("n", "<leader>f", "<cmd>lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({ previewer = false }))<cr>", noremap)
keymap("n", "<C-f>", "<cmd>Telescope live_grep<cr>", noremap)

-- Cokeline
keymap("n", "pf", "<Plug>(cokeline-pick-focus)", silent)
keymap("n", "pc", "<Plug>(cokeline-pick-close)", silent)
for i = 1, 9 do
    -- Change current buffer focus to index
    keymap("n", ("<A-%s>"):format(i), ("<Plug>(cokeline-focus-%s)"):format(i), silent)
    -- Move current buffer to index
    keymap("n", ("<leader>%s"):format(i), ("<Plug>(cokeline-switch-%s)"):format(i), silent)
end

-- LSP
keymap("n", "fo", ":Format<CR>", noremap)

-- Illuminate
keymap("n", "<A-n>", '<cmd>lua require("illuminate").next_reference{ wrap = true }<CR>', noremap)
keymap("n", "<A-p>", '<cmd>lua require("illuminate").next_reference{ reverse = true, wrap = true }<CR>', noremap)

-- Dap
keymap("n", "<F5>", ':lua require("dap").continue()<CR>', noremap)
keymap("n", "<F10>", ':lua require("dap").step_over()<CR>', noremap)
keymap("n", "<F11>", ':lua require("dap").step_into()<CR>', noremap)
keymap("n", "<F12>", ':lua require("dap").step_out()<CR>', noremap)
keymap("n", "<leader>b", ':lua require("dap").toggle_breakpoint()<CR>', noremap)
keymap("n", "<leader>B", ':lua require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>', noremap)
keymap("n", "<leader>lp", ':lua require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<CR>', noremap)
keymap("n", "<leader>dr", ':lua require("dap").repl.open()<CR>', noremap)

-- Color Picker
keymap("n", "<C-c>", "<cmd>PickColor<CR>", noremap)

-------------------- Insert ----------------------

-- Save file
keymap("i", "<C-s>", ":w<CR>", noremap)

-- Fast escape from insert mode
keymap("i", "jk", "<ESC>", noremap)

-- Move text up and down
keymap("i", "<A-j>", "<ESC>:m .+1<CR><a>", noremap)
keymap("i", "<A-k>", "<ESC>:m .-2<CR><a>", noremap)

-- Color Picker
keymap("i", "<C-c>", "<cmd>PickColorInsert<CR>", noremap)

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

-- Better silent navigation
-- keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", silent)
-- keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", silent)
-- keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", silent)
-- keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", silent)

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
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gl", '<cmd>lua vim.diagnostic.open_float({ border = "rounded" })<CR>', noremap)
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
    line = "com",
    -- Block-comment
    block = "cob"
}

-- Mappings in Visual mode
M.comment_opleader_keymaps = {
    -- Line-comment
    line = "co",
    -- Block-comment
    block = "cb"
}

M.comment_extra_keymaps = {
    -- Add comment on the line above
    above = "coO",
    -- Add comment on the line below
    below = "coo",
    -- Add comment at the end of line
    eol = "coA"
}

------------------- nvim-tree --------------------

function M.nvim_tree_keymaps(fn)
    local opts = {
        { key = { "l", "<CR>", "o" }, action = "edit", mode = "n" },
        { key = "h", action = "close_node" },
        { key = "v", action = "vsplit" },
        { key = "C", action = "cd" },
        { key = "n", action = "create" },
        { key = "b", action = "create_book", action_cb = fn.create_book }
    }
    return opts
end

------------------ Toggleterm --------------------

M.open_toggleterm = [[<C-\>]]

function M.toggleterm_keymaps()
    vim.api.nvim_buf_set_keymap(0, "t", "<ESC>", [[<C-\><C-n>]], noremap)
    vim.api.nvim_buf_set_keymap(0, "t", "jk", [[<C-\><C-n>]], noremap)
    vim.api.nvim_buf_set_keymap(0, "t", "<C-h>", [[<C-\><C-n><C-W>h]], noremap)
    vim.api.nvim_buf_set_keymap(0, "t", "<C-j>", [[<C-\><C-n><C-W>j]], noremap)
    vim.api.nvim_buf_set_keymap(0, "t", "<C-k>", [[<C-\><C-n><C-W>k]], noremap)
    vim.api.nvim_buf_set_keymap(0, "t", "<C-l>", [[<C-\><C-n><C-W>l]], noremap)
end

---------------------- Dap -----------------------

M.dapui_normal_keymaps = {
    -- Use a table to apply multiple mappings
    expand = { "<CR>", "<2-LeftMouse>" },
    open = "o",
    remove = "d",
    edit = "e",
    repl = "r",
    toggle = "t"
}

M.dapui_floating_keymaps = {
    close = { "q", "<Esc>" }
}

----------------- color-picker -------------------

M.color_picker_keymaps = {
    ["U"] = "<Plug>ColorPickerSlider5Decrease",
    ["O"] = "<Plug>ColorPickerSlider5Increase"
}

--------------------------------------------------

return M
