return {
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        ---@type snacks.Config
        opts = {
            bigfile = { enabled = true },
            dashboard = { enabled = false },
            explorer = { enabled = false },
            indent = { enabled = true, animate = { enabled = false } }, -- guides yes, animation is the lag
            input = { enabled = true },
            picker = { enabled = true },
            notifier = { enabled = true },
            quickfile = { enabled = true },
            scope = { enabled = false }, -- per-CursorMoved recompute; redundant with indent scope
            scroll = { enabled = false }, -- 200ms animated scroll = the main "laggy" feel
            statuscolumn = { enabled = true },
            words = { enabled = false }, -- per-cursor-move LSP doc-highlight requests
        },
    },
    {
        "lewis6991/gitsigns.nvim",
        opts = {
            diff_opts = {
                internal = true,
                algorithm = "histogram", -- "minimal" is faster
            },
        }
    },
    {
        "christoomey/vim-tmux-navigator",
        lazy = false
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
        "iampramodphuyal/MyCodeTime.nvim",
        event = "VeryLazy",
        config = function()
            require "MyCodeTime"
        end
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
        "nvim-treesitter/nvim-treesitter",
        branch = "main", -- NvChad v2.5 uses the main-branch API; master is frozen
        opts = {
            ensure_installed = {
                "vim",
                "lua",
                "vimdoc",
                "javascript",
                "php",
                "html",
                "css",
                "go",
                "python"
            },
        },
    },
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        dependencies = { "williamboman/mason.nvim" },
        event = "VeryLazy",
        opts = {
            ensure_installed = {
                "lua-language-server",
                "stylua",
                "typescript-language-server",
                "prettier",
                "pyright",
            },
        },
    },
    {
        "nvim-tree/nvim-tree.lua",
        opts = {
            git = {
                ignore = false,
            },
        },
    },
}
