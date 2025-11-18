local ls = require "luasnip"
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node -- Hoặc repeat nếu cần lặp
local fmt = require("luasnip.extras.fmt").fmt -- Để format đa dòng

ls.add_snippets("tex", {
  s(
    {trig = "lr",  dscr= "Insert \\left...\\right pair with content and closing"},
    fmt(
      [[
      \left{} {} \right{} {}
    ]],
      {
        c(1, { t "(", t "[", t "{", t "." }),
        i(2, "content"),
        c(3, { t ")", t "]", t "}", t "." }),
        i(4),
      }
    )
  ),
})
