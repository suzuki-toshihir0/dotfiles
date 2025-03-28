return {
  {"folke/lazy.nvim"},
  {'lambdalisue/fern.vim',
    keys = {
      { "<C-n>", ":Fern . -reveal=% -drawer -toggle -width=40<CR>", desc = "toggle fern" },
    },
    dependencies = {
      { 'lambdalisue/nerdfont.vim', },
      { 'lambdalisue/fern-renderer-nerdfont.vim',
        config = function()
          vim.g['fern#renderer'] = "nerdfont"
          vim.g['fern#default_hidden'] = 1
        end
      },
      { 'lambdalisue/fern-git-status.vim', },
    },
  },
  {"nvim-telescope/telescope.nvim", dependencies = {"nvim-lua/plenary.nvim"}},
  {'romgrk/barbar.nvim',
    dependencies = {
      'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
      'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
    },
    init = function() vim.g.barbar_auto_setup = false end,
    opts = {
      -- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
      -- animation = true,
      -- insert_at_start = true,
      -- …etc.
    },
    version = '^1.0.0', -- optional: only update when a new 1.x version is released
  },
  {"folke/tokyonight.nvim"},
  {"github/copilot.vim"},
  {"sindrets/diffview.nvim"},
  {"rust-lang/rust.vim"},
  {"JuliaEditorSupport/julia-vim"},
  -- lsp
  {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
  },
  -- additional plugins about lsp
  {"j-hui/fidget.nvim"},
  {"nvimdev/lspsaga.nvim",
    config = function()
        require('lspsaga').setup({})
    end,
    dependencies = {'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons'}
  },
  {
    "hrsh7th/vim-vsnip",
    config = function()
      -- スニペットファイルの保存場所を設定
      vim.g.vsnip_snippet_dir = vim.fn.stdpath('config') .. '/snippets'
    end,
  },
  {'hrsh7th/cmp-nvim-lsp'},
  {'hrsh7th/cmp-buffer'},
  {'hrsh7th/cmp-path'},
  {'hrsh7th/cmp-cmdline'},
  {'hrsh7th/nvim-cmp'},
  {"knsh14/vim-github-link"},
}
