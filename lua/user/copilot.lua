local status_ok, copilot = pcall(require, "copilot")
if not status_ok then
    return
end

local config = function()
    vim.defer_fn(function()
        copilot.setup {
            cmp = {
                enabled = true,
                method = "getPanelCompletions"
            },
            panel = { enabled = true },
            ft_disable = {},
            plugin_manager_path = vim.fn.stdpath("data") .. "/site/pack/packer",
            server_opts_overrides = {}
        }
    end)
end

return config

