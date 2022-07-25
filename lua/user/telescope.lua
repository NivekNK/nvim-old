local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
    vim.notify("Error loading telescope!")
    return
end

local keymaps = require("user.keymaps.telescope")
local actions = require("telescope.actions")

telescope.setup {
    defaults = {
        prompt_prefix = " ",
        selection_caret = " ",
        path_display = { "smart" },
        mappings = {
            i = keymaps.get_insert(actions),
            n = keymaps.get_normal(actions)
        }
    },
    pickers = {},
    extensions = {}
}
