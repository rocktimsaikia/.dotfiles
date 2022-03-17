set number
set relativenumber
set autoindent
set shiftwidth=4
set scrolloff=8
set smarttab
set mouse=a
set termguicolors
set completeopt=menu,menuone,noselect

"change default keybinding
imap jj <Esc>
let mapleader = " "
nnoremap <Leader>o o<esc>
nnoremap <Leader>O O<esc>


"plugins
call plug#begin()
Plug 'junegunn/goyo.vim'
Plug 'junegunn/vim-easy-align'
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
Plug 'jiangmiao/auto-pairs'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
Plug 'tpope/vim-surround'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/nvim-cmp'
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'rafamadriz/friendly-snippets'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'onsails/lspkind-nvim'
call plug#end()

function! s:goyo_enter()
  let b:quitting = 0
  let b:quitting_bang = 0
  autocmd QuitPre <buffer> let b:quitting = 1
  cabbrev <buffer> q! let b:quitting_bang = 1 <bar> q!
endfunction

function! s:goyo_leave()
  "Quit Vim if this is the only remaining buffer
  if b:quitting && len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1
    if b:quitting_bang
      qa!
    else
      qa
    endif
  endif
endfunction

"start gogo when vim starts
autocmd! User GoyoEnter call <SID>goyo_enter()
autocmd! User GoyoLeave call <SID>goyo_leave()

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

"colorsscheme
colorscheme tokyonight

lua << EOF
--- Setup nvim-cmp.
local cmp = require('cmp')

local lspkind = require("lspkind")
local source_mapping = {
	nvim_lsp    = "[LSP]",
	nvim_lua    = "[Lua]",
}

cmp.setup({
    snippet = {
    expand = function(args)
	require('luasnip').lsp_expand(args.body)
    end,
    },

    formatting = {
	format = lspkind.cmp_format({
	    mode = 'text_symbol',
	    maxwidth = 50,
	    before = function(entry, vim_item)
		local menu = source_mapping[entry.source.name]
		vim_item.menu = menu
		return vim_item
	    end 
	})
    },

    mapping = {
	['<Tab>'] = cmp.mapping.confirm({ select = true }),
    },
    sources = cmp.config.sources({
	{ name = 'nvim_lsp' },
	{ name = 'luasnip' },
    }),
})

-- load vs-code style snippets from "friendly-snippet" https://github.com/rafamadriz/friendly-snippets
require("luasnip.loaders.from_vscode").lazy_load()

--- Setup lspconfig.
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

local opts = { noremap=true, silent=true }

local on_attach = function(client, bufnr)
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
end

--- decorate the hover menu border
local handlers = {
    ['textDocument/hover'] =  vim.lsp.with(vim.lsp.handlers.hover, {border = 'rounded'}),
}

require'lspconfig'.tsserver.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    handlers = handlers
}

--- Setup treesitter.
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
  },
}
EOF

