local status_ok, dap = pcall(require, "dap")
if not status_ok then
	vim.notify("Error loading dap!")
	return
end

vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "Error", linehl = "", numhl = "" })
vim.fn.sign_define("DapBreakpointCondition", { text = "ﳂ", texthl = "Error", linehl = "", numhl = "" })
vim.fn.sign_define("DapBreakpointRejected", { text = "R", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapLogPoint", { text = "L", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapStopped", { text = "", texthl = "Error" })

require("user.dap.extensions.virtual-text")
require("user.dap.extensions.dapui").setup(dap)
require("user.dap.extensions.telescope")

require("user.dap.languages.cpp")
