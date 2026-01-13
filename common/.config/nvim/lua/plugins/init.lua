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
            indent = { enabled = true },
            input = { enabled = true },
            picker = { enabled = true },
            notifier = { enabled = true },
            quickfile = { enabled = true },
            scope = { enabled = true },
            scroll = { enabled = true },
            statuscolumn = { enabled = true },
            words = { enabled = true },
        },
    },
    {
        "coder/claudecode.nvim",
        dependencies = { "folke/snacks.nvim" },
        config = true,
        keys = {
            { "<leader>ac", "<cmd>ClaudeCode<cr>",           desc = "Toggle Claude" },
            { "<leader>as", "<cmd>ClaudeCodeSend<cr>",       mode = "v",            desc = "Send to Claude" },
            { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
            { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>",   desc = "Deny diff" },
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
        "Exafunction/windsurf.vim",
        event = "VeryLazy",
        enabled = false
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
        "williamboman/mason.nvim",
        opts = {
            ensure_installed = {
                "lua-language-server",
                "stylua",
                "tsserver",
                "prettier",
                "pyright"
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
                "html",
                "css",
                "go",
                "python"
            },
        },
        event = 'VeryLazy'
    },
}
