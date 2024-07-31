require "nvchad.options"

-- add yours here!

local o = vim.o
o.cursorlineopt ='both' -- to enable cursorline!

local global = {
  snipmate_snippets_path = vim.fn.stdpath "config" .. "/snippets",
  vscode_snippets_path = vim.fn.stdpath "config" .. "./snippets",
}
for name, value in pairs(global) do
  vim.g[name] = value
end
