-- 基本設定
vim.scriptencoding = 'utf-8'
vim.opt.encoding = 'utf-8'
vim.opt.fileencoding = 'utf-8'

vim.opt.number = true             -- 行番号を表示する
vim.wo.number = true              -- ウィンドウごとに行番号を表示する
vim.wo.relativenumber = false     -- 相対行番号を無効にする
vim.opt.mouse = 'a'               -- すべてのモードでマウス操作を有効にする
vim.opt.title = true              -- ウィンドウタイトルをファイル名などに自動設定する
vim.opt.autoindent = true         -- 自動インデントを有効にする
vim.opt.smartindent = true        -- コード構造に応じたスマートなインデントを有効にする
vim.opt.hlsearch = true           -- 検索結果をハイライト表示する
vim.opt.backup = false            -- バックアップファイルの作成を無効にする
vim.opt.showcmd = true            -- コマンド入力中に部分的なコマンドを表示する
vim.opt.cmdheight = 2             -- コマンドラインの高さを2行に設定する
vim.opt.laststatus = 2            -- 常にステータスラインを表示する
vim.opt.expandtab = true          -- タブをスペースに変換する
vim.opt.scrolloff = 10            -- カーソル周辺に10行分の余白を確保する
vim.opt.shell = 'zsh'             -- 使用するシェルをzshに設定する
vim.opt.inccommand = 'split'      -- インクリメンタルコマンドの結果を分割ウィンドウでプレビューする
vim.opt.ignorecase = true         -- 検索時に大文字と小文字を区別しない
vim.opt.smarttab = true           -- タブ入力時に適切なインデント幅を自動調整する
vim.opt.breakindent = true        -- 折り返し行にもインデントを適用する
vim.opt.shiftwidth = 2            -- 自動インデントの際のスペース幅を2に設定する
vim.opt.tabstop = 2               -- タブの幅を2スペース分に設定する
vim.opt.wrap = true               -- 長い行を画面幅に合わせて折り返して表示する
vim.opt.helplang = 'ja'           -- ヘルプファイルの表示言語を日本語に設定する
vim.opt.updatetime = 300          -- 更新間隔を300ミリ秒に設定し、レスポンスを改善する
vim.opt.showtabline = 2           -- 常にタブラインを表示する
vim.opt.clipboard = 'unnamedplus' -- システムのクリップボードと共有する
vim.opt.termguicolors = true      -- 真のカラーサポートを有効にする
vim.opt.signcolumn = 'yes'        -- サインカラム（デバッグやGit情報表示など）を常に表示する
vim.opt.hidden = true             -- 未保存バッファを隠しバッファとして保持する
vim.opt.swapfile = false          -- スワップファイルの作成を無効にする
vim.opt.list = true               -- 空白やタブなどの特殊文字を表示する
vim.opt.listchars = { tab = '>-', space = '·', trail = '·' }  -- 表示する特殊文字の記号を設定する

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins",
  {
    checker = {enabled = false,},
  }
)

local function is_wsl()
  return vim.loop.os_uname().release:lower():match("microsoft") ~= nil
end

if is_wsl() then
  vim.g.clipboard = {
    name = 'myClipboard',
    copy = {
      ['+'] = 'win32yank.exe -i --crlf',
      ['*'] = 'win32yank.exe -i --crlf',
    },
    paste = {
      ['+'] = 'win32yank.exe -o --lf',
      ['*'] = 'win32yank.exe -o --lf',
    },
   cache_enabled = 1,
  }
end

