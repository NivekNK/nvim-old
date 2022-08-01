local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics

local clang_format = "-style=file:" .. vim.fn.stdpath("config") .. "/vendor/formatting/.clang-format"

null_ls.setup {
	debug = false,
	sources = {
		formatting.prettier.with({ extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" } }),
		formatting.stylua,
        formatting.rustfmt,
        formatting.clang_format.with({ extra_args = { clang_format } }),
        diagnostics.cppcheck.with({ extra_args = { "--std" } })
	}
}
