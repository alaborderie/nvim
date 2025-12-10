-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- neotest
vim.keymap.set("n", "<leader>tn", function()
  require("neotest").run.run(vim.fn.expand("%"))
end, { desc = "Run test file (neotest)" })
vim.keymap.set("n", "<leader>tN", function()
  require("neotest").run.run()
end, { desc = "Run nearest test (neotest)" })
vim.keymap.set("n", "<leader>tm", function()
  require("neotest").run.run(vim.fn.getcwd())
end, { desc = "Run all tests (neotest)" })
vim.keymap.set("n", "<leader>tM", function()
  require("neotest").run.run({ suite = true })
end, { desc = "Run whole test suite (neotest)" })
vim.keymap.set("n", "<leader>tD", function()
  require("neotest").run.run({ suite = false, strategy = "dap" })
end, { desc = "Debug test file (neotest)" })
vim.keymap.set("n", "<leader>td", function()
  require("neotest").run.run({ vim.fn.expand("%"), suite = false, strategy = "dap" })
end, { desc = "Debug nearest test (neotest)" })
