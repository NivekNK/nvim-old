local status_ok, sidebar = pcall(require, "sidebar-nvim")
if not status_ok then
	vim.notify("Error loading sidebar!")
	return
end

local custom_todos = require("user.sidebar.custom.todos")

sidebar.setup {
	disable_default_keybindings = 1,
	bindings = nil,
	open = false,
	side = "right",
	initial_width = 45,
	hide_statusline = false,
	update_interval = 1000,
	sections = { "datetime", custom_todos },
	section_separator = { "" },
	section_title_separator = { "" },
	datetime = { format = "%a %b %d" },
}
