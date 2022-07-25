local capabilities = require("user.lsp.handlers").capabilities
capabilities.offsetEncoding = { "utf-16" }

M = {}

M.opts = {
    capabilities = capabilities
}

M.server = nil

return M
