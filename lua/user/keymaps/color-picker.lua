local status_ok, _ = pcall(require, "color-picker")
if not status_ok then
    vim.notify("Error loading color-picker in color-picker keymaps!")
    return nil
end

local K = require("user.keymaps.utils.keymap")

M = {}

function M.setup()

    K.nmap("<C-c>", "<cmd>PickColor<CR>")

    K.imap("<C-c>", "<cmd>PickColorInsert<CR>")

end

M.keymap = {
    ["U"] = "<Plug>ColorPickerSlider5Decrease",
    ["O"] = "<Plug>ColorPickerSlider5Increase"
}

return M
