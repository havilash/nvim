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
    -- config = function()
    --     require('nordic').load()
    -- end
  },
    {
    "LazyVim/LazyVim",
    opts = {
        colorscheme = "nordic",
    },
  },

  { import = "lazyvim.plugins.extras.lang.markdown" },
  { import = "lazyvim.plugins.extras.lang.typescript" },
  { import = "lazyvim.plugins.extras.lang.json" },
  { import = "lazyvim.plugins.extras.lang.vue" },
  { import = "lazyvim.plugins.extras.lang.yaml" },
  { import = "lazyvim.plugins.extras.ai.copilot" },
  { import = "lazyvim.plugins.extras.formatting.prettier" },
  { import = "lazyvim.plugins.extras.coding.mini-surround" },
  { import = "lazyvim.plugins.extras.editor.mini-files" },


  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      opts.servers.yamlls = vim.tbl_deep_extend("force", opts.servers.yamlls or {}, {
        settings = {
          yaml = {
            schemaStore = { enable = true },
            schemas = require('schemastore').yaml.schemas {
              extra = {
                {
                  description = "AWS SAM template schema",
                  fileMatch = {
                    "*.yaml",
                    "*.yml",
                  },
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
            -- validate = false,
            -- completion = true,
            -- hover = true,
            -- format = { enable = true },
          },
        },
      })
    end,
  },

  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "black" },
        javascript = { "prettier" },
        xml = { "xmlformatter" }
      },
    }
  },

  {
    "tpope/vim-abolish",
  },
}
