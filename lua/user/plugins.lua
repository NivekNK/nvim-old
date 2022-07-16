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
    vim.notify("Error loading packer!")
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
    use "wbthomason/packer.nvim"                            -- Packer for plugins installs
    use "nvim-lua/popup.nvim"                               -- An implementation of the Popup API from vim in Neovim
    use "nvim-lua/plenary.nvim"                             -- Useful lua functions used ny lots of plugins

    -- Misc Plugins
    use "lunarvim/darkplus.nvim"                            -- Dark theme for Neovim based on VSCode theme
    use "b0o/schemastore.nvim"                              -- Json schemas
    use "windwp/nvim-autopairs"                             -- Autopairs, integrates with both cmp and treesitter
    use "numToStr/Comment.nvim"                             -- Easy comments with keymap
    use "noib3/nvim-cokeline"                               -- Bufferline
    use "nvim-lualine/lualine.nvim"                         -- Status line
    use "akinsho/toggleterm.nvim"                           -- Better terminal for neovim
    use "ahmedkhalf/project.nvim"                           -- Manage user projects
    use "lewis6991/impatient.nvim"                          -- Make nvim load faster on startup
    use "lukas-reineke/indent-blankline.nvim"               -- Indent line
    use "goolord/alpha-nvim"                                -- Greeter for nvim
    use "antoinemadec/FixCursorHold.nvim"                   -- This is needed to fix lsp doc highlight
    use {
        "RRethy/vim-hexokinase",                            -- In buffer color visualizer on virtual text
        run = "cd hexokinase/.. && make hexokinase"
    }
    use "ziontee113/color-picker.nvim"                      -- Color picker
    use "folke/which-key.nvim"                              -- Easy and fast access to keymaps
    use "RRethy/vim-illuminate"                             -- Highlighting of other uses of the selected word

    -- Cmp
    use "hrsh7th/nvim-cmp"                                  -- Code completion engine
    use "hrsh7th/cmp-buffer"                                -- Buffer completions
    use "hrsh7th/cmp-path"                                  -- Path completions
    use "hrsh7th/cmp-cmdline"                               -- Cmdline completions
    use "saadparwaiz1/cmp_luasnip"                          -- Snippet completions
    use "hrsh7th/cmp-nvim-lsp"                              -- Cmp and LSP integratio
    use "hrsh7th/cmp-nvim-lua"                              -- Lua for Neovim completion

    -- Snippets
    use "L3MON4D3/LuaSnip"                                  -- Snippet engine
    use "rafamadriz/friendly-snippets"                      -- A bunch of snippets to use

    -- LSP
    use "neovim/nvim-lspconfig"                             -- Enable LSP
    use "williamboman/nvim-lsp-installer"                   -- Simple to use language server installer
    use "jose-elias-alvarez/null-ls.nvim"                   -- For formatters and linters

    -- Telescope
    use "nvim-telescope/telescope.nvim"                     -- Fuzzy finder

    -- Treesitter
    use {
        "nvim-treesitter/nvim-treesitter",                  -- Language highlighting
        run = ":TSUpdate"
    }
    use "nvim-treesitter/playground"                        -- Treesitter theme creator
    use "JoosepAlviste/nvim-ts-context-commentstring"       -- Treesitter Comment.nvim compatibility

    -- Git
    use "lewis6991/gitsigns.nvim"                           -- Git code control

    -- nvim-tree
    use "kyazdani42/nvim-web-devicons"                      -- Web dev icons
    use "kyazdani42/nvim-tree.lua"                          -- File navigation panel

    -- Copilot
    -- use "github/copilot.vim"
    use {
        "zbirenbaum/copilot.lua",                           -- Github AI pair programming
        event = { "VimEnter" },
        config = function()
            vim.defer_fn(function()
                require("user.copilot")
            end, 100)
        end
    }
    use "zbirenbaum/copilot-cmp"                            -- Integration of Copilot with cmp for completions

    -- Note taking
    use {
        "iamcco/markdown-preview.nvim",                     -- Markdown preview
        run = "cd app && npm install",
        setup = function()
            vim.g.mkdp_filetypes = { "markdown" }
        end,
        ft = { "markdown" }
    }
    use "sidebar-nvim/sidebar.nvim"                         -- Sidebar for showing file todos

    -- Dap
    use "mfussenegger/nvim-dap"                             -- Debug Protocol Adapter
    use "theHamsta/nvim-dap-virtual-text"                   -- Virtual text while debugging with dap
    use "rcarriga/nvim-dap-ui"                              -- Better UI for dap
    use "nvim-telescope/telescope-dap.nvim"                 -- Telescope integration for dap

    -- Automatically set up your configuration after cloning packer.nvim
    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)
