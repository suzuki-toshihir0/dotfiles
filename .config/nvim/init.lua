vim.scriptencoding = 'utf-8'
vim.opt.encoding = 'utf-8'
vim.opt.fileencoding = 'utf-8'

vim.opt.number = true
vim.wo.number = true
vim.wo.relativenumber = false
vim.opt.mouse = 'a'
vim.opt.title = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.hlsearch = true
vim.opt.backup = false
vim.opt.showcmd = true
vim.opt.cmdheight = 2
vim.opt.laststatus = 2
vim.opt.expandtab = true
vim.opt.scrolloff = 10
vim.opt.shell = 'zsh'
vim.opt.inccommand = 'split'
vim.opt.ignorecase = true
vim.opt.smarttab = true
vim.opt.breakindent = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.wrap = true
vim.opt.helplang = 'ja', 'en'
vim.opt.updatetime = 300
vim.opt.showtabline = 2
vim.opt.clipboard = 'unnamedplus'
vim.opt.termguicolors = true
vim.opt.signcolumn = 'yes'
vim.opt.hidden = true
vim.opt.swapfile = false
vim.opt.wrap = true
vim.opt.list = true
vim.opt.listchars = { tab = '>-', space = '·', trail = '·' }

vim.keymap.set('n', 'ss', ':split<Return><C-w>w')
vim.keymap.set('n', 'sv', ':vsplit<Return><C-w>w')
vim.keymap.set('n', 'sh', '<C-w>h')
vim.keymap.set('n', 'sk', '<C-w>k')
vim.keymap.set('n', 'sj', '<C-w>j')
vim.keymap.set('n', 'sl', '<C-w>l')

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

-- clipboard
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

-- Apply the colorscheme
vim.cmd 'colorscheme tokyonight-moon'

-- Telescope key mapping
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

local builtin = require('telescope.builtin')
vim.api.nvim_set_keymap('n', '<leader>ff', ':Telescope find_files find_command=rg,--files,--hidden,--glob,!*.git <CR>', { noremap = true, silent = true })
-- vim.keymap.set('n', '<leader>ff', builtin.find_files, {find_command="rg"})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

vim.keymap.set('n', '<C-j>', '<Cmd>BufferPrevious<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-k>', '<Cmd>BufferNext<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>e', '<Cmd>BufferClose<CR>', { noremap = true, silent = true })

-- Gitsign setup
require('gitsigns').setup()

-- rust.vim settings
vim.cmd('syntax enable')
vim.cmd('filetype plugin indent on')
vim.g.rustfmt_autosave = 1

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
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
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

vim.api.nvim_set_keymap('i', '<Tab>', 'vsnip#jumpable(1) ? "<Plug>(vsnip-jump-next)" : "<Tab>"', {expr = true, noremap = true})
vim.api.nvim_set_keymap('s', '<Tab>', 'vsnip#jumpable(1) ? "<Plug>(vsnip-jump-next)" : "<Tab>"', {expr = true, noremap = true})
vim.api.nvim_set_keymap('i', '<S-Tab>', 'vsnip#jumpable(-1) ? "<Plug>(vsnip-jump-prev)" : "<S-Tab>"', {expr = true, noremap = true})
vim.api.nvim_set_keymap('s', '<S-Tab>', 'vsnip#jumpable(-1) ? "<Plug>(vsnip-jump-prev)" : "<S-Tab>"', {expr = true, noremap = true})

