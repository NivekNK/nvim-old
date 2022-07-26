local status_ok, dap = pcall(require, "dap")
if not status_ok then
    vim.notify("Error loading dap!")
    return
end

dap.adapters.coreclr = {
    type = "executable",
    command = "/usr/bin/netcoredbg",
    args = { "--interpreter=vscode" }
}

dap.configurations.cs = {
    {
        type = "coreclr",
        name = "Launch - netcoredbg",
        request = "launch",
        program = function()
            return vim.fn.input("Path to dll: ", vim.fn.getcwd() .. "/bin/Debug/", "file")
        end
    }
}
