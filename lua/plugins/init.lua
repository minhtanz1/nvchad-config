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
    "MeanderingProgrammer/render-markdown.nvim",
    -- dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-mini/mini.nvim" }, -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.icons' },        -- if you use standalone mini plugins
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" }, -- if you prefer nvim-web-devicon
    ft = { "markdown", "org", "md" },
    config = function()
      require "configs.render-markdown"
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp", -- LSP completions
      "hrsh7th/cmp-buffer", -- buffer words
      "hrsh7th/cmp-path", -- filesystem paths
      "hrsh7th/cmp-nvim-lua", -- Neovim Lua API
      "saadparwaiz1/cmp_luasnip", -- snippets
      "L3MON4D3/LuaSnip", -- snippet engine
      "onsails/lspkind.nvim",
      "lukas-reineke/cmp-under-comparator",
    },
    config = function()
      require "configs.cmp"
    end,
  },
  {
    "ray-x/lsp_signature.nvim",
    event = "InsertEnter",
    config = function()
      require "configs.lsp_signature"
    end,
  },

  {
    "R-nvim/R.nvim",
    lazy = false,
    config = function()
      -- Create a table with the options to be passed to setup()
      ---@type RConfigUserOpts
      local opts = {
        hook = {
          on_filetype = function()
            vim.api.nvim_buf_set_keymap(0, "n", "<Enter>", "<Plug>RDSendLine", {})
            vim.api.nvim_buf_set_keymap(0, "v", "<Enter>", "<Plug>RSendSelection", {})
          end,
        },
        auto_start = "always",
        objbr_auto_start = true,
        R_args = { "--quiet", "--no-save" },
        R_path = "/usr/bin/R",
        min_editor_width = 72,
        rconsole_width = 78,
        objbr_mappings = { -- Object browser keymap
          c = "class", -- Call R functions
          ["<localleader>gg"] = "head({object}, n = 15)", -- Use {object} notation to write arbitrary R code.
          v = function()
            -- Run lua functions
            require("r.browser").toggle_view()
          end,
        },
        -- disable_cmds = {
        --   "RClearConsole",
        --   "RCustomStart",
        --   "RSPlot",
        --   "RSaveClose",
        -- },
      }
      -- Check if the environment variable "R_AUTO_START" exists.
      -- If using fish shell, you could put in your config.fish:
      -- alias r "R_AUTO_START=true nvim"
      -- if vim.env.R_AUTO_START == "true" then
      --   opts.auto_start = "on startup"
      --   opts.objbr_auto_start = true
      -- end
      require("r").setup(opts)
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
          -- "-pdflatex=pdflatex",
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
        "marksman",
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
    "nvim-orgmode/orgmode",
    event = "VeryLazy",
    config = function()
      require("orgmode").setup {
        org_agenda_files = "~/orgfiles/**/*",
        org_default_notes_file = "~/orgfiles/refile.org",
      }
      -- Experimental LSP support
      vim.lsp.enable "org"
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
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
        "markdown",
        "markdown_inline",
        "r",
        "rnoweb",
        "yaml",
        "latex",
        "csv",
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
