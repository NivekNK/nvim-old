local M = {}

M.setup = function()
    local signs = {
        { name = "DiagnosticSignError", text = "" },
        { name = "DiagnosticSignWarn", text = "" },
        { name = "DiagnosticSignHint", text = "" },
        { name = "DiagnosticSignInfo", text = "" }
    }

    for _, sign in ipairs(signs) do
        vim.fn.sign_define(sign.name, {
            texthl = sign.name,
            text = sign.text,
            numhl = ""
        })
    end

    local config = {
        virtual_text = false,
        signs = {
            active = signs
        },
        update_in_insert = true,
        underline = true,
        severity_sort = true,
        float = {
            focusable = false,
            style = "minimal",
            border = "rounded",
            source = "always",
            header = "",
            prefix = ""
        }
    }

    vim.diagnostic.config(config)

    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = "rounded",
        width = 60
    })

    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
        border = "rounded",
        width = 60
    })
end

local function lsp_highlight_document(client)
    local status_ok, illuminate = pcall(require, "illuminate")
    if not status_ok then
        return
    end
    illuminate.on_attach(client)
end

local function format_filter(client)
    local status_ok, null_ls = pcall(require, "null-ls")
    if not status_ok then
        return
    end

    local sources = require("null-ls.sources")
    local method = null_ls.methods.FORMATTING
    local available_sources = sources.get_available(vim.bo.filetype, method)

    if #available_sources > 0 then
        client.server_capabilities.document_formatting = false
    end
end

M.on_attach = function(client, bufnr)
    format_filter(client)
    require("user.keymaps.lsp").setup_buffer(bufnr)
    vim.cmd [[ command! Format execute 'lua vim.lsp.buf.format{ async = true }' ]]
    lsp_highlight_document(client)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_ok then
    vim.notify("Error loading cmp_nvim_lsp!")
    return
end

M.capabilities = cmp_nvim_lsp.update_capabilities(capabilities)

return M
