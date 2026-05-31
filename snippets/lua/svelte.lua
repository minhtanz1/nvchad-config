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
{#if {}}
    {}
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
{#each {} as {}}
    {}
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
{#await {}}
    {}
{:then {}}
    {}
{:catch {}}
    {}
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
{#await {} then {}}
    {}
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
{#key {}}
    {}
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
{#snippet {}({})}
    {}
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
    {}
</script>

<svelte:head>
    <title>{}</title>
</svelte:head>

{}

<style>
    {}
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
function M.setup()
  local snippets = {}

  for _, block in ipairs(get_svelte_blocks()) do
    -- Generate the formatted nodes using standard LuaSnip fmt
    local formatted_nodes = fmt(block.format, block.nodes())

    -- Create the snippet using native ls.snippet syntax
    local snippet = s({
      trig = block.trigger,
      dscr = block.description,
    }, formatted_nodes)

    table.insert(snippets, snippet)
  end

  ls.add_snippets("svelte", snippets)
end

return M
