M = {}

function M.get(fn)
    local opts = {
        { key = { "l", "<CR>", "o" }, action = "edit", mode = "n" },
        { key = "h", action = "close_node" },
        { key = "v", action = "vsplit" },
        { key = "C", action = "cd" },
        { key = "n", action = "create" },
        { key = "b", action = "create_book", action_cb = fn.create_book }
    }
    return opts
end

return M
