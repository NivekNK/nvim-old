local status_ok, illuminate = pcall(require, "illuminate")
if not status_ok then
    vim.notify("Error loading illuminate on illuminate keymaps!")
    return nil
end

local K = require("user.keymaps.utils.keymap")

M = {}

function M.setup()

    K.nmap("<A-n>", function()
        illuminate.next_reference({ wrap = true })
    end)

    K.nmap("<A-p>", function()
        illuminate.next_reference({ reverse = true, wrap = true })
    end)

end

return M
