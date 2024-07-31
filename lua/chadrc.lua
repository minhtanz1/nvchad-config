---@type ChadrcConfig
local M = {}

M.ui = {
  theme = "decay",

  hl_override = {
    Visual = {bg="#969696"},
    Comment = { italic = true, fg = "sun" },
    ["@comment"] = { italic = true , link = "Comment"},
    StatusLine = { bg = "NONE" },
    NvDashAscii = {fg = "none", bg = "none",},
    NvDashButtons = { bg = "NONE" },
  },

  transparency = true,
  statusline = {
    theme = "vscode", -- default/vscode/vscode_colored/minimal
    -- default/round/block/arrow separators work only for default statusline theme
    -- round and block will work for minimal theme only
    separator_style = "arrow",
  },

  nvdash = {
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
    },

    buttons = {
      { "  Find File", "Spc f f", "Telescope find_files" },
      { "󰈚  Recent Files", "Spc f o", "Telescope oldfiles" },
      { "󰈭  Find Word", "Spc f w", "Telescope live_grep" },
      { "  Bookmarks", "Spc m a", "Telescope marks" },
      { "  Themes", "Spc t h", "Telescope themes" },
      { "  Mappings", "Spc c h", "NvCheatsheet" },
    },
  },

  cheatsheet = { theme = "grid" }, -- simple/grid

  lsp = {
    signature = true,
    semantic_tokens = false,
  },

  term = {
    -- hl = "Normal:term,WinSeparator:WinSeparator",
    sizes = { sp = 0.3, vsp = 0.2 },
    float = {
      relative = "editor",
      row = 0.3,
      col = 0.25,
      width = 0.5,
      height = 0.4,
      border = "single",
    },
  },
}

return M
