require "nvchad.mappings"

local map = vim.keymap.set
map("n", "<leader>gl", ":Gitsigns toggle_current_line_blame<CR>", { desc = "Git blame on single line" })
map("n", "<leader>fl", ":ShowCurrentFilePath<CR>", { desc = "Show current file path" })
map("n", "<leader>fp", ":ShowParentFolder<CR>", { desc = "Show current file's parent path" })

