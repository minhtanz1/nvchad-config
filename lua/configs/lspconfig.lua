-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"

-- EXAMPLE
local servers = { "html", "cssls", "rust_analyzer", "lua_ls", "ts_ls", "clangd", "pyright" }
local nvlsp = require "nvchad.configs.lspconfig"

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end

-- configuring single server, example: typescript
-- lspconfig.ts_ls.setup {
--   on_attach = nvlsp.on_attach,
--   on_init = nvlsp.on_init,
--   capabilities = nvlsp.capabilities,
-- }
--

vim.lsp.config("pyright", {
  init_options = {
    filetypes = { "python" },
    cmd = { "pyright-langserver", "--stdio" },
    settings = {
      python = {
        analysis = {
          autoSearchPaths = true,
          diagnosticMode = "openFilesOnly",
          useLibraryCodeForTypes = true,
        },
      },
    },
  },
})

-- vim.lsp.config("ruff", {
--   init_options = {
--     filetypes = { "python" },
--     cmd = { "ruff", "server" },
--   },
-- })
-- vim.api.nvim_create_autocmd("LspAttach", {
--   group = vim.api.nvim_create_augroup("lsp_attach_disable_ruff_hover", { clear = true }),
--   callback = function(args)
--     local client = vim.lsp.get_client_by_id(args.data.client_id)
--     if client == nil then
--       return
--     end
--     if client.name == "ruff" then
--       -- Disable hover in favor of Pyright
--       client.server_capabilities.hoverProvider = false
--     end
--   end,
--   desc = "LSP: Disable hover capability from Ruff",
-- })
vim.lsp.config("ts_ls", {
  init_options = {
    filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
    cmd = { "typescript-language-server", "--stdio" },
  },
})

vim.lsp.config("lua_ls", {
  init_options = {
    filetypes = { "lua" },
    cmd = { "lua-language-server" },
  },
})

vim.lsp.config("rust_analyzer", {
  init_options = {
    cmd = { "rust-analyzer" },
    filetypes = { "rust" },
  },
  settings = {
    ["rust-analyzer"] = {
      diagnostics = {
        enable = false,
      },
    },
  },
})
