require "nvchad.options"

-- Add your custom configurations here

local o = vim.o
o.cursorlineopt = "both" -- Enable both line and column highlighting for cursor

local global = {
  snipmate_snippets_path = "~/.config/nvim/snippet/snipmate",
  vscode_snippets_path = "~/.config/nvim/snippet/vscode"
}

for name, value in pairs(global) do
  vim.g[name] = value
end
