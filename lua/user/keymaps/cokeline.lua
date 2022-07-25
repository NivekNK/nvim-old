local status_ok, _ = pcall(require, "cokeline")
if not status_ok then
    vim.notify("Error loading cokeline in cokeline keymaps!")
    return nil
end

local K = require("user.keymaps.utils.keymap")

M = {}

function M.setup()

    K.nsmap("pf", "<Plug>(cokeline-pick-focus)")

    K.nsmap("pc", "<Plug>(cokeline-pick-close)")

    for i = 1, 9 do
        -- Change current buffer focus to index
        K.nsmap(("<A-%s>"):format(i), ("<Plug>(cokeline-focus-%s)"):format(i))
        -- Move current buffer to index
        K.nsmap(("<leader>%s"):format(i), ("<Plug>(cokeline-switch-%s)"):format(i))
    end

end

return M
