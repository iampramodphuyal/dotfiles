vim.g.editorconfig = false

-- Function to create a new file in the current buffer's directory
local function create_file_in_current_buffer_path(filename)
    local current_dir = vim.fn.expand "%:p:h"
    local new_file_path = current_dir .. "/" .. filename
    vim.cmd(":e " .. new_file_path)
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

require("codesnap").setup({
    save_path = '~/Pictures/codesnap/',
    watermark = ""
})


function GenerateJSDoc()
    local row, _ = unpack(vim.api.nvim_win_get_cursor(0))
    local line = vim.api.nvim_buf_get_lines(0, row - 1, row, false)[1]

    -- Match function declarations and arrow functions
    local func_name = line:match("function%s+(%w+)") or line:match("const%s+(%w+)%s*=")
    local params, return_type = line:match("%((.-)%):%s*([%w%[%]<>]+)") -- Capture return type
    params = params or line:match("%((.-)%)")                           -- Fallback if no return type

    local param_list = {}
    if params then
        for param, type in params:gmatch("(%w+):%s*([%w%[%]<>]+)") do
            table.insert(param_list, " * @param {" .. type .. "} " .. param)
        end
    end

    local jsdoc = {
        "/**",
        " * " .. (func_name or ""),
        unpack(param_list),
        " * @return {" .. (return_type or "void") .. "}",
        " */"
    }

    -- Insert JSDoc above the function
    vim.api.nvim_buf_set_lines(0, row - 1, row - 1, false, jsdoc)
end

-- Map to a keybinding
vim.api.nvim_set_keymap("n", "<leader>dj", ":lua GenerateJSDoc()<CR>", { noremap = true, silent = true })
