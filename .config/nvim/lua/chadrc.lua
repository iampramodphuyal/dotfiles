-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v2.5/lua/nvconfig.lua

-- -@type ChadrcConfig
local M = {}

M.ui = {
    theme = "catppuccin",
    statusline = {
        --theme = "default",
        --theme = "default/vscode/vscode_colored/minimal"
        theme = "minimal",
        -- default/round/block/arrow separators work only for default statusline theme
        -- round and block will work for minimal theme only
        --  separator_style = "default",
        separator_style = "round",
        order = nil,
        modules = nil,
    },
    hl_override = {
        Comment = { italic = true },
        ["@comment"] = { italic = true },
    },
    nvdash = {
        load_on_startup = true,

        -- header = {
        --   "                            ",
        --   "     ▄▄         ▄ ▄▄▄▄▄▄▄   ",
        --   "   ▄▀███▄     ▄██ █████▀    ",
        --   "   ██▄▀███▄   ███           ",
        --   "   ███  ▀███▄ ███           ",
        --   "   ███    ▀██ ███           ",
        --   "   ███      ▀ ███           ",
        --   "   ▀██ █████▄▀█▀▄██████▄    ",
        --   "     ▀ ▀▀▀▀▀▀▀ ▀▀▀▀▀▀▀▀▀▀   ",
        --   "                            ",
        --   "     Powered By  eovim    ",
        --   "                            ",
        -- },
        --
        -- buttons = {
        --   { txt = "  Find File", keys = "Spc f f", cmd = "Telescope find_files" },
        --   { txt = "  Recent Files", keys = "Spc f o", cmd = "Telescope oldfiles" },
        --   -- more... check nvconfig.lua file for full list of buttons
    },
}

M.plugins = {
    status = {
        dashboard = true,
    },
}
return M
