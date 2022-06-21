local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOSTRAP = fn.system {
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    }
    print "Installing packer close and reapon Neovim..."
    vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads Neovim whenever you save the plugins.lua file
vim.cmd [[
    augroup packer_user_config
        autocmd!
        autocmd BufWritePost plugins.lua source <afile> | PackerSync
    augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    vim.notify("Packer not working!")
    return
end

-- Have packer use a popup window
packer.init {
    display = {
        open_fn = function()
            return require("packer.util").float { border = "rounded" }
        end
    }
}

-- Install your plugins here
return packer.startup(function(use)
    -- Required plugins
    use "wbthomason/packer.nvim"                -- Have packer manage itself
    use "nvim-lua/popup.nvim"                   -- An implementation of the Popup API from vim in Neovim
    use "nvim-lua/plenary.nvim"                 -- Useful lua functions used in lots of plugins

    -- Colorscheme
    use "cpea2506/one_monokai.nvim"             -- One Monokai colorscheme
    use "lunarvim/darkplus.nvim"

    -- Cmp
    use "hrsh7th/nvim-cmp"                      -- The completion plugin
    use "hrsh7th/cmp-buffer"                    -- Buffer completions
    use "hrsh7th/cmp-path"                      -- Path completions
    use "hrsh7th/cmp-cmdline"                   -- Cmdline completions
    use "saadparwaiz1/cmp_luasnip"              -- Snippet completions
    use "hrsh7th/cmp-nvim-lsp"                  -- Cmp and LSP integration
    use "hrsh7th/cmp-nvim-lua"                  -- Lua for Neovim completion

    -- Snippets
    use "L3MON4D3/LuaSnip"                      -- Snippet engine
    use "rafamadriz/friendly-snippets"          -- A bunch of snippets to use

    -- Json
    use "b0o/schemastore.nvim"                  -- Json schemas

    -- LSP
    use "neovim/nvim-lspconfig"                 -- Enable LSP
    use "williamboman/nvim-lsp-installer"       -- Simple to use language server installer

    -- Telescope
    use "nvim-telescope/telescope.nvim"         -- Fuzzy finder

    -- Treesitter
    use {
        "nvim-treesitter/nvim-treesitter",      -- Language highlighting
        run = ":TSUpdate"
    }
    use "nvim-treesitter/playground"            -- Treesitter theme creator

    -- Copilot
    use {
        "zbirenbaum/copilot.lua",
        event = { "VimEnter" },
        config = function()
            vim.defer_fn(function()
                require("copilot").setup()
            end, 100)
        end
    }
    use "zbirenbaum/copilot-cmp"

    -- Automatically set up your configuration after cloning packer.nvim
    if PACKER_BOOSTRAP then
        require("packer").sync()
    end
end)

