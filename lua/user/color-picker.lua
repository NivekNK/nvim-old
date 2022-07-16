local status_ok, color_picker = pcall(require, "color-picker")
if not status_ok then
    vim.notify("Error loading color-picker!")
    return
end

color_picker.setup {
    ["icons"] = { "ﱢ", "" },
	["border"] = "solid", -- none | single | double | rounded | solid | shadow
	["keymap"] = require("user.keymaps").color_picker_keymaps
}

-- if you don't want weird border background colors around the popup.
vim.cmd([[hi FloatBorder guibg=NONE]])
