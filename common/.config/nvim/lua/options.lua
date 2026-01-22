require "nvchad.options"

local o = vim.o
o.clipboard = "unnamedplus"
o.cursorlineopt = "number"  -- Only highlight line number (faster than "both")
vim.opt.foldmethod = "indent"

-- Performance settings for faster navigation
o.timeoutlen = 300          -- Faster leader key sequences (default 1000)
o.ttimeoutlen = 10          -- Fast terminal key codes
o.updatetime = 250          -- Faster CursorHold events (default 4000)
o.lazyredraw = true         -- Don't redraw during macros/mappings
o.ttyfast = true            -- Faster terminal connection
