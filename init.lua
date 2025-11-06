vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)
vim.opt.wrap = true
vim.opt.linebreak = true
vim.wo.relativenumber = true
local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },

  { import = "plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")
require "options"
require "nvchad.autocmds"
require "configs.helpers"
require "configs.floating-term"
vim.schedule(function()
  require "mappings"
end)
-- local spath = vim.fn.stdpath "config" .. "/snippet"
vim.g.vscode_snippets_path = vim.fn.stdpath "config" .. "/snippets/vscode"
vim.g.lua_snippets_path = vim.fn.stdpath "config" .. "/snippets/lua"

vim.o.conceallevel = 2 -- Enables full concealment
vim.g.tex_conceal = "bdmgs"
vim.opt.clipboard = "unnamedplus"
vim.g.vimtex_quickfix_ignore_filters = { "warning", "Underfull", "Overfull" }
vim.g.vimtex_quickfix_open_on_warning = false
