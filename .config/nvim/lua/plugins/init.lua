return {
    {
        dir = "~/Documents/projects/Winger.nvim",
        name = 'Winger',
        event = "VeryLazy",
        config = function()
            require("Winger").setup({
                basePath = '~/Documents/grepsr/'
            })
        end
    },
    {
        "iampramodphuyal/FTerminal.nvim",
        event = "VeryLazy",
        config = function()
            require("FTerminal").setup({
            })
        end,
        enabled = false
    },
    {
        "stevearc/conform.nvim",
        event = "BufWritePre", -- uncomment for format on save
        config = function()
            require "configs.conform"
        end,
    },
    {
        "mistricky/codesnap.nvim",
        build = "make",
        event = "VeryLazy"
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            require("nvchad.configs.lspconfig").defaults()
            require "configs.lspconfig"
        end,
        event = "VeryLazy"
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

    {
        "williamboman/mason.nvim",
        opts = {
            ensure_installed = {
                "lua-language-server",
                "stylua",
                "tsserver",
                "prettier"
            },
        },
        event = 'VeryLazy'
    },
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
        event = 'VeryLazy'
    },
}
