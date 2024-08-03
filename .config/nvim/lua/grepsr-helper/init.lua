vim.g.editorconfig = false

function StartServer()
    vim.cmd "luafile /server.lua"
end

-- Create a command to start the server
vim.api.nvim_create_user_command("StartServer", StartServer, {})

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

-- Function to extract PID and create URL
function create_project_url()
    -- Get all lines in the current buffer
    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    local pid = nil
    local class_name = nil
    -- Loop through all lines to find PID and class name
    for _, line in ipairs(lines) do
        if not pid then
            pid = string.match(line, "PID:%s*(%d+)")
        end
        if not class_name then
            class_name = string.match(line, "class%s+([%w_]+)")
        end
        -- Exit loop if both PID and class name are found
        if pid and class_name then
            break
        end
    end

    -- Base URL
    local base_url = "https://platform.grepsr.com/projects"
    local url = ""
    if pid then
        -- Create URL with project number
        url = base_url .. "/" .. pid
    else
        -- Create URL with search query
        url = base_url .. "?page=1&q=" .. class_name .. "&view=list&filterType=all"
    end

    -- Print URL for debugging purposes
    print("Generated URL: " .. url)

    -- Open the URL in the default web browser
    if vim.fn.has "mac" == 1 then
        os.execute("open " .. url)
    elseif vim.fn.has "unix" == 1 then
        os.execute("xdg-open " .. url)
    elseif vim.fn.has "win32" == 1 then
        os.execute("start " .. url)
    else
        print "Unsupported system for opening URLs"
    end
end

vim.api.nvim_create_user_command("PID", function()
    create_project_url()
end, {})

vim.api.nvim_create_user_command("GcliTest", function()
    gcli_test()
end, {})
