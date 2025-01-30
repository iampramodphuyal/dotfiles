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


vim.opt.runtimepath:append(vim.fn.expand("~/Documents/projects/nvwing/"))

require("codesnap").setup({
    save_path = '~/Pictures/codesnap/',
    watermark = ""
})
