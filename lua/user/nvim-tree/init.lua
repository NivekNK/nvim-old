local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
	vim.notify("Error loading nvim-tree!")
	return
end

nvim_tree.setup {
	disable_netrw = true,
	hijack_netrw = true,
	open_on_setup = false,
	ignore_ft_on_setup = { "startify", "dashboard", "alpha" },
	open_on_tab = false,
	hijack_cursor = false,
	update_cwd = true,
	hijack_directories = {
		enable = true,
		auto_open = true
	},
	diagnostics = {
		enable = true,
		icons = {
			hint = "",
			info = "",
			warning = "",
			error = ""
		}
	},
	update_focused_file = {
		enable = true,
		update_cwd = true,
		ignore_list = {}
	},
	git = {
		enable = true,
		ignore = true,
		timeout = 500
	},
	view = {
		width = 30,
		height = 30,
		hide_root_folder = false,
		side = "left",
		mappings = {
			custom_only = false,
			list = require("user.nvim-tree.keymaps")
		},
		number = false,
		relativenumber = false
	},
	actions = {
		open_file = {
			quit_on_open = false,
			resize_window = true,
			window_picker = {
				enable = true
			}
		}
	},
	renderer = {
		root_folder_modifier = ":t",
		icons = {
			webdev_colors = true,
			show = {
				git = true,
				folder = true,
				file = true,
				folder_arrow = true
			},
			glyphs = {
				default = "",
				symlink = "",
				git = {
					unstaged = "",
					staged = "S",
					unmerged = "",
					renamed = "➜",
					deleted = "",
					untracked = "U",
					ignored = "◌"
				},
				folder = {
					default = "",
					open = "",
					empty = "",
					empty_open = "",
					symlink = ""
				}
			}
		},
		special_files = {
			"Cargo.toml",
			"Makefile",
			"README.md",
			"readme.md"
		}
	}
}
