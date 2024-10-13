local null_ls = require "null-ls"

local b = null_ls.builtins

local sources = {

  -- webdev stuff
  b.formatting.deno_fmt,                                                                       -- choosed deno for ts/js files cuz its very fast!
  b.formatting.prettier.with { filetypes = { "tex", "html", "css", "python", "json", "cpp" } }, -- so prettier works only on these filetypes

  -- Lua
  -- b.formatting.stylua,
  -- b.formatting.black,
  -- cpp
  b.formatting.clang_format,
  b.diagnostics.mypy,
  b.diagnostics.ruff,
}

null_ls.setup {
  debug = true,
  sources = sources,
}
