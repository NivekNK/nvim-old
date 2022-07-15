local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
    vim.notify("Error loading telescope for dap!")
    return
end

telescope.load_extension("dap")
