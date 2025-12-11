require "nvchad.mappings"

local map = vim.keymap.set
map("n", "<leader>gl", ":Gitsigns toggle_current_line_blame<CR>", { desc = "Git blame on single line" })
map("n", "<leader>fl", ":ShowCurrentFilePath<CR>", { desc = "Show current file path" })
map("n", "<leader>fp", ":ShowParentFolder<CR>", { desc = "Show current file's parent path" })
map("n", "<leader>fj", ":%!jq .<CR>", { desc = "Format JSON with jq on current file" })

-- Tmux Integrated mapping below
map("n", "<C-h>", ":TmuxNavigateLeft<CR>", { desc = "Window Left" })
map("n", "<C-j>", ":TmuxNavigateDown<CR>", { desc = "Window Down" })
map("n", "<C-k>", ":TmuxNavigateUp<CR>", { desc = "Window Up" })
map("n", "<C-l>", ":TmuxNavigateRight<CR>", { desc = "Window Right" })
map("n", "[c", function()
    require("treesitter-context").go_to_context(vim.v.count1)
end, { silent = true })
