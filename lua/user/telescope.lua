---@diagnostic disable: need-check-nil
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
    extensions = {
        emoji = {
            action = function(emoji)
                -- argument emoji is a table.
                -- {name="", value="", cagegory="", description=""}

                vim.fn.setreg("*", emoji.value)
                print([[Press p or "*p to paste this emoji]] .. emoji.value)

                -- insert emoji when picked
                vim.api.nvim_put({ emoji.value }, 'c', false, true)
            end
        }
    }
}

telescope.load_extension("emoji")
