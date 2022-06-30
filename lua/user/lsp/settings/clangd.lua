local capabilities = require("user.lsp.handlers").capabilities
capabilities.offsetEncoding = { "utf-16" }

local opts = {
    capabilities = capabilities
}

return opts
