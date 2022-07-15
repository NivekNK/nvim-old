local status_ok, dap = pcall(require, "dap")
if not status_ok then
    vim.notify("Error loading dap!")
    return
end

vim.fn.sign_define("DapBreakpoint", { text = "ß", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapBreakpointCondition", { text = "ü", texthl = "", linehl = "", numhl = "" })
-- Setup cool Among Us as avatar
vim.fn.sign_define("DapStopped", { text = "ඞ", texthl = "Error" })

require("user.dap.extensions.virtual-text")
require("user.dap.extensions.dapui").setup(dap)
require("user.dap.extensions.telescope")

require("user.dap.languages.cpp")
