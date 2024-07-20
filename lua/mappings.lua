require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("i", "<C-s>", "<esc><cmd>w<cr>i")

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
