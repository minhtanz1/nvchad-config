local cmp = require "cmp"
local luasnip = require "luasnip"
local lspkind = require "lspkind"

-- ─── Helpers ────────────────────────────────────────────────────────────────

-- Check if there's a word before cursor (for smart Tab behavior)
local function has_words_before()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
end

-- ─── Main Setup ─────────────────────────────────────────────────────────────

cmp.setup {
  completion = {
    completeopt = "menu,menuone,noinsert",
    keyword_length = 1, -- trigger after 1 char (faster feel)
  },

  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },

  -- ── Mappings ──────────────────────────────────────────────────────────────
  mapping = cmp.mapping.preset.insert {
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.abort(), -- close menu
    ["<C-u>"] = cmp.mapping.scroll_docs(-4), -- scroll docs up
    ["<C-d>"] = cmp.mapping.scroll_docs(4), -- scroll docs down
    ["<CR>"] = cmp.mapping.confirm { select = false }, -- only confirm explicit selection

    -- Tab: next item → expand snippet → fallback
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item { behavior = cmp.SelectBehavior.Insert }
      elseif luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item { behavior = cmp.SelectBehavior.Insert }
      elseif luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),

    -- Accept first item immediately (great for obvious completions)
    ["<C-y>"] = cmp.mapping(function()
      if cmp.visible() then
        cmp.confirm { select = true }
      end
    end),
  },

  -- ── Sources (priority = weight, higher = ranked first) ───────────────────
  sources = cmp.config.sources({
    { name = "nvim_lsp", priority = 1000 },
    { name = "luasnip", priority = 900 },
    { name = "nvim_lsp_signature_help", priority = 750 }, -- show fn signature while typing args
    -- { name = "copilot", priority = 700 }, -- remove if not using copilot
  }, {
    { name = "buffer", priority = 500, keyword_length = 3 }, -- only after 3 chars (reduces noise)
    { name = "path", priority = 300 },
    { name = "calc", priority = 200 }, -- math expressions (= 2+2 → 4)
    { name = "emoji", priority = 100 }, -- :smile: completions
  }),

  -- ── Formatting ────────────────────────────────────────────────────────────
  formatting = {
    fields = { "abbr", "kind", "menu" }, -- column order in menu
    format = lspkind.cmp_format {
      mode = "symbol_text",
      maxwidth = 50,
      ellipsis_char = "…",
      -- Show source name as tag (e.g. [LSP], [Snip])
      before = function(entry, vim_item)
        vim_item.menu = ({
          nvim_lsp = "[LSP]",
          nvim_lsp_signature_help = "[Sig]",
          luasnip = "[Snip]",
          -- copilot = "[AI]",
          buffer = "[Buf]",
          path = "[Path]",
          calc = "[Calc]",
          emoji = "[Emoji]",
        })[entry.source.name]
        return vim_item
      end,
    },
  },

  -- ── Sorting ───────────────────────────────────────────────────────────────
  sorting = {
    priority_weight = 2,
    comparators = {
      -- cmp-under-comparator: pushes _ prefixed items to bottom (Python, Lua)
      cmp.config.compare.recently_used, -- boost recently typed items
      require("cmp-under-comparator").under,
      cmp.config.compare.exact,
      cmp.config.compare.score,
      cmp.config.compare.locality, -- prefer items closer in scope
      cmp.config.compare.kind,
      cmp.config.compare.sort_text,
      cmp.config.compare.length,
      cmp.config.compare.order,
    },
  },

  -- ── Window ────────────────────────────────────────────────────────────────
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered {
      winhighlight = "Normal:CmpDoc,FloatBorder:CmpDocBorder",
      max_width = 80,
      max_height = 20,
    },
  },

  experimental = {
    ghost_text = { hl_group = "Comment" }, -- dim ghost text like a comment
  },

  -- ── Per-filetype overrides ─────────────────────────────────────────────────
  -- Git commit: only spell + emoji
  -- Lua: deprioritize buffer noise
}

-- ─── Filetype-specific ───────────────────────────────────────────────────────

-- Git commits: spell check + emoji only
cmp.setup.filetype("gitcommit", {
  sources = cmp.config.sources(
    { { name = "git" } }, -- requires cmp-git plugin
    { { name = "emoji" }, { name = "buffer", keyword_length = 4 } }
  ),
})

-- Markdown: enable spell source
cmp.setup.filetype({ "markdown", "tex" }, {
  sources = cmp.config.sources(
    { { name = "nvim_lsp" }, { name = "luasnip"}, {name = "path"} },
    { { name = "buffer" }, { name = "spell", keyword_length = 4 }, { name = "emoji" },  }
  ),
})

cmp.setup.filetype({ "html", "css", "scss", "less" }, {
  sources = cmp.config.sources({
    { name = "nvim_lsp", priority = 1000 },
    { name = "luasnip", priority = 900 },
    { name = "nvim_lsp_signature_help", priority = 750 },
    { name = "path", priority = 600 },
  }, {
    { name = "buffer", priority = 400, keyword_length = 2 },
  }),
})

-- ─── Cmdline ─────────────────────────────────────────────────────────────────

-- Search / ?
-- cmp.setup.cmdline({ "/", "?" }, {
--   mapping = cmp.mapping.preset.cmdline(),
--   sources = cmp.config.sources(
--     { { name = "nvim_lsp_document_symbol" } }, -- jump to symbols via /
--     { { name = "buffer" } }
--   ),
-- })
--
-- -- Command :
-- cmp.setup.cmdline(":", {
--   mapping = cmp.mapping.preset.cmdline(),
--   sources = cmp.config.sources(
--     { { name = "path" } },
--     { { name = "cmdline", option = { ignore_cmds = { "Man", "!" } } } }
--   ),
-- })
