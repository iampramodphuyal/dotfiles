local map = vim.keymap.set
map(
  "n",
  "<leader>pu",
  ":lua create_project_url()<CR>",
  { noremap = true, silent = true, desc = "Open grepsr pid directly in browser" }
)
map("n", "<leader>tt", ":GcliTest<CR>", { desc = "Run gcli test in current buffer" })