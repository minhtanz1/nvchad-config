-- ~/.config/nvim/snippets/lua/latex.lua
local ls = require "luasnip"
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node
local d = ls.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt

-- Thêm snippets cho filetype "tex" (LaTeX)
ls.add_snippets("tex", {
  -- \begin{env} ... \end{env}
  s(
    "beg",
    fmt(
      [[
\begin{{{}}}
  {}
\end{{{}}}
]],
      { i(1, "environment"), i(2), rep = false }
    )
  ),
  -- itemize với 1 item mặc định, Tab để sang i(0)
  s(
    "it",
    fmt(
      [[
\begin{{itemize}}
  \item {}
\end{{itemize}}
]],
      { i(1, "first item") }
    )
  ),

  -- figure: includegraphics + caption + label
  s(
    "fig",
    fmt(
      [[
\begin{{figure}}[ht]
  \centering
  \includegraphics[width={}]{{}}
  \caption{{{}}}
  \label{{fig:{}}}
\end{{figure}}
]],
      { i(1, "\\linewidth"), i(2, "path/to/image"), i(3, "Caption"), i(4, "label") }
    )
  ),

  -- equation với label
  s(
    "eq",
    fmt(
      [[
\begin{{equation}}
  {}
  \label{{eq:{}}}
\end{{equation}}
]],
      { i(1, "E=mc^2"), i(2, "label") }
    )
  ),

  -- inline math
  s("mm", fmt("${}$", { i(1, "x^2 + y^2") })),

  -- display math (align)
  s(
    "align",
    fmt(
      [[
\begin{{align}}
  {} \\
  {}
\end{{align}}
]],
      { i(1, "a &= b + c"), i(2, "d &= e + f") }
    )
  ),

  -- label/ref shortcuts
  s("lbl", fmt("\\label{{{}}}", { i(1, "sec:label") })),
  s("ref", fmt("\\ref{{{}}}", { i(1, "sec:label") })),
  s("eqref", fmt("\\eqref{{{}}}", { i(1, "eq:label") })),

  -- tikzpicture basic
  s(
    "tikz",
    fmt(
      [[
\begin{{tikzpicture}}[{}]
  {}
\end{{tikzpicture}}
]],
      { i(1, "scale=1"), i(2, "% draw here") }
    )
  ),
  s("lr", {
    -- \left + choice of delimiters
    t "\\left",
    c(1, {
      t "(",
      t "[",
      -- curly braces must be escaped in LaTeX as \{ and \}
      t "\\{",
      t ".",
    }),
    t " ",
    -- content
    i(2, "content"),
    t " \\right",
    c(3, {
      t ")",
      t "]",
      t "\\}",
      t ".",
    }),
    t " ",
    -- trailing placeholder (was $4 in original snippet)
    i(4),
  }),
}, { key = "latex" })
