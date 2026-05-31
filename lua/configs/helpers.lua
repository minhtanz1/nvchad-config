vim.keymap.set("n", "<leader>ce", function()
  -- Get the current cursor position (line is 0-indexed, col is 0-indexed)
  local line = vim.fn.line "." - 1
  local col = vim.fn.col "." - 1

  -- Get all diagnostics on the current line
  local diagnostics = vim.diagnostic.get(0, { lnum = line })
  if #diagnostics == 0 then
    print "No diagnostic at cursor"
    return
  end

  -- Target the exact diagnostic under the cursor column
  local target_diagnostic = diagnostics[1]
  for _, d in ipairs(diagnostics) do
    if col >= d.col and col <= d.end_col then
      target_diagnostic = d
      break
    end
  end

  -- Copy to system clipboard (+)
  local message = target_diagnostic.message
  vim.fn.setreg("+", message)

  -- Use a clean echo instead of a messy print wrapper
  vim.api.nvim_echo({ { "Copied diagnostic: ", "Title" }, { message, "Normal" } }, false, {})
end, { desc = "LSP: Copy diagnostic under cursor" })