-- VSCode Neovim環境では使わない設定
if not vim.g.vscode then
  vim.cmd 'colorscheme tokyonight-moon'

  require('telescope').setup{
    defaults = {
      vimgrep_arguments = {
        'rg',
        '--color=never',
        '--no-heading',
        '--with-filename',
        '--line-number',
        '--column',
       '--smart-case',
        '-uu' -- **This is the added flag**
      }
    }
  }

  require('gitsigns').setup()

  vim.cmd('syntax enable')
  vim.cmd('filetype plugin indent on')
  vim.g.rustfmt_autosave = 1


  -- C/C++ファイル保存時に、プロジェクトにフォーマット設定(.clang-format)がある場合のみ、
  -- LSP (clangd) の自動フォーマットを実行する設定
  vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = {"*.c", "*.cpp", "*.h", "*.hpp"},  -- 対象のファイル拡張子を指定
    callback = function()
      -- カレントディレクトリから親ディレクトリに向けて、.clang-formatを探す
      -- 末尾の';'によって、上位ディレクトリも検索対象になる
      local config_file = vim.fn.findfile('.clang-format', vim.fn.getcwd() .. ';')

      -- .clang-formatが見つからなければ、フォーマット処理を中断してそのまま保存
      if config_file == "" then
        return
      end

      -- .clang-formatが存在する場合は、LSPのフォーマット機能を同期的に実行する
      vim.lsp.buf.format({ async = false })
    end,
  })

  -- nvim-cmp setup
  local cmp = require'cmp'

  -- Global setup.
  cmp.setup({
    snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- require'snippy'.expand_snippet(args.body) -- For `snippy` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
        -- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
      end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      -- ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      -- ['<C-f>'] = cmp.mapping.scroll_docs(4),
      -- ['<C-Space>'] = cmp.mapping.complete(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'snippy' }, -- For snippy users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
    }, {
      { name = 'buffer' },
    })
  })

  -- `/` cmdline setup.
  cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- `:` cmdline setup.
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    }),
    matching = { disallow_symbol_nonprefix_matching = false }
  })
  -- LSP config
  -- It's important that you set up the plugins in the following order:
  --
  -- 1. `mason.nvim`
  require("mason").setup()
  -- 2. `mason-lspconfig.nvim`
  require("mason-lspconfig").setup({
    ensure_installed = {"lua_ls", "clangd", "rust_analyzer", "julials", "tinymist", "typos_lsp", "pyright"}
  })
  -- 3. Setup servers via `lspconfig`
  -- Here, setup the servers automatically based on the installed servers.
  require("mason-lspconfig").setup_handlers {
      -- The first entry (without a key) will be the default handler
      -- and will be called for each installed server that doesn't have
      -- a dedicated handler.
      function (server_name) -- default handler (optional)
          require("lspconfig")[server_name].setup {}
      end,
      -- Next, you can provide a dedicated handler for specific servers.
      -- For example, a handler override for the `rust_analyzer`:
      -- ["rust_analyzer"] = function ()
      --     require("rust-tools").setup {}
      -- end
      ["lua_ls"] = function()
        require("lspconfig").lua_ls.setup{
          settings = {
            Lua = {
              diagnostics = {
                globals = {"vim"}
              }
            }
          }
        }
      end,
      ["clangd"] = function()
        require("lspconfig").clangd.setup{
          capabilities = require("cmp_nvim_lsp").default_capabilities(),
          cmd = { "clangd", "--offset-encoding=utf-16" },
        }
      end,
      ["typos_lsp"] = function()
        require("lspconfig").typos_lsp.setup{
          init_options = {
            config = '~/.config/nvim/spell/.typos.toml',
          },
        }
      end,
  }

  -- setup additional plugins about lsp
  require("fidget").setup()

  require"nvim-treesitter.configs".setup {
    -- A list of parser names, or "all" (the listed parsers MUST always be installed)
    ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "rust", "cpp", "python", "julia", "typst"},

    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,

    -- Automatically install missing parsers when entering buffer
    -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
    auto_install = true,

    -- List of parsers to ignore installing (or "all")
    -- ignore_install = { "javascript" },

    ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
    -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

    highlight = {
      enable = true,
      -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
      -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
      -- the name of the parser)
      -- list of language that will be disabled
      -- disable = { "c", "rust" },
      -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
      -- disable = function(lang, buf)
      --     local max_filesize = 100 * 1024 -- 100 KB
      --     local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
      --     if ok and stats and stats.size > max_filesize then
      --         return true
      --     end
      -- end,
      -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
      -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
      -- Using this option may slow down your editor, and you may see some duplicate highlights.
      -- Instead of true it can also be a list of languages
      additional_vim_regex_highlighting = false,
    },
}
end

