local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
    vim.notify("Error loading nvim-treesitter.configs")
    return
end

require("nvim-treesitter.install").compilers = { "clang" }

configs.setup {
    ensure_installed = "all",
    sync_install = false,
    ignore_install = {}, -- List of parsers to ignore installing
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
    },
    nt_cpp_tools = {
        enable = true,
        preview = {
            quit = "q", -- optional keymapping for quit preview
            accept = "<tab>" -- optional keymapping for accept preview
        },
        header_extension = "h", -- optional
        source_extension = "cpp", -- optional
        custom_define_class_function_commands = { -- optional
            TSCppImplWrite = {
                output_handle = require'nvim-treesitter.nt-cpp-tools.output_handlers'.get_add_to_cpp()
            }
            --[[
            <your impl function custom command name> = {
                output_handle = function (str, context) 
                    -- string contains the class implementation
                    -- do whatever you want to do with it
                end
            }
            ]]
        }
    }
}
