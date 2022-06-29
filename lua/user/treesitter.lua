local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
    vim.notify("Failed to load treesitter.configs")
    return
end

require("nvim-treesitter.install").compilers = { "clang" }

configs.setup {
    ensure_installed = "all",
    sync_install = false,
    ignore_install = { "rnoweb" }, -- List of parsers to ignore installing
    highlight = {
        enable = true,
        disable = { "" }, -- list of language that will be disabled
        additional_vim_regex_highlighting = true
    },
    indent = {
        enable = true,
        disable = { "yaml" }
    },
    autopairs = {
        enable = true
    },
    context_commentstring = {
        enable = true,
        enable_autocmd = false
    },
    playground = {
        enable = true
    }
}
