set number 
set relativenumber 
set autoindent 
set shiftwidth=2 
set scrolloff=8 
set smarttab 
set mouse=a 
set termguicolors 
set completeopt=menu,menuone,noselect 
set listchars=tab:>·,space:· 
set list 
set formatoptions-=cro

set wildignore+=node_modules/**,.git/**
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg,*.webp,*.pdf

" noh - no highlight
map <esc> :noh <CR>

" Change default keybinding
" Change map leader
let mapleader = " "
" Ctrl-j/k deletes blank line below/above, and Alt-j/k inserts.
nnoremap <silent><C-j> m`:silent +g/\m^\s*$/d<CR>``:noh<CR>
nnoremap <silent><C-k> m`:silent -g/\m^\s*$/d<CR>``:noh<CR>
nnoremap <silent><A-j> :set paste<CR>m`o<Esc>``:set nopaste<CR>
nnoremap <silent><A-k> :set paste<CR>m`O<Esc>``:set nopaste<CR>
"Undo break points
inoremap , ,<c-g>u
inoremap . .<c-g>u
inoremap ! !<c-g>u
inoremap ? ?<c-g>u

" Record macros
nnoremap <Leader> @q

autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

"plugins
call plug#begin()
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
Plug 'tpope/vim-fugitive'
Plug 'jose-elias-alvarez/nvim-lsp-ts-utils'
Plug 'nvim-lualine/lualine.nvim'
Plug 'jose-elias-alvarez/null-ls.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'tpope/vim-commentary'
Plug 'nvim-telescope/telescope.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'tpope/vim-obsession'
Plug 'f-person/git-blame.nvim'
Plug 'tpope/vim-unimpaired'
Plug 'romgrk/barbar.nvim'
Plug 'xiyaowong/nvim-transparent'
Plug 'tpope/vim-vinegar'
Plug 'akinsho/toggleterm.nvim'
Plug 'nelstrom/vim-visual-star-search'
Plug 'wellle/targets.vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'heavenshell/vim-jsdoc', {
  \ 'for': ['javascript', 'javascript.jsx', 'typescript.tsx', 'typescript'],
  \ 'do': 'make install'
\}
Plug 'github/copilot.vim'
call plug#end()

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

"colorsscheme
let g:tokyonight_style = "night"
colorscheme tokyonight

" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files hidden=true<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

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
capabilities.textDocument.completion.completionItem.snippetSupport = true

local opts = { noremap=true, silent=true }
local ts_utils = require('nvim-lsp-ts-utils')

-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
vim.api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

local on_attach = function(client, bufnr)
    ts_utils.setup({
	auto_inlay_hints = false
    })

    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>a', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)

    if client.name == 'tsserver' then
	    -- nvim-lsp-ts-utils mappings
	    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gf', ':TSLspRenameFile<CR>', opts)
	    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gs', ':TSLspOrganize<CR>', opts)
	    client.resolved_capabilities.document_formatting = false
	    client.resolved_capabilities.document_range_formatting = false
    end

    if client.name == 'rust_analyzer' then
	    client.resolved_capabilities.document_formatting = false
	    client.resolved_capabilities.document_range_formatting = false
    end


    if client.resolved_capabilities.document_formatting then
	vim.cmd([[
	    augroup LspFormatting
		autocmd! * <buffer>
		autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
	    augroup END
	]])
    end
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

-- Enable tailwindCSS language server
require'lspconfig'.tailwindcss.setup{}

-- Enable HTML language server
require'lspconfig'.html.setup {
  capabilities = capabilities,
}

require'lspconfig'.rust_analyzer.setup{
    on_attach = on_attach,
    capabilities = capabilities,
}

--- Setup treesitter.
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
  },
}

-- Setup null-ls
local null_ls = require('null-ls')
null_ls.setup({
    debug = false,
    sources = {
	null_ls.builtins.formatting.prettierd,
        null_ls.builtins.formatting.rustfmt,
	null_ls.builtins.formatting.shellharden,
	null_ls.builtins.code_actions.shellcheck,
    },
    on_attach = on_attach,
})
EOF

lua << END
-- Setup Lualine
local function line_total()
    return vim.api.nvim_buf_line_count(vim.fn.winbufnr(
      vim.g.statusline_winid))
end

require('lualine').setup({
    options = { 
	theme = 'ayu_mirage',
	section_separators = '',
	component_separators = '',
    },
    sections = {
	lualine_c = {
	  {
	      'filename',
	      path = 1
	  }
	},
	lualine_y = {line_total},
	lualine_z = {'ObsessionStatus'}
    }
})
END

lua << END
-- barbar mappings
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Move to previous/next
map('n', '<A-,>', ':BufferPrevious<CR>', opts)
map('n', '<A-.>', ':BufferNext<CR>', opts)
-- Re-order to previous/next
map('n', '<A-<>', ':BufferMovePrevious<CR>', opts)
map('n', '<A->>', ' :BufferMoveNext<CR>', opts)
-- Goto buffer in position...
map('n', '<A-1>', ':BufferGoto 1<CR>', opts)
map('n', '<A-2>', ':BufferGoto 2<CR>', opts)
map('n', '<A-3>', ':BufferGoto 3<CR>', opts)
map('n', '<A-4>', ':BufferGoto 4<CR>', opts)
map('n', '<A-5>', ':BufferGoto 5<CR>', opts)
map('n', '<A-6>', ':BufferGoto 6<CR>', opts)
map('n', '<A-7>', ':BufferGoto 7<CR>', opts)
map('n', '<A-8>', ':BufferGoto 8<CR>', opts)
map('n', '<A-9>', ':BufferGoto 9<CR>', opts)
map('n', '<A-0>', ':BufferLast<CR>', opts)
-- Close buffer
map('n', '<A-c>', ':BufferClose<CR>', opts)
-- Wipeout buffer
--                 :BufferWipeout<CR>
-- Close commands
--                 :BufferCloseAllButCurrent<CR>
--                 :BufferCloseBuffersLeft<CR>
--                 :BufferCloseBuffersRight<CR>
-- Magic buffer-picking mode
map('n', '<C-p>', ':BufferPick<CR>', opts)
-- Sort automatically by...
map('n', '<Space>bb', ':BufferOrderByBufferNumber<CR>', opts)
map('n', '<Space>bd', ':BufferOrderByDirectory<CR>', opts)
map('n', '<Space>bl', ':BufferOrderByLanguage<CR>', opts)

-- Other:
-- :BarbarEnable - enables barbar (enabled by default)
-- :BarbarDisable - very bad command, should never be used
END


lua << END
require("transparent").setup({
  enable = true, -- boolean: enable transparent
  extra_groups = { -- table/string: additional groups that should be clear
    -- In particular, when you set it to 'all', that means all avaliable groups
  },
  exclude = {}, -- table: groups you don't want to clear
})
END


lua << END
require('toggleterm').setup{
  size = 15,
  open_mapping = [[<c-\>]],
  shade_terminals = true,
  shading_factor = 3,
  start_in_insert = true,
  persist_size = true,
  direction = 'horizontal'
}
END
