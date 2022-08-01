local status_ok, cmake = pcall(require, "cmake")
if not status_ok then
    vim.notify("Error loading cmake!")
    return
end

local plenary_status_ok, Path = pcall(require, "plenary.path")
if not plenary_status_ok then
    vim.notify("Error loading plenary.path in cmake!")
    return
end

cmake.setup {
    cmake_executable = 'cmake', -- CMake executable to run.
    save_before_build = true, -- Save all buffers before building.
    parameters_file = 'nvim-cmake-config.json', -- JSON file to store information about selected target, run arguments and build type.
    build_dir = tostring(Path:new('{cwd}', 'out/build', '{os}-{build_type}')), -- Build directory. The expressions `{cwd}`, `{os}` and `{build_type}` will be expanded with the corresponding text values. Could be a function that return the path to the build directory.
    configure_args = { '-D', 'CMAKE_EXPORT_COMPILE_COMMANDS=1', "-G Ninja" }, -- Default arguments that will be always passed at cmake configure step. By default tells cmake to generate `compile_commands.json`.
    build_args = {}, -- Default arguments that will be always passed at cmake build step.
    on_build_output = nil, -- Callback that will be called each time data is received by the current process. Accepts the received data as an argument.
    quickfix = {
        pos = 'botright', -- Where to open quickfix
        height = 10, -- Height of the opened quickfix.
        only_on_error = false, -- Open quickfix window only if target build failed.
    },
    copy_compile_commands = true, -- Copy compile_commands.json to current working directory.
    dap_configuration = { type = 'lldb', request = 'launch' }, -- DAP configuration. By default configured to work with `lldb-vscode`.
    dap_open_command = require('dap').repl.open, -- Command to run after starting DAP session. You can set it to `false` if you don't want to open anything or `require('dapui').open` if you are using https://github.com/rcarriga/nvim-dap-ui
}

local ProjectConfig = require('cmake.project_config')

vim.api.nvim_create_user_command("CMakeSimpleRun", function()
    local project_config = ProjectConfig.new()
    local target_dir, target, _ = project_config:get_current_target()
    if not target_dir or not target then
        return
    end
    local target_path = target.filename
    local path =  "." .. target_path:sub(
        string.len(vim.loop.cwd()) + 1,
        string.len(target_path)
    )
    vim.notify("Running: " .. path)
    vim.cmd("terminal " .. path)
end, {})