-- LSP config
-- It's important that you set up the plugins in the following order:
--
-- 1. `mason.nvim`
require("mason").setup()
-- 2. `mason-lspconfig.nvim`
require("mason-lspconfig").setup({
  ensure_installed = {"lua_ls", "clangd", "rust_analyzer", "julials", "typst_lsp", "typos_lsp", "pyright"}
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
    ["typst_lsp"] = function()
      require'lspconfig'.typst_lsp.setup{
        settings = {
          exportPdf = "onType" -- Choose onType, onSave or never.
        -- serverPath = "" -- Normally, there is no need to uncomment it.
        }
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

-- dap
require ('mason-nvim-dap').setup({
    ensure_installed = {'codelldb', 'cpptools', 'probe-rs'},
    automatic_installation = true,
    handlers = {}, -- sets up dap in the predefined manner
})

local dap = require('dap')

-- point dap to the installed cpptools, if you don't use mason, you'll need to change `cpptools_path`
local cpptools_path = vim.fn.stdpath("data").."/mason/packages/cpptools/extension/debugAdapters/bin/OpenDebugAD7"
dap.adapters.cppdbg = {
    id = 'cppdbg',
    type = 'executable',
    command = cpptools_path,
}

require("dap").configurations = {
  cpp = {
    {
      name = "launch codelldb",
      type = "codelldb",
      request = "launch",
      program = function()
        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/EXECUTABLE', 'file')
      end,
      cwd = function()
        return vim.fn.input('Path to cwd: ', vim.fn.getcwd() .. '/CWD', 'file')
      end,
    },
    {
      name= "rr",
      type= "cppdbg",
      request= "launch",
      program = function()
        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/EXECUTABLE', 'file')
      end,
      args= {},
      -- miDebuggerPath = "/usr/bin/gdb",
      miDebuggerServerAddress= "127.0.0.1:50505",
      stopAtEntry= false,
      cwd = function()
        return vim.fn.input('Path to cwd: ', vim.fn.getcwd() .. '/CWD', 'file')
      end,
      environment= {},
      externalConsole= true,
      MIMode= "gdb",
      setupCommands= {
          {
              description= "Setup to resolve symbols",
              text= "set sysroot /",
              ignoreFailures= false
          },
          {
             description= "Enable pretty-printing for gdb",
             text= "-enable-pretty-printing",
             ignoreFailures= false
          }
      },
    }
  }
}

vim.keymap.set("n", "<F5>", require("dap").continue, { desc = "Debug: Start/Continue" })
vim.keymap.set("n", "<F11>", require("dap").step_into, { desc = "Debug: Step Into" })
vim.keymap.set("n", "<F10>", require("dap").step_over, { desc = "Debug: Step Over" })
vim.keymap.set("n", "<F9>", require("dap").step_out, { desc = "Debug: Step Out" })
vim.keymap.set("n", "<leader>b", require("dap").toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })

local rr_dap = require("nvim-dap-rr")
rr_dap.setup({
    mappings = {
        -- you will probably want to change these defaults to that they match
        -- your usual debugger mappings
        continue = "<F5>",
        step_over = "<F10>",
        step_out = "<F9>",
        step_into = "<F11>",
        reverse_continue = "<S-F5>", -- <S-F5>
        reverse_step_over = "<S-F10>", -- <S-F10>
        reverse_step_out = "<S-F9>", -- <S-F9>
        reverse_step_into = "<S-F11>", -- <S-F11>
        -- instruction level stepping
        -- step_over_i = "<F32>", -- <C-F8>
        -- step_out_i = "<F33>", -- <C-F8>
        -- step_into_i = "<F34>", -- <C-F8>
        -- reverse_step_over_i = "<F44>", -- <SC-F8>
        -- reverse_step_out_i = "<F45>", -- <SC-F9>
        -- reverse_step_into_i = "<F46>", -- <SC-F10>
    }
})

-- require("dap").configurations.rust = { rr_dap.get_rust_config() }
rr_dap.get_config()

-- probe-rs
dap.adapters["probe-rs-debug"] = {
  type = "server",
  port = "${port}",
  executable = {
    command = vim.fn.expand "$HOME/.cargo/bin/probe-rs",
    args = { "dap-server", "--port", "${port}" },
  },
}

require("dap.ext.vscode").type_to_filetypes["probe-rs-debug"] = { "rust" }

dap.listeners.before["event_probe-rs-rtt-channel-config"]["plugins.nvim-dap-probe-rs"] = function(session, body)
  local utils = require "dap.utils"
  utils.notify(
    string.format('probe-rs: Opening RTT channel %d with name "%s"!', body.channelNumber, body.channelName)
  )
  local file = io.open("probe-rs.log", "a")
  if file then
    file:write(
      string.format(
        '%s: Opening RTT channel %d with name "%s"!\n',
        os.date "%Y-%m-%d-T%H:%M:%S",
        body.channelNumber,
        body.channelName
      )
    )
  end
  if file then file:close() end
  session:request("rttWindowOpened", { body.channelNumber, true })
end

dap.listeners.before["event_probe-rs-rtt-data"]["plugins.nvim-dap-probe-rs"] = function(_, body)
  local message =
    string.format("%s: RTT-Channel %d - Message: %s", os.date "%Y-%m-%d-T%H:%M:%S", body.channelNumber, body.data)
  local repl = require "dap.repl"
  repl.append(message)
  local file = io.open("probe-rs.log", "a")
  if file then file:write(message) end
  if file then file:close() end
end

dap.listeners.before["event_probe-rs-show-message"]["plugins.nvim-dap-probe-rs"] = function(_, body)
  local message = string.format("%s: probe-rs message: %s", os.date "%Y-%m-%d-T%H:%M:%S", body.message)
  local repl = require "dap.repl"
  repl.append(message)
  local file = io.open("probe-rs.log", "a")
  if file then file:write(message) end
  if file then file:close() end
end

require("dap.ext.vscode").load_launchjs(nil, {
  ["probe-rs-debug"] = { "rust" }
})

require("dapui").setup{
  -- Set icons to characters that are more likely to work in every terminal.
  --    Feel free to remove or use ones that you like more! :)
  --    Don't feel like these are good choices.
  icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
  controls = {
    icons = {
      pause = '⏸',
      play = '▶',
      step_into = '⏎',
      step_over = '⏭',
      step_out = '⏮',
      step_back = 'b',
      run_last = '▶▶',
      terminate = '⏹',
      disconnect = '⏏',
    },
  },
}

vim.keymap.set("n", "<F7>", require("dapui").toggle, { desc = "Debug: See last session result." })

vim.fn.sign_define('DapBreakpoint', {text='🛑', texthl='DapUIStop', linehl='', numhl=''})
vim.fn.sign_define('DapStopped', {text='→', texthl='DapUIStop', linehl='CursorLine', numhl=''})

require("dap").listeners.after.event_initialized['dapui_config'] = require("dapui").open
require("dap").listeners.before.event_terminated['dapui_config'] = require("dapui").close
require("dap").listeners.before.event_exited['dapui_config'] = require("dapui").close

-- neorepl
vim.keymap.set('n', 'g:', function()
  -- get current buffer and window
  local buf = vim.api.nvim_get_current_buf()
  local win = vim.api.nvim_get_current_win()
  -- create a new split for the repl
  vim.cmd('split')
  -- spawn repl and set the context to our buffer
  require('neorepl').new{
    lang = 'vim',
    buffer = buf,
    window = win,
  }
  -- resize repl window and make it fixed height
  vim.cmd('resize 10 | setl winfixheight')
end)

-- vim-github-link
vim.keymap.set({'v', 'n'}, '<leader>gl', ':GetCommitLink<CR>')
