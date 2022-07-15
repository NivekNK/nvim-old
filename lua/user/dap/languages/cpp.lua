local status_ok, dap = pcall(require, "dap")
if not status_ok then
    vim.notify("Error loading dap!")
    return
end

dap.adapters.cppdbg = {
    id = "cppdbg",
    type = "executable",
    command = "/home/nivek/.dotfiles/nvim/.config/nvim/vendor/vscode-cpptools/extension/debugAdapters/bin/OpenDebugAD7"
    -- command = "/home/nivek/.dotfiles/nvim/.config/nvim/vendor/vscode-cpptools/debugAdapters/bin/OpenDebugAD7"
    -- command = "/home/nivek/.config/nvim/vendor/vscode-cpptools/debugAdapters/bin/OpenDebugAD7"
    -- command = os.getenv("HOME") .. "/.config/nvim/vendor/vscode-cpptools/debugAdapters/bin/OpenDebugAD7"
}

dap.configurations.cpp = {
    {
        name = "Launch (vscode-cpptools)",
        type = "cppdbg",
        request = "launch",
        program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = true
    }
}
