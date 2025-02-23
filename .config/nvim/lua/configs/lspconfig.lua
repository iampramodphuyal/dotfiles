-- EXAMPLE
local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
local servers = { "pyright" }
-- lsps with default config
for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup {
        on_attach = on_attach,
        on_init = on_init,
        capabilities = capabilities,
    }
end

-- For php intelephense, php
lspconfig.intelephense.setup {
    filetypes = { "php" },
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
}

-- setup for c++
lspconfig.clangd.setup {
    filetypes = { "cpp", 'h' },
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
}

--setup for golang
lspconfig.gopls.setup {
    filetypes = { 'go', 'gomod' },
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities
}

-- typescript
lspconfig.ts_ls.setup {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
    filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
    cmd = { "typescript-language-server", "--stdio" }
}
