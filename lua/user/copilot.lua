local status_ok, copilot = pcall(require, "copilot")
if not status_ok then
	vim.notify("Error loading copilot!")
	return
end

copilot.setup {
	cmp = {
		enabled = true,
		method = "getPanelCompletions",
	},
	panel = {
		enabled = true,
	},
	ft_disable = { "markdown" },
	plugin_manager_path = vim.fn.stdpath("data") .. "/site/pack/packer",
	server_opts_overrides = {
        trace = "verbose",
        settings = {
            advanced = {
                listCount = 10,
                inlineSuggestCount = 3
            }
        }
    }
}
