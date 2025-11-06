require "nvchad.options"

-- Add your custom configurations here

local o = vim.o
o.cursorlineopt = "both" -- Enable both line and column highlighting for cursor

local global = {
  vscode_snippets_path = vim.fn.stdpath "config" .. "/snippets/vscode/",
  lua_snippets_path = vim.fn.stdpath "config" .. "/snippets/lua/",
}

for name, value in pairs(global) do
  vim.g[name] = value
end
