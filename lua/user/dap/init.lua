local status_ok, dap = pcall(require, "dap")
if not status_ok then
	vim.notify("Error loading dap!")
	return
end

vim.fn.sign_define("DapBreakpoint", { text = "⚪", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapBreakpointCondition", { text = "🔵", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapBreakpointRejected", { text = "R", texthl = "Error", linehl = "", numhl = "" })
vim.fn.sign_define("DapLogPoint", { text = "🗨", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapStopped", { text = "", texthl = "Error" })

require("user.dap.extensions.virtual-text")
require("user.dap.extensions.dapui").setup(dap)
require("user.dap.extensions.telescope")

require("user.dap.languages.cpp")
require("user.dap.languages.cs")
