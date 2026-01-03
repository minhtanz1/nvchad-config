return {
  -- {
  --   "let-def/texpresso.vim",
  --   ft = { "tex" },
  --   config = function()
  --     local home = vim.fn.expand "~"
  --     require("texpresso").texpresso_path = home .. "/.config/nvim/texpresso/build/texpresso"
  --   end,
  -- },
  {
    "lervag/vimtex",
    ft = { "tex" },
    lazy = false, -- we don't want to lazy load VimTeX
    init = function()
      -- Use latexmk for compilation and set the output directory to "build"
      vim.g.vimtex_compiler_method = "latexmk"
      vim.g.vimtex_compiler_latexmk = {
        build_dir = "build", -- output directory
        aux_dir = "build", -- auxiliary files directory
        options = {
          "-pdf", -- compile to PDF
          -- "-interaction=nonstopmode", -- nonstop interaction mode
          "-synctex=1", -- enable synctex for better forward/backward search
          "-shell-escape", -- allow shell escapes if needed
          "-bibtex",
          "-pdflatex=lualatex",
          "-output-format=pdf",
          "-noemulate-aux-dir",
        },
      }
      vim.g.vimtex_view_method = "zathura"
      -- vim.g.vimtex_view_method = "mupdf"
      vim.g.vimtex_view_general_viewer = "zathura"
      -- vim.g.vimtex_view_general_options = "--unique file:@pdf\\#src:@line@tex"
    end,
  },
  {
    "ibhagwan/fzf-lua",
  },
  {
    "kunkka19xx/simple-surr",
    lazy = false,
    config = function()
      require "configs.surround"
    end,
  },
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    config = function()
      require "configs.conform"
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    event = "VeryLazy",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    config = function()
      local dap = require "dap"
      local dapui = require "dapui"
      dapui.setup()
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end,
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    event = "VeryLazy",
    dependencies = {
      "williamboman/mason.nvim",
      "mfussenegger/nvim-dap",
    },
    opts = {
      handlers = {},
    },
  },
  {
    "mfussenegger/nvim-dap",
    -- config = function()
    --   require "configs.dap"
    -- end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      -- require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "lua-language-server",
        "stylua",
        "html-lsp",
        "css-lsp",
        "prettier",
        "clangd",
        "mypy",
        "pyright",
        "clang-format",
      },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "html",
        "css",
        "cpp",
        "python",
        "javascript",
        "rust",
        "json",
      },
    },
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    config = function()
      require "../configs/null-ls.lua"
    end,
  },
  {
    "kevinhwang91/nvim-ufo",
    dependencies = {
      "kevinhwang91/promise-async", -- Dependency bắt buộc
    },
    event = "BufReadPost", -- Load plugin khi mở file
    config = function()
      -- 1. Cấu hình các options cần thiết (Video nhắc rất kỹ đoạn này)
      vim.o.foldcolumn = "1" -- Hiện cột fold bên trái (để thấy dấu +,-)
      vim.o.foldlevel = 99 -- Mở tất cả code khi mới vào file
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true

      -- 2. Setup nvim-ufo
      require("ufo").setup {
        provider_selector = function(bufnr, filetype, buftype)
          return { "lsp", "indent" } -- Dùng LSP làm nguồn ưu tiên để fold code chuẩn hơn
        end,
      }
    end,
  },

  {
    -- snippet plugin
    "L3MON4D3/LuaSnip",
    lazy = true,
    dependencies = { { "rafamadriz/friendly-snippets", lazy = true } },
    opts = { history = true, updateevents = "TextChanged,TextChangedI", enable_autosnippets = true },
    run = "make install_jsregexp",
    specs = {
      { "saghen/blink.cmp", optional = true, opts = { snippets = { preset = "luasnip" } } },
    },
    config = function(_, opts)
      require("configs.others").luasnip(opts)
    end,
  },
}
