return {
    {
        "stevearc/conform.nvim",
        event = "BufWritePre", -- uncomment for format on save
        config = function()
            require "configs.conform"
        end,
    },
    -- {

    -- }
    -- These are some examples, uncomment them if you want to see them work!
    {
        "neovim/nvim-lspconfig",
        config = function()
            require("nvchad.configs.lspconfig").defaults()
            require "configs.lspconfig"
        end,
    },
    {
        "voldikss/vim-floaterm",
        lazy = false,
        enabled = false,
    },
    {
        "APZelos/blamer.nvim",
        enabled = false,
    },
    {
        "L3MON4D3/LuaSnip",
        enabled = true,
        -- follow latest release.
        version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
        -- install jsregexp (optional!).
        build = "make install_jsregexp",
    },
    {
        "rmagatti/auto-session",
        dependencies = {
            "nvim-telescope/telescope.nvim", -- Only needed if you want to use sesssion lens
        },
        config = function()
            require("auto-session").setup {
                auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
                auto_session_enable_last_session = true,
            }
        end,
        enabled = false,
        lazy = true,
    },
    --
    -- {
    --     "williamboman/mason.nvim",
    --     opts = {
    --         ensure_installed = {
    --             "lua-language-server",
    --             "stylua",
    --             -- "tsserver",
    --             -- "html-lsp", "css-lsp" , "prettier"
    --         },
    --     },
    -- },
    --
    {
        "nvim-treesitter/nvim-treesitter",
        opts = {
            ensure_installed = {
                "vim",
                "lua",
                "vimdoc",
                "javascript",
                "php",
                -- "html",
                -- "css",
            },
        },
    },
}
