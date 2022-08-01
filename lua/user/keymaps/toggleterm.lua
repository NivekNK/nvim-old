local K = require("user.keymaps.utils.keymap")

M = {}

M.open = [[<C-\>]]

function M.setup_buffer()
    K.tsmap("<ESC>", [[<C-\><C-n>]], { buffer = 0 })
    K.tsmap("jk", [[<C-\><C-n>]], { buffer = 0 })
    K.tsmap("<C-h>", [[<C-\><C-n><C-W>h]], { buffer = 0 })
    K.tsmap("<C-j>", [[<C-\><C-n><C-W>j]], { buffer = 0 })
    K.tsmap("<C-k>", [[<C-\><C-n><C-W>k]], { buffer = 0 })
    K.tsmap("<C-l>", [[<C-\><C-n><C-W>l]], { buffer = 0 })
end

return M
