local status_ok, schemastore = pcall(require, "schemastore")
if not status_ok then
	vim.notify("Error loading schemastore!")
	return nil
end

M = {}

M.opts = {
	settings = {
		json = {
			schemas = schemastore.json.schemas(),
			validate = { enable = true }
		}
	},
	setup = {
		commands = {
			Format = {
				function()
					vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line("$"), 0 })
				end
			}
		}
	}
}

M.server = nil

return M
