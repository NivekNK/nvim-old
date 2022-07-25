M = {}

-- Mappings in Normal mode
M.toggler = {
    -- Line-comment
    line = "com",
    -- Block-comment
    block = "cob"
}

-- Mappings in Visual mode
M.opleader = {
    -- Line-comment
    line = "co",
    -- Block-comment
    block = "cb"
}

M.extra = {
    -- Add comment on the line above
    above = "coO",
    -- Add comment on the line below
    below = "coo",
    -- Add comment at the end of line
    eol = "coA"
}

return M
