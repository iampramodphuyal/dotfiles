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

vim.opt.clipboard = M.options.clipboard -- global option; set once, not per-filetype
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "python", "php", "javascript", "lua", "typescript", "json", "go" },
    callback = function()
        vim.opt_local.tabstop = M.options.tabstop
        vim.opt_local.shiftwidth = M.options.shiftwidth
        vim.opt_local.expandtab = M.options.expandtab
        vim.opt_local.foldmethod = M.options.foldmethod
        vim.opt_local.autoindent = M.options.autoindent
        vim.opt_local.smartindent = M.options.smartindent
    end,
})

return M
