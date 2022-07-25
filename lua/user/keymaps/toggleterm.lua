local K = require("user.keymaps.utils.keymap")

M = {}

M.open = [[<C-\>]]

function M.setup_buffer()
    K.tmap("<ESC>", [[<C-\><C-n>]], { buffer = 0 })
    K.tmap("jk", [[<C-\><C-n>]], { buffer = 0 })
    K.tmap("<C-h>", [[<C-\><C-n><C-W>h]], { buffer = 0 })
    K.tmap("<C-j>", [[<C-\><C-n><C-W>j]], { buffer = 0 })
    K.tmap("<C-k>", [[<C-\><C-n><C-W>k]], { buffer = 0 })
    K.tmap("<C-l>", [[<C-\><C-n><C-W>l]], { buffer = 0 })
end

return M
