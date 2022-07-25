local status_ok, rust_tools = pcall(require, "rust-tools")
if not status_ok then
    vim.notify("Error loading rust-tools!")
    return nil
end

M = {}

M.opts = {
    settings = {
        ["rust-analyzer"] = {
            lens = {
                enable = true
            },
            checkOnSave = {
                command = "clippy"
            }
        }
    }
}

M.server = function(server_opts)
    rust_tools.setup {
        server = server_opts
    }
end

return M
