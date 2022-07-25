vim.cmd [[
    augroup _general_settings
        autocmd!
        autocmd FileType qf,help,man,lspinfo nnoremap <silent> <buffer> q :close<CR> 
        autocmd TextYankPost * silent!lua require('vim.highlight').on_yank({ higroup = 'Visual', timeout = 200 }) 
        autocmd BufWinEnter * :set formatoptions-=cro
        autocmd FileType qf set nobuflisted
    augroup end

    augroup _git
        autocmd!
        autocmd FileType gitcommit setlocal wrap
        autocmd FileType gitcommit setlocal spell
    augroup end
    
    augroup _markdown
        autocmd!
        autocmd FileType markdown setlocal wrap
        autocmd FileType markdown setlocal spell
    
    augroup end
    augroup _auto_resize
        autocmd!
        autocmd VimResized * tabdo wincmd = 
    augroup end
    
    augroup _alpha
        autocmd!
        autocmd User AlphaReady set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2
    augroup end

    augroup FileTypeSpecificAutocommands
        autocmd FileType javascript setlocal tabstop=2 softtabstop=2 shiftwidth=2
        autocmd FileType javascriptreact setlocal tabstop=2 softtabstop=2 shiftwidth=2
        autocmd FileType typescript setlocal tabstop=2 softtabstop=2 shiftwidth=2
        autocmd FileType typescriptreact setlocal tabstop=2 softtabstop=2 shiftwidth=2
        autocmd FileType css setlocal tabstop=2 softtabstop=2 shiftwidth=2
        autocmd FileType php setlocal tabstop=2 softtabstop=2 shiftwidth=2
    augroup END
]]

vim.api.nvim_create_autocmd({ "InsertEnter" }, {
    callback = function()
        local luasnip = require("luasnip")
        if luasnip.expand_or_jumpable() then
            luasnip.unlink_current()
        end
    end
})

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
    pattern = { "*.rs" },
    callback = function()
        vim.lsp.codelens.refresh()
    end
})

vim.cmd [[command! Q q]]
