return {
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
        "gopls",
        "codespell",
        "staticcheck",
        "golangci-lint-langserver",
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
        "go",
        "terraform",
        "hcl",
        "typescript",
        "javascript",
        "tsx",
        "markdown",
        "dockerfile",
        "bash",
        "markdown",
        "python",
        "yaml",
        "json"
      },
    },
  },
  {
    "hrsh7th/nvim-cmp",
    opts = {
      mapping = {
        ["<Tab>"] = function()
          require("luasnip").jump(1)
        end,
        ["<C-Space"] = require("cmp").mapping.complete(),
        ["<Down>"] = require("cmp").mapping.select_next_item(),
        ["<Up>"] = require("cmp").mapping.select_prev_item(),
      },
    },
  },
  {
    "nvim-tree/nvim-tree.lua",
    opts = {
      filters = {
        dotfiles = false,
        custom = { "node_modules", ".idea", ".terraform" },
      },
      update_focused_file = {
        enable = true,
        update_cwd = true,
      },
      diagnostics = {
        enable = true,
      },
    },
  },
  {
    "kwkarlwang/bufjump.nvim",
    enabled = false,
    opts = {
      config = function()
        require("bufjump").setup()
      end,
    },
  },
  {
    "edolphin-ydf/goimpl.nvim",
    ft = "go",
    opts = {
      config = function()
        require("telescope").load_extension "goimpl"
      end,
    },
  },
  {
    "olexsmir/gopher.nvim",
    ft = { "go" },
    branch = "develop",
    opts = {
      gotag = {
        transform = "camelcase",
      },
    },
    config = function(_, opts)
      require("gopher").setup(opts)
    end,
    build = function()
      vim.cmd [[silent! GoInstallDeps]]
    end,
  },
  {
    "smoka7/hop.nvim",
    version = "*",
    opts = {},
  },
  {
    "ray-x/navigator.lua",
    requires = {
      { "ray-x/guihua.lua", run = "cd lua/fzy && make" },
      { "neovim/nvim-lspconfig" },
    },
  },
  {
    "ray-x/go.nvim",
    dependencies = { -- optional packages
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("go").setup()
    end,
    opts = {
      disable_defaults = true,
    },
    event = { "CmdlineEnter" },
    ft = { "go", "gomod" },
    build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
  },
  {
    "ahmedkhalf/project.nvim",
    lazy = false,
    config = function()
      require("project_nvim").setup {
        show_hidden = true,
      }
      require("telescope").load_extension "projects"
      require("nvim-tree").setup {
        sync_root_with_cwd = true,
        respect_buf_cwd = true,
        update_focused_file = {
          enable = true,
          update_root = true,
        },
      }
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = "nvim-telescope/telescope-ui-select.nvim",

    opts = {
      extensions_list = { "ui-select" },
    },
  },
  {
    "nvimdev/lspsaga.nvim",
    config = function()
      require("lspsaga").setup {
        lightbulb = {
          enable = false,
          sign = true,
          debounce = 10,
          virtual_text = true,
          sign_priority = 40,
        },
        symbol_in_winbar = {
          enable = true,
          separator = " › ",
          hide_keyword = false,
          ignore_patterns = nil,
          show_file = true,
          folder_level = 1,
          color_mode = true,
          dely = 300,
        },
        implement = {
          enable = true,
          virtual_text = false,
        },
        rename = {
          enable = true,
          auto_save = true,
        },
      }
    end,
    event = "LspAttach",
    dependencies = {
      "nvim-treesitter/nvim-treesitter", -- optional
      "nvim-tree/nvim-web-devicons", -- optional
    },
  },
  {
    "tpope/vim-fugitive",
    lazy = false,
    opt = true,
    cmd = {
      "G",
      "Git",
      "Gdiffsplit",
      "Gvdiffsplit",
      "Gedit",
      "Gsplit",
      "Gread",
      "Gwrite",
      "Ggrep",
      "Glgrep",
      "Gmove",
      "Gdelete",
      "Gremove",
      "Gbrowse",
    },
  },
  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
      { "tpope/vim-dadbod", lazy = true },
      { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
    },
    cmd = {
      "DBUI",
      "DBUIToggle",
      "DBUIAddConnection",
      "DBUIFindBuffer",
    },
    init = function()
      vim.g.db_ui_use_nerd_fonts = 1
      vim.g.db_ui_execute_on_save = 0
      vim.g.db_ui_win_position = "right"
      vim.g.db_ui_show_database_icon = 1
      vim.g.db_ui_winwidth = 100
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "sql,mysql,plsql",
        callback = function()
          require("cmp").setup.buffer {
            sources = {
              { name = "vim-dadbod-completion" },
            },
          }
        end,
      })
    end,
  },
  {
    "mg979/vim-visual-multi",
    lazy = false,
    init = function()
      vim.g.VM_default_mappings = 0
      vim.g.VM_mouse_mappings = 0

      vim.g.VM_maps = {
        ["Select Cursor Down"] = "<C-u>",
        ["Select Cursor Up"] = "<C-i>",
        ["Switch Mode"] = "<Tab>",
      }
    end,
  },
  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("refactoring").setup()
    end,
  },
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
}
