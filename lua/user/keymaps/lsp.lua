local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
    vim.notify("Error loading lspconfig in lsp keymaps!")
    return nil
end

local K = require("user.keymaps.utils.keymap")

M = {}

function M.setup()

    K.nmap("fo", ':Format<CR>:lua vim.notify("File formatted!")<CR>')

end

function M.setup_buffer(buffer)

    K.nmap("gD", function()
        vim.lsp.buf.declaration()
    end, { buffer = buffer })

    K.nmap("gd", function()
        vim.lsp.buf.definition()
    end, { buffer = buffer })

    K.nmap("K", function()
        vim.lsp.buf.hover()
    end, { buffer = buffer })

    K.nmap("gi", function()
        vim.lsp.buf.implementation()
    end, { buffer = buffer })

    K.nmap("<C-k>", function()
        vim.lsp.buf.signature_help()
    end, { buffer = buffer })

    K.nmap("gr", function()
        vim.lsp.buf.references()
    end, { buffer = buffer })

    K.nmap("[d", function()
        vim.diagnostic.goto_prev({ border = "rounded" })
    end, { buffer = buffer })

    K.nmap("gl", function()
        vim.diagnostic.open_float({ border = "rounded" })
    end, { buffer = buffer })

    K.nmap("]d", function()
        vim.diagnostic.goto_next({ border = "rounded" })
    end, { buffer = buffer })

    K.nmap("<leader>q", function()
        vim.diagnostic.setloclist()
    end, { buffer = buffer })

end

return M
