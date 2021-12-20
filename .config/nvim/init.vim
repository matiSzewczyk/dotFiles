syntax on
set number
set autoread
set relativenumber
set guicursor=
set noerrorbells
set tabstop=4 softtabstop=4
set shiftwidth=4
set smartindent
set nohlsearch
set nowrap
set noswapfile
set nobackup
set scrolloff=5
set incsearch
set clipboard=unnamed
set signcolumn=no
set undodir=~/nvim/undo
set undofile
"set laststatus=0 "hide the statusline

" This is for html and css completion
filetype plugin indent on
set omnifunc=syntaxcomplete#Complete

" Use <Tab> and <S-Tab> to navigate through completion menu
"inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
"inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

call plug#begin('~/.vim/plugged')

" Autocompletion
"Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'

Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'

" For vsnip users.
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

" Easier navigation in files for big projects
Plug 'preservim/nerdtree' 

" Telescope
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'mfussenegger/nvim-jdtls'

" Better comments
Plug 'preservim/nerdcommenter'

" Colorscheme
Plug 'fratajczak/one-monokai-vim'

" Indent lines
Plug 'yggdroot/indentline'

" Spaceline
Plug 'glepnir/spaceline.vim'

" CSS color highlight
Plug 'ap/vim-css-color' 

" Treesitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Rainbow brackets
Plug 'p00f/nvim-ts-rainbow'

" Better icons - always last
Plug 'ryanoasis/vim-devicons'

call plug#end()

" True color support
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
set termguicolors
let $NVIM_TUI_ENABLE_TRUE_COLOR=1

let g:rehash256 = 1

" Theme
colorscheme one-monokai
let g:spaceline_colorscheme = 'one'
let g:spaceline_seperate_style = 'slant'
hi Normal guibg=none
hi LineNr guibg=none

" COC diagnostics
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
nmap <silent>gd <Plug>(coc-definition)

" NerdTree open
map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
autocmd StdinReadPre * let s:std_in=1

" NerdTree refresh
nmap <Leader>r :NERDTreeFocus<cr>R<c-w><c-p>

" Indent line characters
let g:indentLine_char_list = ['|', '|', '|', '|']

" Auto load tree sitter syntax 
lua require'nvim-treesitter.configs'.setup { highlight = { enable = true } }

" Telescope keybinds
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" NVIM LSP
lua <<EOF
  -- Setup nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end,
    },

    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    })
  })

  -- Setup lspconfig.
  local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
  require('lspconfig')['clangd'].setup {
    capabilities = capabilities
  }
  require('lspconfig')['pyright'].setup {
    capabilities = capabilities
  }
  require('lspconfig')['tsserver'].setup {
    capabilities = capabilities
  }
  require('lspconfig')['kotlin_language_server'].setup {
    capabilities = capabilities
  }
EOF

" Rainbow brackets
lua << EOF
require("nvim-treesitter.configs").setup {
	hightlight = {
	},

	rainbow = {
		enable = true,
		extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
		max_file_lines = nil -- Do not enable for files with more than n lines, int
	}
}
EOF
