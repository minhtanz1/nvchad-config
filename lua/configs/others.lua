local M = {}
M.luasnip = function(opts)
  require("luasnip").config.set_config(opts)

  -- vscode format
  require("luasnip.loaders.from_vscode").load { exclude = vim.g.vscode_snippets_exclude or {} }
  require("luasnip.loaders.from_vscode").load { paths = vim.fn.stdpath "config" .. "/snippets/vscode/" }

  -- snipmate format
  -- require("luasnip.loaders.from_snipmate").load()
  -- require("luasnip.loaders.from_snipmate").load { paths = vim.fn.stdpath "config" .. "/snippet/snipmate" }
  --
  -- -- lua format
  require("luasnip.loaders.from_lua").load()
  require("luasnip.loaders.from_lua").load { paths = vim.fn.stdpath "config" .. "/snippets/lua/" }
  local ls = require "luasnip"
  -- vim.keymap.set({ "i", "s" }, "<Tab>", function()
  --   if ls.expand_or_jumpable() then
  --     ls.expand_or_jump()
  --   else
  --     -- gửi phím Tab bình thường nếu không có snippet
  --     vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, false, true), "")
  --   end
  -- end, { silent = true, noremap = true })
  --
  -- local ls = require "luasnip"
  -- vim.keymap.set({ "i", "s" }, "<S-Tab>", function()
  --   if ls.jumpable(-1) then
  --     ls.jump(-1)
  --   else
  --     vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<S-Tab>", true, false, true), "")
  --   end
  -- end, { silent = true, noremap = true })
  vim.keymap.set({ "i" }, "<C-K>", function()
    ls.expand()
  end, { silent = true })
  vim.keymap.set({ "i", "s" }, "<C-L>", function()
    ls.jump(1)
  end, { silent = true })
  vim.keymap.set({ "i", "s" }, "<C-J>", function()
    ls.jump(-1)
  end, { silent = true })

  vim.api.nvim_create_autocmd("InsertLeave", {
    callback = function()
      if
        require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()]
        and not require("luasnip").session.jump_active
      then
        require("luasnip").unlink_current()
      end
    end,
  })
end
require("luasnip").filetype_extend("tex", { "latex" })

return M
