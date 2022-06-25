local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
    vim.notify("Error loading telescope!")
    return
end

local keymaps = require("user.keymaps")
local actions = require("telescope.actions")

telescope.setup {
    defaults = {
        prompt_prefix = " ",
        selection_caret = " ",
        path_display = { "smart" },
        mappings = {
            i = keymaps.telescope_insert_keymaps(actions),
            n = keymaps.telescope_normal_keymaps(actions)
        }
    },
    pickers = {},
    extensions = {}
}
