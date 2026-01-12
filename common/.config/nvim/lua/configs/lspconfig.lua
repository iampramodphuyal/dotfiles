-- EXAMPLE
local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local servers = { "pyright" }
-- lsps with default config
vim.lsp.config('*', {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
})

vim.lsp.enable(servers)
-- For php intelephense, php
-- vim.lsp.config.intelephense {
--     filetypes = { "php" },
--     on_attach = on_attach,
--     on_init = on_init,
--     capabilities = capabilities,
-- }

-- setup for c++
-- vim.lsp.config.clangd {
--     filetypes = { "cpp", 'h' },
--     on_attach = on_attach,
--     on_init = on_init,
--     capabilities = capabilities,
-- }

--setup for golang
vim.lsp.config.gopls {
    filetypes = { 'go', 'gomod' },
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities
}

-- typescript
vim.lsp.config.ts_ls {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
    filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
    cmd = { "typescript-language-server", "--stdio" }
}

-- python
vim.lsp.config.pyright({
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = { "python" }
})
