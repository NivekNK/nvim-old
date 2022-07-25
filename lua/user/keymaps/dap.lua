local status_ok, dap = pcall(require, "dap")
if not status_ok then
    vim.notify("Error loading dap on dap keymaps!")
    return nil
end

local K = require("user.keymaps.utils.keymap")

M = {}

function M.setup()

    K.nmap("<F5>", function()
        dap.continue()
    end)

    K.nmap("<F10>", function()
        dap.step_over()
    end)

    K.nmap("<F11>", function()
        dap.step_into()
    end)

    K.nmap("<F12>", function()
        dap.step_out()
    end)

    K.nmap("<leader>b", function()
        dap.toggle_breakpoint()
    end)

    K.nmap("<leader>B", function()
        dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
    end)

    K.nmap("<leader>lp", function()
        dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
    end)

    K.nmap("<leader>dr", function()
        dap.repl.open()
    end)

end

M.dapui_normal = {
    -- Use a table to apply multiple mappings
    expand = { "<CR>", "<2-LeftMouse>" },
    open = "o",
    remove = "d",
    edit = "e",
    repl = "r",
    toggle = "t"
}

M.dapui_floating = {
    close = { "q", "<Esc>" }
}

return M
