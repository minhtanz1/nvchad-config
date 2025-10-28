return {
  {
    "let-def/texpresso.vim",
    ft = { "tex" },
    config = function()
      local home = vim.fn.expand "~"
      require("texpresso").texpresso_path = home .. "/.config/nvim/texpresso/build/texpresso"
    end,
  },
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
      -- vim.g.vimtex_view_method = "zathura"
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
    "neovim/nvim-lspconfig",
    config = function()
      require("nvchad.configs.lspconfig").defaults()
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
    -- snippet plugin
    "L3MON4D3/LuaSnip",
    lazy = true,
    dependencies = { { "rafamadriz/friendly-snippets", lazy = true } },
    opts = { history = true, updateevents = "TextChanged,TextChangedI" },
    run = "make install_jsregexp",
    specs = {
      { "saghen/blink.cmp", optional = true, opts = { snippets = { preset = "luasnip" } } },
    },
    config = function(_, opts)
      require("configs.others").luasnip(opts)
    end,
  },
  -- {
  --   "vyfor/cord.nvim",
  --   build = "./build",
  --   event = "VeryLazy",
  --   config = function()
  --     require("cord").setup {
  --       usercmds = true,
  --       log_level = "error",
  --       timer = {
  --         interval = 1500,
  --         reset_on_idle = false,
  --         reset_on_change = false,
  --       },
  --       editor = {
  --         image = nil,
  --         client = "neovim",
  --         tooltip = "Nvim/Arch Linux 🐧",
  --       },
  --       display = {
  --         show_time = true,
  --         show_repository = true,
  --         show_cursor_position = true,
  --         swap_fields = false,
  --         swap_icons = false,
  --         workspace_blacklist = {},
  --       },
  --       lsp = {
  --         show_problem_count = true,
  --         severity = 1,
  --         scope = "workspace",
  --       },
  --       idle = {
  --         enable = true,
  --         show_status = true,
  --         timeout = 100000,
  --         disable_on_focus = true,
  --         text = "Idle",
  --         tooltip = "💤",
  --       },
  --       text = {
  --         viewing = "Viewing {}",
  --         editing = "Editing {}",
  --         file_browser = "Browsing files in {}",
  --         plugin_manager = "Managing plugins in {}",
  --         lsp_manager = "Configuring LSP in {}",
  --         vcs = "Committing changes in {}",
  --         workspace = "In {}",
  --       },
  --       buttons = {
  --         {
  --           label = "View Repository",
  --           url = "git",
  --         },
  --         {
  --           label = "Arch Linux",
  --           url = "https://archlinux.org/",
  --         },
  --       },
  --       assets = nil,
  --     }
  --   end,
  -- },
}
