local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
	vim.notify("nvim-tree not found!")
	return
end

local utils = require("nvim-tree.utils")
local events = require("nvim-tree.events")
local lib = require("nvim-tree.lib")
local core = require("nvim-tree.core")

local function create_file(file)
	if utils.file_exists(file) then
		print(file .. " already exists. Overwrite? y/n")
		local ans = utils.get_user_input_char()
		utils.clear_prompt()
		if ans ~= "y" then
			return
		end
	end

	local ok, fd = pcall(vim.loop.fs_open, file, "w", 420)
	if not ok then
		vim.api.nvim_err_writeln("Couldn't create file " .. file)
		return
	end

    if fd == nil then
        vim.api.nvim_err_writeln("Couldn't create file " .. file)
        return
    end

	vim.loop.fs_close(fd)
	events._dispatch_file_created(file)
end

local function get_containing_folder(node)
	local is_open = M.create_in_closed_folder or node.open
	if node.nodes ~= nil and is_open then
		return utils.path_add_trailing(node.absolute_path)
	end
	local node_name_size = #(node.name or "")
	return node.absolute_path:sub(0, -node_name_size - 1)
end

local function get_num_nodes(iter)
	local i = 0
	for _ in iter do
		i = i + 1
	end
	return i
end

local function focus_file(file)
	local _, i = utils.find_node(core.get_explorer().nodes, function(node)
		return node.absolute_path == file
	end)
	require("nvim-tree.view").set_cursor({ i + 1, 1 })
end

local fn = {
	create_book = function(node)
		node = lib.get_last_group_node(node)
		if node.name == ".." then
			node = {
				absolute_path = core.get_cwd(),
				nodes = core.get_explorer().nodes,
				open = true,
			}
		end

        local containing_folder = get_containing_folder(node)
		local new_file_path = containing_folder .. os.date("%d-%m-%y") .. ".md"

        if not new_file_path or new_file_path == containing_folder then
			return
		end

		utils.clear_prompt()

		if utils.file_exists(new_file_path) then
			utils.warn("Cannot create: file already exists")
			return
		end

		-- create a folder for each path element if the folder does not exist
		-- if the answer ends with a /, create a file for the last path element
		local is_last_path_file = not new_file_path:match(utils.path_separator .. "$")
		local path_to_create = ""
		local idx = 0

		local num_nodes = get_num_nodes(utils.path_split(utils.path_remove_trailing(new_file_path)))
		local is_error = false
		for path in utils.path_split(new_file_path) do
			idx = idx + 1
			local p = utils.path_remove_trailing(path)
			if #path_to_create == 0 and vim.fn.has("win32") == 1 then
				path_to_create = utils.path_join({ p, path_to_create })
			else
				path_to_create = utils.path_join({ path_to_create, p })
			end
			if is_last_path_file and idx == num_nodes then
				create_file(path_to_create)
			elseif not utils.file_exists(path_to_create) then
				local success = vim.loop.fs_mkdir(path_to_create, 493)
				if not success then
					vim.api.nvim_err_writeln("Could not create folder " .. path_to_create)
					is_error = true
					break
				end
			end
		end
		if not is_error then
			vim.api.nvim_out_write(new_file_path .. " was properly created\n")
		end
		events._dispatch_folder_created(new_file_path)
		require("nvim-tree.actions.reloaders").reload_explorer()
		-- INFO: defer needed when reload is automatic (watchers)
		vim.defer_fn(function()
			focus_file(new_file_path)
		end, 50)
	end,
}

nvim_tree.setup({
	disable_netrw = true,
	hijack_netrw = true,
	open_on_setup = false,
	ignore_ft_on_setup = { "startify", "dashboard", "alpha" },
	open_on_tab = false,
	hijack_cursor = false,
	update_cwd = true,
	hijack_directories = {
		enable = true,
		auto_open = true,
	},
	diagnostics = {
		enable = true,
		icons = {
			hint = "",
			info = "",
			warning = "",
			error = "",
		},
	},
	update_focused_file = {
		enable = true,
		update_cwd = true,
		ignore_list = {},
	},
	git = {
		enable = true,
		ignore = true,
		timeout = 500,
	},
	view = {
		width = 30,
		height = 30,
		hide_root_folder = false,
		side = "left",
		mappings = {
			custom_only = false,
			list = require("user.keymaps").nvim_tree_keymaps(fn),
		},
		number = false,
		relativenumber = false,
	},
	actions = {
		open_file = {
			quit_on_open = false,
			resize_window = true,
			window_picker = {
				enable = true,
			},
		},
	},
	renderer = {
		root_folder_modifier = ":t",
		icons = {
			webdev_colors = true,
			show = {
				git = true,
				folder = true,
				file = true,
				folder_arrow = true,
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
					ignored = "◌",
				},
				folder = {
					default = "",
					open = "",
					empty = "",
					empty_open = "",
					symlink = "",
				},
			},
		},
		special_files = {
			"Cargo.toml",
			"Makefile",
			"README.md",
			"readme.md",
		},
	},
})
