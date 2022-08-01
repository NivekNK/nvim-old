local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
    vim.notify("Error loading cmp!")
    return
end

local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
    vim.notify("Error loading luasnip!")
    return
end

-- local comparators_status_ok, copilot_comparators = pcall(require, "copilot_cmp.comparators")
-- if not comparators_status_ok then
--     vim.notify("Error loading copilot_cmp.comparators!")
--     return
-- end

require("luasnip/loaders/from_vscode").lazy_load()

local kind_icons = {
    Text = "",
    Method = "m",
    Function = "",
    Constructor = "",
    Field = "",
    Variable = "",
    Class = "",
    Interface = "",
    Module = "",
    Property = "",
    Unit = "",
    Value = "",
    Enum = "",
    Keyword = "",
    Snippet = "",
    Color = "",
    File = "",
    Reference = "",
    Folder = "",
    EnumMember = "",
    Constant = "",
    Struct = "",
    Event = "",
    Operator = "",
    TypeParameter = "",
    Copilot = ""
}

vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = require("user.colorscheme").copilot_cmp })

cmp.setup {
    enabled = function()
        local context = require("cmp.config.context")

        if vim.api.nvim_get_mode().mode == "c" then
            return true
        else
            return not context.in_treesitter_capture("comment") and
                   not context.in_syntax_group("Comment")
        end
    end,
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end
    },
    mapping = require("user.keymaps.cmp").get(cmp, luasnip),
    formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(entry, vim_item)
            -- Kind icons
            local icon_kind = vim_item.kind

            if entry.source.name == "copilot" then
                icon_kind = "Copilot"
                vim_item.kind_hl_group = "CmpItemKindCopilot"
            end

            vim_item.kind = string.format("%s", kind_icons[icon_kind])
            vim_item.menu = ({
                copilot = "[Copilot]",
                nvim_lsp = "[LSP]",
                nvim_lua = "[NVIM_LUA]",
                luasnip = "[Snippet]",
                buffer = "[Buffer]",
                path = "[Path]"
            })[entry.source.name]
            return vim_item
        end
    },
    sources = {
        { name = "copilot" },
        { name = "nvim_lsp" },
        { name = "nvim_lua" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "path" }
    },
    confirm_opts = {
        behavior = cmp.ConfirmBehavior.Replace,
        select = false
    },
    window = {
        documentation = cmp.config.window.bordered()
    },
    experimental = {
        ghost_text = true,
        native_menu = false
    },
    sorting = {
        priority_weight = 2,
        comparators = {
            -- copilot_comparators.prioritize,
            -- copilot_comparators.score,
            -- Default comparitor list
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            cmp.config.compare.score,
            cmp.config.compare.recently_used,
            cmp.config.compare.locality,
            cmp.config.compare.kind,
            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order
        }
    }
}
