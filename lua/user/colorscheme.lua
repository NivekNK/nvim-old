local colorscheme = "darkplus"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
    vim.notify("colorscheme " .. colorscheme .. " not found!")
    return
end

M = {}

M.highlight = "#8217BB"
M.copilot_cmp = "#6CC644"

return M
