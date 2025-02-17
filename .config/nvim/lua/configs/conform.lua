local options = {
    formatters_by_ft = {
        lua = { "stylua" },
        css = { "prettier" },
        html = { "prettier" },
        json = { "prettier" },
        javascript = { "prettier" },
        typescript = { "prettier" },
        ts = { "prettier" },
        go = { "gopls" },
    },
    formatters = {
        prettier = {
            command = "prettier",
            arg = function()
                return {
                    "--stdin-filepath",
                    vim.api.nvim_buf_get_name(0),
                    "--tab-width",
                    "4",
                }
            end,
            stdin = true,
        },
    },

    format_on_save = {
        -- These options will be passed to conform.format()
        timeout_ms = 500,
        lsp_fallback = true,
    },
}

require("conform").setup(options)
