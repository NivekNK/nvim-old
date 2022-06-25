local status_ok, cokeline = pcall(require, "cokeline")
if not status_ok then
    vim.notify("Cokeline not found!")
    return
end

local is_picking_focus = require("cokeline/mappings").is_picking_focus
local is_picking_close = require("cokeline/mappings").is_picking_close
local get_hex = require("cokeline/utils").get_hex

local red = vim.g.terminal_color_1
local yellow = vim.g.terminal_color_4

local dark_bg = get_hex("Normal", "bg")
local grey_bg = get_hex("ColorColumn", "bg")
local light_fg = get_hex("Comment", "fg")
local highlight = require("user.colorscheme").highlight

local errors_fg = get_hex('DiagnosticError', 'fg')
local warnings_fg = get_hex('DiagnosticWarn', 'fg')
local infos_fg = get_hex('DiagnosticInfo', 'fg')
local hints_fg = get_hex('DiagnosticHint', 'fg')

cokeline.setup {
    default_hl = {
        fg = function(buffer)
            if buffer.is_focused then
                return dark_bg
            end
            return light_fg
        end,
        bg = function(buffer)
            if buffer.is_focused then
                return highlight
            end
            return grey_bg
        end
    },
    sidebar = {
        filetype = "NvimTree",
        components = {
            {
                text = "  EXPLORER",
                fg = yellow,
                bg = get_hex("NvimTreeNormal", "bg"),
                style = "italic,bold"
            }
        }
    },
    components = {
        {
            text = function(buffer)
                if buffer.index ~= 1 then
                    return ""
                end
                return ""
            end,
            bg = function(buffer)
                if buffer.is_focused then
                    return highlight
                end
                return grey_bg
            end,
            fg = dark_bg
        },
        {
            text = " "
        },
        {
            text = function(buffer)
                if is_picking_focus() or is_picking_close() then
                    return buffer.pick_letter .. " "
                end

                return buffer.devicon.icon
            end,
            fg = function(buffer)
                if is_picking_focus() then
                    return yellow
                end
                if is_picking_close() then
                    return red
                end

                if buffer.is_focused then
                    return dark_bg
                else
                    return light_fg
                end
            end,
            style = function(_)
                return (is_picking_focus() or is_picking_close()) and "italic,bold" or nil
            end
        },
        {
            text = function(buffer)
                return buffer.unique_prefix .. buffer.filename .. "⠀"
            end,
            style = function(buffer)
                return buffer.is_focused and "bold" or nil
            end
        },
        {
            text = function(buffer)
                return (buffer.diagnostics.errors ~= 0 and '  ')
                        or (buffer.diagnostics.warnings ~= 0 and '  ')
                        or (buffer.diagnostics.infos ~= 0 and '  ')
                        or (buffer.diagnostics.hints ~= 0 and '  ')
                        or '   '
            end,
            fg = function(buffer)
                return (buffer.diagnostics.errors ~= 0 and errors_fg)
                        or (buffer.diagnostics.warnings ~= 0 and warnings_fg)
                        or (buffer.diagnostics.infos ~= 0 and infos_fg)
                        or (buffer.diagnostics.hints ~= 0 and hints_fg)
                        or nil
            end
        },
        {
            text = function(buffer)
                return buffer.is_modified and ' ●' or '  '
            end,
            fg = function(buffer)
                return buffer.is_modified and yellow or nil
            end
        },
        {
            text = "",
            fg = function(buffer)
                if buffer.is_focused then
                    return highlight
                end
                return grey_bg
            end,
            bg = dark_bg
        }
    }
}
