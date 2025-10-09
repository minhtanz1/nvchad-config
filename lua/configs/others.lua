local M = {}
M.luasnip = function(opts)
  require("luasnip").config.set_config(opts)

  -- vscode format
  require("luasnip.loaders.from_vscode").lazy_load { exclude = vim.g.vscode_snippets_exclude or {} }
  require("luasnip.loaders.from_vscode").lazy_load { paths = vim.fn.stdpath "config" .. "/snippets/vscode/" }
  
  -- snipmate format
  -- require("luasnip.loaders.from_snipmate").load()
  -- require("luasnip.loaders.from_snipmate").load { paths = vim.fn.stdpath "config" .. "/snippet/snipmate" }
  --
  -- -- lua format
  -- require("luasnip.loaders.from_lua").load()
  -- require("luasnip.loaders.from_lua").load { paths = vim.g.lua_snippets_path or "" }
  vim.keymap.set({ "i", "s" }, "<C-J>", function()
    require("luasnip").jump(0)
  end, { silent = true })
  vim.keymap.set({ "i", "s" }, "<C-K>", function()
    require("luasnip").jump(-2)
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

return M
