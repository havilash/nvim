-- since this is just an example spec, don't actually load anything here and return an empty spec
-- stylua: ignore

-- every spec file under the "plugins" directory will be loaded automatically by lazy.nvim
--
-- In your plugin files, you can:
-- * add extra plugins
-- * disable/enabled LazyVim plugins
-- * override the configuration of LazyVim plugins
return {
  {
    'AlexvZyl/nordic.nvim',
    lazy = false,
    priority = 1000,
    opts = {
      transparent = {
          bg = false,
          float = true,
      },
    }
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "nordic",
    },
  },

  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      -- YAML LSP
      opts.servers.yamlls = vim.tbl_deep_extend("force", opts.servers.yamlls or {}, {
        settings = {
          yaml = {
            schemaStore = { enable = true },
            schemas = require('schemastore').yaml.schemas {
              extra = {
                {
                  description = "AWS SAM template schema",
                  fileMatch = { "*.yaml", "*.yml" },
                  name = "aws-sam",
                  url = "https://raw.githubusercontent.com/aws/serverless-application-model/main/samtranslator/schema/schema.json",
                },
              },
            },
            customTags = {
              "!Ref scalar",
              "!Ref sequence",
              "!GetAtt scalar",
              "!GetAtt sequence",
              "!Sub scalar",
              "!Sub sequence",
              "!If scalar",
              "!If sequence",
              "!Equals scalar",
              "!Equals sequence",
              "!Not scalar",
              "!Not sequence",
              "!And scalar",
              "!And sequence",
              "!Or scalar",
              "!Or sequence",
              "!FindInMap",
              "!Join sequence",
              "!Split",
              "!Select",
              "!Base64",
              "!Cidr",
              "!ImportValue",
              "!Condition",
              "!Transform",
            },
          },
        },
      })

      opts.servers.cssls = opts.servers.cssls or {}
      opts.servers.emmet_ls = opts.servers.emmet_ls or {}
      opts.servers.pyright = opts.servers.pyright or {}
    end,
  },

  { "jidn/vim-dbml" },

  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "black" },
        javascript = { "prettier" },
        xml = { "xmlformatter" },
        sql = { "sqlfluff" },
      },
      formatters = {
        pg_format = {
          prepend_args = { "--spaces", "2" },
        },
      },
    }
  },

  { 'christoomey/vim-tmux-navigator' },
  { "tpope/vim-abolish" },
  { 'tpope/vim-fugitive' },

  { "nvim-mini/mini.pairs", enabled = false },

  {
    "jaklimoff/github-actions.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("github-actions").setup({
        debug = false,
        telescope_limit = 30,
      })
  
      vim.keymap.set("n", "<leader>ga", "<cmd>GithubActionsStatus<cr>",
        { desc = "GitHub Actions" })
    end,
  },

  {
    'saghen/blink.cmp',
    opts = {
      keymap = {
        preset = 'default',
        -- ['<Tab>'] = false,
        -- ['<CR>'] = false,
      },
      snippets = {
        preset = "luasnip",
      },
    }
  },

  {
    "nvim-mini/mini.align",
    version = false,
    config = function()
      require("mini.align").setup()
    end,
  },

  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewFileHistory" },
  },
}
