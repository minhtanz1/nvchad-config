local ls = require "luasnip"
local s = ls.snippet
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

local M = {}

-- Define all Svelte blocks in a clear table format for easy editing
-- Returns a function that generates fresh nodes each time
local function get_svelte_blocks()
  return {
    {
      trigger = "if",
      description = "Svelte if block",
      format = [[
{#if [1]}
    [2]
{/if}
]],
      nodes = function()
        return {
          i(1, "condition"),
          i(2, "content"),
        }
      end,
    },
    {
      trigger = "each",
      description = "Svelte each block",
      format = [[
{#each [1] as [2]}
    [3]
{/each}
]],
      nodes = function()
        return {
          i(1, "items"),
          i(2, "item"),
          i(3, "{item}"),
        }
      end,
    },
    {
      trigger = "await",
      description = "Svelte await block",
      format = [[
{#await [1]}
    [2]
{:then [3]}
    [4]
{:catch [5]}
    [6]
{/await}
]],
      nodes = function()
        return {
          i(1, "promise"),
          i(2, "pending"),
          i(3, "value"),
          i(4, "fulfilled"),
          i(5, "error"),
          i(6, "rejected"),
        }
      end,
    },
    {
      trigger = "await-then",
      description = "Svelte await block (then shorthand)",
      format = [[
{#await [1] then [2]}
    [3]
{/await}
]],
      nodes = function()
        return {
          i(1, "promise"),
          i(2, "value"),
          i(3, "fulfilled"),
        }
      end,
    },
    {
      trigger = "key",
      description = "Svelte key block",
      format = [[
{#key [1]}
    [2]
{/key}
]],
      nodes = function()
        return {
          i(1, "key"),
          i(2, "content"),
        }
      end,
    },
    {
      trigger = "snippet",
      description = "Svelte snippet block (Svelte 5)",
      format = [[
{#snippet [1]([2])}
    [3]
{/snippet}
]],
      nodes = function()
        return {
          i(1, "name"),
          i(2, "parameter"),
          i(3, "content"),
        }
      end,
    },
    {
      trigger = "page",
      description = "SvelteKit page component",
      format = [[
<script lang="ts">
    [1]
</script>

<svelte:head>
    <title>[2]</title>
</svelte:head>

[3]

<style>
    [4]
</style>
]],
      nodes = function()
        return {
          i(1, "// your script here"),
          i(2, "Page Title"),
          i(3, ""),
          i(4, "/* your styles here */"),
        }
      end,
    },
  }
end

-- Convert the table of block definitions into LuaSnip snippets
local snippets = {}

for _, block in ipairs(get_svelte_blocks()) do
  -- Generate the formatted nodes using standard LuaSnip fmt with [] delimiters
  local formatted_nodes = fmt(block.format, block.nodes(), { delimiters = "[]" })

  -- Create the snippet using native ls.snippet syntax
  local snippet = s({
    trig = block.trigger,
    dscr = block.description,
  }, formatted_nodes)

  table.insert(snippets, snippet)
end

return snippets
