local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
    vim.notify("Error loading nvim-lsp-installer!")
    return
end

local lspconfig = require("lspconfig")

local servers = {
    "jsonls",
    "sumneko_lua",
    "clangd",
    "tsserver",
    "html",
    "rust_analyzer",
    "taplo",
    "omnisharp"
}

lsp_installer.setup {
    ensure_installed = servers
}

for _, server in pairs(servers) do
    local opts = {
        on_attach = require("user.lsp.handlers").on_attach,
        capabilities = require("user.lsp.handlers").capabilities
    }

    local has_custom, custom = pcall(require, "user.lsp.settings." .. server)
    if has_custom then
        opts = vim.tbl_deep_extend("force", opts, custom.opts)
    end

    if custom.server then
        custom.server(opts)
    else
        lspconfig[server].setup(opts)
    end
end
