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
local function hover_focusable()
  local params = vim.lsp.util.make_position_params(0, "utf-8")

  vim.lsp.buf_request(0, "textDocument/hover", params, function(err, result, _ctx, _)
    if err or not (result and result.contents) then
      vim.notify("No hover information", vim.log.levels.INFO)
      return
    end

    -- Modern way to format LSP markdown contents
    local markdown_lines = vim.lsp.util.convert_input_to_markdown_lines(result.contents) or {}
    markdown_lines = vim.lsp.util.trim_empty_lines(markdown_lines)
    -- Join the lines, then split and automatically trim empty leading/trailing lines
    markdown_lines = vim.split(table.concat(markdown_lines, "\n"), "\n", { trimempty = true })

    if vim.tbl_isempty(markdown_lines) then
      vim.notify("No hover content", vim.log.levels.INFO)
      return
    end

    -- open_floating_preview returns (bufnr, winnr)
    -- We pass focusable = true inside the configuration layout table
    local bufnr, winnr = vim.lsp.util.open_floating_preview(markdown_lines, "markdown", {
      border = "rounded",
      focusable = true,
      max_width = math.floor(vim.o.columns * 0.5),
    })

    -- Immediately jump the cursor into the newly opened floating window
    if winnr and vim.api.nvim_win_is_valid(winnr) then
      vim.api.nvim_set_current_win(winnr)

      -- Map 'q' and '<Esc>' inside the buffer to close the window safely
      local opts = { noremap = true, silent = true }
      map("n", "q", "<cmd>close<CR>", { buffer = bufnr, remap = false, silent = true })
      map("n", "<Esc>", "<cmd>close<CR>", { buffer = bufnr, remap = false, silent = true })
    end
  end)
end
-- Using the modern vim.keymap.set syntax (safer than global map)
vim.keymap.set("n", "K", hover_focusable, { noremap = true, silent = true })
map("n", "gi", vim.lsp.buf.implementation, {})
map("n", "gd", vim.lsp.buf.definition, {})
map("n", "gD", vim.lsp.buf.declaration, {})
map("n", "gr", vim.lsp.buf.references, {})
map("n", "<leader>rn", vim.lsp.buf.rename, {})
map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
vim.keymap.set("n", "<leader>q", ":wqa<CR>", { noremap = true, silent = true })
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

-- Normal mode: copy current line to system clipboard vim.keymap.set('n', '<y>', '"+yy', { noremap = true, silent = true })

-- Visual mode: copy selection to system clipboard
map("v", "<y>", '"+y', { noremap = true, silent = true })
map("i", "<C-n>", "<Plug>luasnip-next-choice", { silent = true })
map("s", "<C-n>", "<Plug>luasnip-next-choice", { silent = true })
map("i", "<C-p>", "<Plug>luasnip-prev-choice", { silent = true })
map("s", "<C-p>", "<Plug>luasnip-prev-choice", { silent = true })

map("n", "<leader>db", "<cmd> DapToggleBreakpoint <CR>", { desc = "Add breakpoint at line" })
map("n", "<leader>dr", "<cmd> DapContinue <CR>", { desc = "Start or continue the debugger" })
map("n", "do", "<cmd> DapStepOver <CR>", { desc = "Step over" })
map("n", "di", "<cmd> DapStepInto <CR>", { desc = "Step into" })
map("n", "dl", "<cmd> DapStepOut <CR>", { desc = "Step out" })
map("n", "<leader>dd", "<cmd> DapDisconnect <CR>", { desc = "Disconnect Dap" })
map("n", "<leader>dc", "<cmd> DapClearBreakPoints <CR>", { desc = "Step over" })

map("n", "zR", require("ufo").openAllFolds)
map("n", "zM", require("ufo").closeAllFolds)
map("n", "zr", require("ufo").openFoldsExceptKinds)
map("n", "zm", require("ufo").closeFoldsWith) -- closeAllFolds == closeFoldsWith(0)
-- map("n", "K", function()
--   local winid = require("ufo").peekFoldedLinesUnderCursor()
--   if not winid then
--     -- choose one of coc.nvim and nvim lsp
--     vim.fn.CocActionAsync "definitionHover" -- coc.nvim
--   end
-- end)
--
-- tăng/giảm chiều cao
map("n", "<C-Up>", ":resize -2<CR>")
map("n", "<C-Down>", ":resize +2<CR>")

-- tăng/giảm chiều rộng
map("n", "<C-Right>", ":vertical resize -2<CR>")
map("n", "<C-Left>", ":vertical resize +2<CR>")
vim.keymap.set("n", "<leader>ne", function()
  vim.diagnostic.jump { count = 1, float = true }
end, { desc = "Next diagnostic" })

-- Go to PREVIOUS diagnostic (All severities)
vim.keymap.set("n", "<leader>pe", function()
  vim.diagnostic.jump { count = -1, float = true }
end, { desc = "Previous diagnostic" })

-- OPTIONAL: Jump ONLY to hard Errors (skips warnings/hints)
vim.keymap.set("n", "]e", function()
  vim.diagnostic.jump { count = 1, severity = vim.diagnostic.severity.ERROR, float = true }
end, { desc = "Next Error only" })

vim.keymap.set("n", "[e", function()
  vim.diagnostic.jump { count = -1, severity = vim.diagnostic.severity.ERROR, float = true }
end, { desc = "Previous Error only" })
