set number
set relativenumber
set autoindent
set shiftwidth=4
set scrolloff=8
set smarttab
set mouse=a
set termguicolors
set completeopt=menu,menuone,noselect

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
call plug#end()

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

"colorsscheme
let g:tokyonight_style = "night"
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
local ts_utils = require('nvim-lsp-ts-utils')

local on_attach = function(client, bufnr)
    ts_utils.setup({
	auto_inlay_hints = false
    })

    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>a', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    -- nvim-lsp-ts-utils mappings
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gf', ':TSLspRenameFile<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gs', ':TSLspOrganize<CR>', opts)

    if client.name == 'tsserver' then
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

--- Setup treesitter.
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
  },
}

-- Setup null-ls
require('null-ls').setup({
    debug = true,
    sources = {
--	require('null-ls').builtins.code_actions.xo,
--	require('null-ls').builtins.diagnostics.xo,
	require('null-ls').builtins.formatting.prettier
    },
    on_attach = on_attach,
})
EOF

lua << END
-- Setup Lualine
require('lualine').setup({
    options = { 
	theme = 'ayu_mirage',
	section_separators = '',
	component_separators = '',
    },
    sections = {
	lualine_y = {},
    }
})
END
