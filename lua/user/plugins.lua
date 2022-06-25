local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system {"git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim",
                                  install_path}
    print "Installing packer close and reopen Neovim..."
    vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
    augroup packer_user_config
        autocmd!
        autocmd BufWritePost plugins.lua source <afile> | PackerSync
    augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    vim.notify("Error loading packer", vim.scheme.red)
    return
end

-- Have packer use a popup window
packer.init {
    display = {
        open_fn = function()
            return require("packer.util").float {
                border = "rounded"
            }
        end
    }
}
    
return packer.startup(function(use)
    -- Required Plugins
    use "wbthomason/packer.nvim"                                                                -- Packer for plugins installs
    use "nvim-lua/popup.nvim"                                                                   -- An implementation of the Popup API from vim in Neovim
    use "nvim-lua/plenary.nvim"                                                                 -- Useful lua functions used ny lots of plugins

    -- Misc Plugins
    use "lunarvim/darkplus.nvim"

    -- Cmp plugins
    use "hrsh7th/nvim-cmp"                                                                      -- The completion plugin
    use "hrsh7th/cmp-buffer"                                                                    -- buffer completions
    use "hrsh7th/cmp-path"                                                                      -- path completions
    use "hrsh7th/cmp-cmdline"                                                                   -- cmdline completions
    use "saadparwaiz1/cmp_luasnip"                                                              -- snippet completions

    -- Snippets
    use "L3MON4D3/LuaSnip"                                                                      -- snippet engine
    use "rafamadriz/friendly-snippets"                                                          -- a bunch of snippets to use

    -- Automatically set up your configuration after cloning packer.nvim
    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)
