-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "gruvchad",
  hl_override = {
    Visual = { bg = "#3e3e3e", blend = 20},
    Comment = { italic = true, fg = "sun" },
    ["@comment"] = { italic = true, link = "Comment" },
    StatusLine = { bg = "NONE" },
    NvDashAscii = { fg = "none", bg = "none" },
    NvDashButtons = { bg = "NONE" },
  },
  transparency = false,
}

M.ui = {
  statusline = {
    theme = "default", -- default/vscode/vscode_colored/minimal
    -- default/round/block/arrow separators work only for default statusline theme
    -- round and block will work for minimal theme only
    separator_style = "arrow",
  },
}
M.nvdash = {
  load_on_startup = true,
  header = {
    "      ___                       ___           ___                    ___           ___           ___     ",
    "     /\\__\\          ___        /\\__\\         /\\__\\                  /\\  \\         /\\  \\         /\\__\\    ",
    "    /::|  |        /\\  \\      /::|  |       /:/  /                  \\:\\  \\       /::\\  \\       /::|  |   ",
    "   /:|:|  |        \\:\\  \\    /:|:|  |      /:/__/                    \\:\\  \\     /:/\\:\\  \\     /:|:|  |   ",
    "  /:/|:|__|__      /::\\__\\  /:/|:|  |__   /::\\  \\ ___                /::\\  \\   /::\\~\\:\\  \\   /:/|:|  |__ ",
    " /:/ |::::\\__\\  __/:/\\/__/ /:/ |:| /\\__\\ /:/\\:\\  /\\__\\              /:/\\:\\__\\ /:/\\:\\ \\:\\__\\ /:/ |:| /\\__\\",
    " \\/__/~~/:/  / /\\/:/  /    \\/__|:|/:/  / \\/__\\:\\/:/  /             /:/  \\/__/ \\/__\\:\\/:/  / \\/__|:|/:/  /",
    "       /:/  /  \\::/__/         |:/:/  /       \\::/  /             /:/  /           \\::/  /      |:/:/  / ",
    "      /:/  /    \\:\\__\\         |::/  /        /:/  /              \\/__/            /:/  /       |::/  /  ",
    "     /:/  /      \\/__/         /:/  /        /:/  /                               /:/  /        /:/  /   ",
    "     \\/__/                     \\/__/         \\/__/                                \\/__/         \\/__/    ",
    "                                                                                                             ",
  },
}
M.lsp = {
  signature = true,
  semantic_tokens = false,
}
M.term = {
  sizes = { sp = 0.3, vsp = 0.2 },
  float = {
    relative = "editor",
    row = 0.3,
    col = 0.25,
    width = 0.5,
    height = 0.4,
    border = "single",
  },
}
return M
