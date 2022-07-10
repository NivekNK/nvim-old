local status_ok, colorizer = pcall(require, "colorizer")
if not status_ok then
    vim.notify("Error loading colorizer!")
    return
end

colorizer.setup({ '*' }, { names = false; })
