require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

map({ "n", "t" }, "<A-i>", function()
    require("nvchad.term").toggle {
        pos = "float",
        id = "floatTerm",
        float_opts = {
            row = 0.001,
            col = 0.001,
            width = 0.98,
            height = 0.90,
            style = "minimal",
            border = "rounded",
        },
    }
end, { desc = "Floating term" })
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
