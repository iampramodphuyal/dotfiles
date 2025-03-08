-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v2.5/lua/nvconfig.lua

---@type ChadrcConfig

local M = {}
local customModules = require("custom.statuslineModules")
M.base46 = {
    theme = "catppuccin",
    hl_override = {
        Comment = { italic = true },
        ["@comment"] = { italic = true },
    },
    transparency = false,
}

M.ui = {
    cmp = {
        icons_left = false, -- only for non-atom styles!
        style = "default",  -- default/flat_light/flat_dark/atom/atom_colored
        abbr_maxwidth = 60,
        format_colors = {
            tailwind = false, -- will work for css lsp too
            icon = "󱓻",
        },
    },
    telescope = { style = "borderless" },
    statusline = {
        --theme = "default/vscode/vscode_colored/minimal"
        theme = "minimal",
        -- default/round/block/arrow separators work only for default statusline theme
        -- round and block will work for minimal theme only
        -- separator_style = "block",
        -- order = nil,
        -- order = { "mode","file", "git", "%=", "lsp_msg", 'file' }, -- Moves time to the end
        order = { "mode", "file", "git", "%=", "lsp_msg", "battery", "%=", "time", "diagnostics", "lsp", "cwd", "cursor" },
        modules = {
            time = customModules.time(),
            battery = customModules.battery()
        },
    },

    tabufline = {
        enabled = true,
        lazyload = true,
        order = { "treeOffset", "buffers", "tabs", "btns" },
        modules = nil,
        bufwidth = 21,
    },
}

M.nvdash = {
    load_on_startup = true,
    header = {
        [[                                                                       ]],
        [[                                                                     ]],
        [[       ████ ██████           █████      ██                     ]],
        [[      ███████████             █████                             ]],
        [[      █████████ ███████████████████ ███   ███████████   ]],
        [[     █████████  ███    █████████████ █████ ██████████████   ]],
        [[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
        [[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
        [[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
        [[                                                                       ]],
    }
}
return M
