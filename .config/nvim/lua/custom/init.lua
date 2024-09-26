vim.g.editorconfig = false

-- Function to create a new file in the current buffer's directory
local function create_file_in_current_buffer_path(filename)
    local current_dir = vim.fn.expand "%:p:h"
    local new_file_path = current_dir .. "/" .. filename
    vim.cmd(":e " .. new_file_path)
end

--Function to run gcli test
function gcli_test()
    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    local class_name = nil
    for _, line in ipairs(lines) do
        if not class_name then
            class_name = string.match(line, "class%s+([%w_]+)")
        end
        if class_name then
            break
        end
    end
    --open terminal in side-to-side mode
    vim.cmd "vsplit | terminal"
    local command = "gcli crawler test -s " .. class_name
    vim.fn.chansend(vim.b.terminal_job_id, command .. "\n")
end

-- Create a custom command to create a file
vim.api.nvim_create_user_command("CreateFile", function(args)
    create_file_in_current_buffer_path(args.args)
end, { nargs = 1 })

vim.api.nvim_create_user_command("ShowCurrentFilePath", function()
    print(vim.api.nvim_buf_get_name(0))
end, {})

vim.api.nvim_create_user_command("ShowParentFolder", function()
    print(vim.fn.expand "%:p:h")
end, {})
