vim.g.editorconfig = false

function StartServer()
    vim.cmd "luafile /server.lua"
end

-- Create a command to start the server
vim.api.nvim_create_user_command("StartServer", StartServer, {})
function toogleFloatTerm()
    require("nvchad.term").toggle {
        pos = "float",
        id = "floatTerm",
        float_opts = {
            row = 0.001,
            col = 0.001,
            width = 0.98,
            height = 0.90,
            border = "single",
        },
    }
end
--Function to run gcli test
function gcli_test()
    local path = vim.fn.substitute(vim.fn.expand "%", "vortex_\\w\\+/", "", "")
    if path ~= nil or path ~= "" then
        print("filepath:: " .. path)
        local fileName = vim.split(path, "/")[2]
        local command = "gcli crawler test -s " .. fileName
        require("nvchad.term").toggle {
            pos = "float",
            cmd = command,
            id = "floatTerm",
            clear_cmd = true,
            float_opts = {
                row = 0.001,
                col = 0.001,
                width = 0.98,
                height = 0.90,
                border = "single",
            },
        }
    else
        print "Error Getting filepath"
    end
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

function gcli_deploy(msg)
    local path = vim.fn.substitute(vim.fn.expand "%", "vortex_\\w\\+/", "", "")
    local fileName = vim.split(path, "/")[2]
    local command = "gcli crawler deploy -s " .. fileName .. " -m '" .. msg .. "'"
    require("nvchad.term").toggle {
        pos = "float",
        cmd = command,
        id = "floatTerm",
        clear_cmd = true,
        float_opts = {
            row = 0.001,
            col = 0.001,
            width = 0.98,
            height = 0.90,
            border = "single",
        },
    }
end

vim.api.nvim_create_user_command("PID", function()
    create_project_url()
end, {})

vim.api.nvim_create_user_command("GcliTest", function()
    gcli_test()
end, {})

vim.api.nvim_create_user_command("GcliDeploy", function()
    local msg = vim.fn.input "Deploy Message: "
    if msg == "" then
        print "Error: no message provided"
    else
        gcli_deploy(msg)
    end
end, {})

--This will generate php syntax for setHeaders from curl in clipboard
local function get_headers()
    local clipboard = vim.fn.getreg "+"

    if clipboard:match "^curl" then
        local headers = {}
        for header in clipboard:gmatch "-H '([^']+)'" do
            local key, value = header:match "([^:]+):%s*(.*)"
            if key and value then
                table.insert(headers, string.format("$this->setHeaders('%s', '%s');", key, value))
            end
        end
        -- local result = table.concat(headers, "\n")
        vim.api.nvim_put(headers, "l", true, true)
    else
        print "No Valid Curl Found In Clipboard"
    end
end

vim.api.nvim_create_user_command("GetHeaders", function()
    get_headers()
end, {})
