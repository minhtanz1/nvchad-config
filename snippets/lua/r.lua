local ls = require "luasnip"
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local rep = require("luasnip.extras").rep
local fmt = require("luasnip.extras.fmt").fmt

return {

  -- gõ aa => <-
  s("aa", t "<-"),

  -- dataframe
  s(
    "df",
    fmt("{} <- data.frame(\n  {}\n)", {
      i(1, "df_name"),
      i(2, "col1 = c()"),
    })
  ),

  -- tibble
  s(
    "tb",
    fmt("{} <- tibble::tibble(\n  {}\n)", {
      i(1, "tb_name"),
      i(2, "col1 = c()"),
    })
  ),

  -- library
  s(
    "lib",
    fmt("library({})", {
      i(1, "dplyr"),
    })
  ),

  -- read_csv
  s(
    "csv",
    fmt('{} <- readr::read_csv("{}")', {
      i(1, "data"),
      i(2, "data.csv"),
    })
  ),
  s(
    "gl",
    fmt("glimpse({})", {
      i(1, "df"),
    })
  ),
  s(
    "flt",
    fmt("{} %>%\n  filter({})", {
      i(1, "data"),
      i(2, "condition"),
    })
  ),
  s(
    "mut",
    fmt("{} %>%\n  mutate({} = {})", {
      i(1, "data"),
      i(2, "new_col"),
      i(3, "expression"),
    })
  ),
  s(
    "gs",
    fmt(
      [[
{} %>%
  group_by({}) %>%
  summarise(
    {} = {}
  )
]],
      {
        i(1, "data"),
        i(2, "group_col"),
        i(3, "result"),
        i(4, "mean(value)"),
      }
    )
  ),
  s(
    "gg",
    fmt(
      [[
ggplot({}, aes(x = {}, y = {})) +
  geom_point()
]],
      {
        i(1, "df"),
        i(2, "x"),
        i(3, "y"),
      }
    )
  ),
  s(
    "hist",
    fmt(
      [[
ggplot({}, aes(x = {})) +
  geom_histogram()
]],
      {
        i(1, "df"),
        i(2, "variable"),
      }
    )
  ),
  s(
    "box",
    fmt(
      [[
ggplot({}, aes(x = {}, y = {})) +
  geom_boxplot()
]],
      {
        i(1, "df"),
        i(2, "group"),
        i(3, "value"),
      }
    )
  ),
  s("mean", fmt("mean({}, na.rm = TRUE)", { i(1, "x") })),
  s(
    "cor",
    fmt('cor({}, {}, use = "complete.obs")', {
      i(1, "x"),
      i(2, "y"),
    })
  ),
  s(
    "for",
    fmt(
      [[
for ({} in {}) {{
  {}
}}
]],
      {
        i(1, "i"),
        i(2, "1:10"),
        i(3),
      }
    )
  ),
  s(
    "pipe",
    fmt(
      [[
{} %>%
  {}
]],
      {
        i(1, "data"),
        i(2),
      }
    )
  ),
  s(
    "eda",
    fmt(
      [[
glimpse({})
summary({})
head({})
]],
      {
        i(1, "df"),
        rep(1),
        rep(1),
      }
    )
  ),
}
