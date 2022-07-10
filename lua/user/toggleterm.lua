local status_ok, toggleterm = pcall(require, "toggleterm")
if not status_ok then
    vim.notify("Error loading toggleterm!")
    return
end

local keymaps = require("user.keymaps")

local function get_shell()
    if vim.loop.os_uname().sysname == "Windows" then
        return "pwsh -NoLogo"
    end

    return "zsh"
end

toggleterm.setup {
    size = 20,
    open_mapping = keymaps.open_toggleterm,
    on_close = function()
        vim.cmd("NvimTreeRefresh")
    end,
    hide_numbers = true,
    shade_filetypes = {},
    shade_terminals = true,
    shading_factor = 2,
    start_in_insert = true,
    insert_mappings = true,
    persist_size = true,
    direction = "float",
    close_on_exit = true,
    shell = get_shell(),
    float_opts = {
        border = "curved",
        winblend = 0,
        highlights = {
            border = "Normal",
            background = "Normal"
        }
    }
}

function _G.set_terminal_keymaps()
    keymaps.toggleterm_keymaps()
end

vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

local Terminal = require("toggleterm.terminal").Terminal
local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })

function _LAZYGIT_TOGGLE()
    lazygit:toggle()
end

local node = Terminal:new({ cmd = "node", hidden = true })

function _NODE_TOGGLE()
    node:toggle()
end

local ncdu = Terminal:new({ cmd = "ncdu", hidden = true })

function _NCDU_TOGGLE()
    ncdu:toggle()
end

local htop = Terminal:new({ cmd = "htop", hidden = true })

function _HTOP_TOGGLE()
    htop:toggle()
end

local python = Terminal:new({ cmd = "python", hidden = true })

function _PYTHON_TOGGLE()
    python:toggle()
end
