require("nvchad.configs.lspconfig").defaults()
local cmp_nvim_lsp = require "cmp_nvim_lsp"
local servers = {
  "html",
  "cssls",
  "rust_analyzer",
  "lua_ls",
  "ts_ls",
  "pyright",
  "jsonls",
  "texlab",
  "marksman",
  "svelte",
  "djls",
}
local capabilities = cmp_nvim_lsp.default_capabilities()
local function lsp_cmd(primary, fallback)
  local mason_bin = vim.fn.stdpath("data") .. "/mason/bin"
  local primary_path = mason_bin .. "/" .. primary
  if vim.loop.fs_access(primary_path, "X") then
    return { primary_path, "--stdio" }
  end
  if fallback then
    local fallback_path = mason_bin .. "/" .. fallback
    if vim.loop.fs_access(fallback_path, "X") then
      return { fallback_path, "--stdio" }
    end
  end
  return { primary, "--stdio" }
end

vim.lsp.enable(servers)
vim.lsp.config("html", {
  cmd = lsp_cmd("html-lsp", "vscode-html-language-server"),
  filetypes = { "html" },
  capabilities = capabilities,
  init_options = {
    configurationSection = { "html", "css", "javascript" },
    embeddedLanguages = {
      css = true,
      javascript = true,
    },
    provideFormatter = true,
  },
})
vim.lsp.config("cssls", {
  cmd = lsp_cmd("css-lsp", "vscode-css-language-server"),
  filetypes = { "css", "scss", "less" },
  capabilities = capabilities,
})
vim.lsp.config("texlab", {
  cmd = { "texlab" },
  filetypes = { "tex", "plaintex", "bib" },
  capabilities = capabilities,
  settings = {
    texlab = {
      bibtexFormatter = "texlab",
      chktex = {
        onEdit = false,
        onOpenAndSave = false,
      },
      diagnosticsDelay = 300,
      formatterLineLength = 80,
      forwardSearch = {
        args = {},
      },
      latexFormatter = "latexindent",
      latexindent = {
        modifyLineBreaks = false,
      },
    },
  },
})

vim.lsp.config("jsonls", {
  cmd = { "vscode-json-language-server", "--stdio" },
  capabilities = capabilities,
  filetypes = { "json", "jsonc" },
  init_options = {
    provideFormatter = true,
  },
})

vim.lsp.config("pyright", {
  cmd = { "pyright-langserver", "--stdio" },
  capabilities = capabilities,
  filetypes = { "python" },
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        diagnosticMode = "openFilesOnly",
        useLibraryCodeForTypes = true,
      },
    },
  },
})

vim.lsp.config("ts_ls", {
  cmd = { "typescript-language-server", "--stdio" },
  capabilities = capabilities,
  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescriptreact",
    "typescript.tsx",
  },
})

vim.lsp.config("lua_ls", {
  cmd = { "lua-language-server" },
  capabilities = capabilities,
  filetypes = { "lua" },
})
vim.lsp.config("marksman", {
  cmd = { "marksman", "server" },
  capabilities = capabilities,
  filetypes = { "markdown", "markdown.mdx", "md" },
})
vim.lsp.config("rust_analyzer", {
  capabilities = capabilities,
  cmd = { "rust-analyzer" },
  filetypes = { "rust" },
  settings = {
    ["rust-analyzer"] = {
      diagnostics = {
        enable = false,
      },
    },
  },
})

vim.lsp.config("svelte", {
  cmd = { "svelteserver", "--stdio" },
  capabilities = capabilities,
  filetypes = { "svelte" },
  settings = {
    typescript = {
      inlayHints = {
        enumMemberValues = {
          enabled = true,
        },
        functionLikeReturnTypes = {
          enabled = true,
        },
        parameterNames = {
          enabled = "literals",
          suppressWhenArgumentMatchesName = true,
        },
        parameterTypes = {
          enabled = true,
        },
        propertyDeclarationTypes = {
          enabled = true,
        },
        variableTypes = {
          enabled = true,
        },
      },
    },
  },
})

vim.lsp.config("djls", {
  cmd = { "djls", "serve", "--stdio" },
  filetypes = { "htmldjango", "python" },
})
