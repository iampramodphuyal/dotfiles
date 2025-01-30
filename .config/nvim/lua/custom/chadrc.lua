local M = {}

M.options = {
    tabstop = 4,
    shiftwidth = 4,
    expandtab = true,
    foldmethod = "indent",
    foldenable = true,
    autoindent = true,
    smartindent = true,
    clipboard = "unnamedplus",
}

M.nvdash = {
    load_on_startup = true,
}
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "py", "php", "js", "lua", "ts", "json" },
    callback = function()
        vim.opt.tabstop = M.options.tabstop
        vim.opt.shiftwidth = M.options.shiftwidth
        vim.opt.expandtab = M.options.expandtab
        vim.opt.foldmethod = M.options.foldmethod
        vim.opt.autoindent = M.options.autoindent
        vim.opt.smartindent = M.options.smartindent
        vim.opt.clipboard = M.options.clipboard
    end,
})

return M