-- keymap
-- Native Neovim, VSCode Neovim共通のキーバインド
vim.keymap.set('n', '<C-j>', '<Cmd>BufferPrevious<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-k>', '<Cmd>BufferNext<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>e', '<Cmd>BufferClose<CR>', { noremap = true, silent = true })
vim.keymap.set({'v', 'n'}, '<leader>gl', ':GetCommitLink<CR>')

-- VSCode Neovimだけで使うもの
if vim.g.vscode then
  vim.keymap.set('n', '<leader>ff', function()
    require('vscode').call('find-it-faster.findFiles')
  end, { noremap = true, silent = true })
-- Native Neovimだけで使うもの
else
  -- insert modeからの離脱
  vim.keymap.set('i', 'jj', '<ESC>', { noremap = true, silent = true })

  -- window split
  vim.keymap.set('n', 'ss', ':split<Return><C-w>w')
  vim.keymap.set('n', 'sv', ':vsplit<Return><C-w>w')
  vim.keymap.set('n', 'sh', '<C-w>h')
  vim.keymap.set('n', 'sk', '<C-w>k')
  vim.keymap.set('n', 'sj', '<C-w>j')
  vim.keymap.set('n', 'sl', '<C-w>l')

  -- Telescope
  local builtin = require('telescope.builtin')
  vim.api.nvim_set_keymap('n', '<leader>ff', ':Telescope find_files find_command=rg,--files,--hidden,--glob,!*.git <CR>', { noremap = true, silent = true })
  vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
  vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
  vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

  vim.api.nvim_set_keymap('i', '<Tab>', 'vsnip#jumpable(1) ? "<Plug>(vsnip-jump-next)" : "<Tab>"', {expr = true, noremap = true})
  vim.api.nvim_set_keymap('s', '<Tab>', 'vsnip#jumpable(1) ? "<Plug>(vsnip-jump-next)" : "<Tab>"', {expr = true, noremap = true})
  vim.api.nvim_set_keymap('i', '<S-Tab>', 'vsnip#jumpable(-1) ? "<Plug>(vsnip-jump-prev)" : "<S-Tab>"', {expr = true, noremap = true})
  vim.api.nvim_set_keymap('s', '<S-Tab>', 'vsnip#jumpable(-1) ? "<Plug>(vsnip-jump-prev)" : "<S-Tab>"', {expr = true, noremap = true})

  -- keymaps about lsp
  vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, { noremap=true, silent=true })
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { noremap=true, silent=true })
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { noremap=true, silent=true })

  vim.keymap.set('n', 'K', '<cmd>Lspsaga hover_doc<CR>')
  vim.keymap.set("n", "ga", "<cmd>Lspsaga code_action<CR>")
  vim.keymap.set('n', 'gr', '<cmd>Lspsaga lsp_finder<CR>')
  vim.keymap.set("n", "gd", "<cmd>Lspsaga peek_definition<CR>")
  vim.keymap.set("n", "gn", "<cmd>Lspsaga rename<CR>")
  vim.keymap.set("n", "ge", "<cmd>Lspsaga show_line_diagnostics<CR>")
  vim.keymap.set("n", "gw", "<cmd>Lspsaga show_workspace_diagnostics<CR>")
  vim.keymap.set("n", "[e", "<cmd>Lspsaga diagnostic_jump_next<CR>")
  vim.keymap.set("n", "]e", "<cmd>Lspsaga diagnostic_jump_prev<CR>")
end
