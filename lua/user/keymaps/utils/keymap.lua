-- From: https://www.reddit.com/r/neovim/comments/rltfgz/using_inline_functions_with_nvim_set_keymap/

_G.__KeymapStore = _G.__KeymapStore or {}
local K = {}

---Keymap factory
---@param mode string
---@param defaults table
local make_mapper = function(mode, defaults)
	---@param lhs string
	---@param rhs string|function
	---@param opts? table
	return function(lhs, rhs, opts)
		opts = vim.tbl_extend("keep", defaults, opts or {})
		local buffer = opts.buffer
		opts.buffer = nil

		rhs = K(tostring(buffer or 0), mode):_make_rhs(rhs, opts)
		if rhs then
			if buffer then
				vim.api.nvim_buf_set_keymap(buffer, mode, lhs, rhs, opts)
			else
				vim.api.nvim_set_keymap(mode, lhs, rhs, opts)
			end
		end
	end
end

local M = {
	nmap = make_mapper("n", { noremap = true, silent = true }),
    nsmap = make_mapper("n", { silent = true }),

	imap = make_mapper("i", { noremap = true, silent = true }),
    ismap = make_mapper("i", { silent = true }),

	vmap = make_mapper("v", { noremap = true, silent = true }),
    vsmap = make_mapper("v", { silent = true }),

	tmap = make_mapper("t", { noremap = true, silent = true }),
    tsmap = make_mapper("t", { silent = true }),

	smap = make_mapper("s", { noremap = true, silent = true }),
    ssmap = make_mapper("s", { silent = true }),

	xmap = make_mapper("x", { noremap = true, silent = true }),
    xsmap = make_mapper("x", { silent = true }),

	omap = make_mapper("o", { noremap = true, silent = true }),
    osmap = make_mapper("o", { silent = true }),

	lmap = make_mapper("l", { noremap = true, silent = true }),
    lsmap = make_mapper("l", { silent = true }),

	cmap = make_mapper("c", { noremap = true, silent = true }),
    csmap = make_mapper("c", { silent = true }),

	termcodes = function(key)
		return vim.api.nvim_replace_termcodes(key, true, true, true)
	end,
}

return setmetatable(K, {
	__index = function(_, key)
		return M[key]
	end,

	__call = function(_, buffer)
		__KeymapStore[buffer] = __KeymapStore[buffer] or {}
		local idx = vim.tbl_count(__KeymapStore[buffer]) + 1

		local _insert = function(rhs)
			if rawget(__KeymapStore[buffer], idx) then
				print(("mapping for { idx = '%s', buffer = %s\n } already exists!\n"):format(idx, buffer))
				return false
			end
			return rawset(__KeymapStore[buffer], idx, rhs) and true or false
		end

		local _lua_fn = function()
			return ([[<cmd>lua require("user.keymaps.utils.keymap")(%q).exec(%d)<cr>]]):format(buffer, idx)
		end

		local _vim_expr = function()
			return ([[luaeval('require("user.keymaps.utils.keymap")(%q).exec(%d)')]]):format(buffer, idx)
		end

		return {
			_make_rhs = function(_, rhs, opts)
				if _insert(rhs) then
					if type(rhs) == "function" then
						rhs = opts.expr and _vim_expr() or _lua_fn()
					end
					return rhs
				end
				return nil
			end,

			exec = function(_idx)
				local r = __KeymapStore[buffer][_idx]()
				if type(r) == "string" then
					return vim.api.nvim_eval(K.termcodes(r))
				end
			end,
		}
	end,
})
