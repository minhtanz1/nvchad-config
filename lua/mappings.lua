require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set
local opts = { noremap = true, silent = true }
map("i", "<C-s>", "<esc><cmd>w<cr>i")

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
-- Move line up
map("n", "<A-Up>", ":m .-2<CR>==", opts)
map("i", "<A-Up>", "<Esc>:m .-2<CR>==gi", opts)
map("v", "<A-Up>", ":m '<-2<CR>gv=gv", opts)

-- Move line down
map("n", "<A-Down>", ":m .+1<CR>==", opts)
map("i", "<A-Down>", "<Esc>:m .+1<CR>==gi", opts)
map("v", "<A-Down>", ":m '>+1<CR>gv=gv", opts)

map("n", "<leader>v", "<esc><cmd>VimtexView<cr>", { desc = "Vimtex view file pdf" })
map("n", "K", vim.lsp.buf.hover, {})
map("n", "gi", vim.lsp.buf.implementation, {})
map("n", "gd", vim.lsp.buf.definition, {})
map("n", "gD", vim.lsp.buf.declaration, {})
map("n", "gr", vim.lsp.buf.references, {})
map("n", "<leader>rn", vim.lsp.buf.rename, {})
map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
-- list all methods in a file
-- working with go confirmed, don't know about other, keep changing as necessary
map("n", "<leader>sm", function()
  local filetype = vim.bo.filetype
  local symbols_map = {
    python = "function",
    javascript = "function",
    typescript = "function",
    java = "class",
    lua = "function",
    go = { "method", "struct", "interface" },
  }
  local symbols = symbols_map[filetype] or "function"
  require("fzf-lua").lsp_document_symbols { symbols = symbols }
end, {})
