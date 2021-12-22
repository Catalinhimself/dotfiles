" Bootstrap Plug
let autoload_plug_path = stdpath('data') . '/site/autoload/plug.vim'
if !filereadable(autoload_plug_path)
  silent execute '!curl -fLo ' . autoload_plug_path . '  --create-dirs
      \ "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
unlet autoload_plug_path

"" plugins
call plug#begin('~/.local/share/nvim/plugged')
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'tpope/vim-surround' " usseful sometimes, but hard to remember ysw' to add surounding
Plug 'wakatime/vim-wakatime' " count time using vim in each file
Plug 'gruvbox-community/gruvbox' " sexy color scheme
Plug 'vim-airline/vim-airline' " bottom line
Plug 'mbbill/undotree' " leader u
Plug 'preservim/nerdtree' " leader n
Plug 'tpope/vim-commentary'
Plug 'ap/vim-css-color' " preview colors in some fies
Plug 'frazrepo/vim-rainbow'
Plug 'jiangmiao/auto-pairs' " I ussualy don't like it
Plug 'vimwiki/vimwiki' " great note taking experience
Plug 'dhruvasagar/vim-table-mode' " good looking tables
Plug 'ThePrimeagen/vim-be-good' " game that encourage to use relative number
Plug 'wfxr/minimap.vim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'ryanoasis/vim-devicons'
Plug 'neovim/nvim-lspconfig'
Plug 'junegunn/goyo.vim'
Plug 'farmergreg/vim-lastplace'
Plug 'szw/vim-maximizer'
" Plug 'puremourning/vimspector'
call plug#end()

""plugin settings
let g:airline_powerline_fonts=0
let g:rainbow_active = 1
colorscheme gruvbox
let maplocalleader=";"
let g:vimwiki_list = [{'path': '~/Documents/notes/',
						\'syntax': 'markdown', 'ext': '.md'}]
let g:minimap_width = 10
" let g:minimap_auto_start = 1
let g:minimap_auto_start_win_enter = 1
let g:NERDTreeWinSize=15

lua << EOF
local previewers = require("telescope.previewers")
require('telescope').setup{
 defaults = {
        file_sorter = require("telescope.sorters").get_fzy_sorter,
        prompt_prefix = " ❯",
        color_devicons = true,

        file_previewer = require("telescope.previewers").vim_buffer_cat.new,
        grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
        qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
		layout_config = {
				preview_cutoff = 10,
			},
        },
extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                       -- the default case_mode is "smart_case"
    }
  }
}
require('telescope').load_extension('fzf')
EOF

lua << EOF
require'lspconfig'.pyright.setup{}
require'lspconfig'.rust_analyzer.setup{}
require'lspconfig'.clangd.setup{}
EOF
let g:vimspector_enable_mappings = 'HUMAN'

"" settings
syntax on
set noerrorbells
set clipboard+=unnamedplus
set mouse=a
set wildmode=longest,list,full
set encoding=utf-8
set number relativenumber
set tabstop=4 softtabstop=4
set shiftwidth=4
set smartindent
set nowrap
set linebreak
set nobackup
set nowritebackup
set noswapfile
set undodir=~/.local/share/nvim/undodir
set undofile
set incsearch
set ignorecase
set colorcolumn=80
set scrolloff=10
highlight ColorColumn ctermbg=darkgrey
:hi CursorLine   cterm=NONE ctermbg=238
:hi CursorColumn cterm=NONE ctermbg=238
set noshowcmd noruler "" no lag or something
" whitespace character vizualization
" ○°
set listchars=eol:¶,tab:<->,space:°,trail:°,extends:>,precedes:<

:hi GroupSpace ctermfg=50
:hi GroupTab ctermfg=197
:hi GroupN ctermfg=63
:call matchadd("GroupN", '\n')
:call matchadd("GroupSpace", ' ')
:call matchadd("GroupTab", '\t')

""bindings
let g:mapleader="\<Space>"
let mapleader = " "
nnoremap <silent> <Leader>x :set cursorline! cursorcolumn!<CR>
nnoremap <silent> <Leader>p :set list!<CR>
nnoremap <leader>v :<C-u>call ToggleVirtualedit()<cr>
nnoremap <leader>r :w<cr>:call RunFile()<cr>
nnoremap <leader>n :NERDTreeToggle<CR>
nnoremap <leader>u :UndotreeToggle<CR>
nnoremap <leader>z :MinimapToggle<CR>
nnoremap <leader>a :set wrap!<CR>
nnoremap <leader>cl BufWritePre * %s/\s\+$//e<cr>
nnoremap <silent> <leader>mc :silent! execute '!markdown-folder-to-html ~/Documents/notes/'<cr>
nnoremap <silent> <leader>md :call PreviewMD()<cr>
nnoremap <silent> <leader>mm :MaximizerToggle<cr>
nnoremap <leader>s :w <cr>:!xelatex main.tex<cr>
nnoremap <leader>br :silent exec '!"$BROWSER" % &'<cr>
nnoremap <leader>o o<Esc>
nnoremap <leader>O O<Esc>
nnoremap Y y$
nnoremap <leader>d :r!date +\%d_\%b_\%Y<cr>:norm I[<cr>:norm A]<cr>:r!date +\%d_\%b_\%Y<cr>:norm I(<cr>:norm A.md)<cr>:norm kJx<cr>
nnoremap <leader>t :r!date +\%T<cr>:norm I[<cr>:norm A]<cr>
nnoremap <leader>e :e %:h/
inoremap ZZ <esc>:x<cr>
inoremap jk <esc>
inoremap :w <esc>:w<cr>
" nnoremap <silent> <Leader>f :Files<CR>
" nnoremap <silent> <Leader>g :Rg<CR>
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
tnoremap <Esc> <C-\><C-n>
noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
vnoremap < <gv
vnoremap > >gv


""autocmd settings
autocmd InsertEnter * norm zz
" autocmd BufWritePre * %s/\s\+$//e
autocmd BufEnter NERD_tree_* | execute 'normal R'
augroup Mkdir
  autocmd!
  autocmd BufWritePre * call mkdir(expand("<afile>:p:h"), "p")
augroup END
" transparent bg
" autocmd vimenter * hi Normal guibg=NONE ctermbg=NONE


""functions
"" Will compile my markdown notes folder and open the curent page which is html
function PreviewMD()
	silent! execute '!markdown-folder-to-html ~/Documents/notes/'
	silent! execute "!echo %:p | sed 's/notes/_notes/' | sed 's/md/html/' | xargs $BROWSER"
endfunction

"" virtualedit does not support ! toggle
function ToggleVirtualedit()
if &virtualedit ==# ""
	set virtualedit=all
else
	set virtualedit=""
endif
endfunction

"" To automatically compile and or run source code
function! RunFile()
  if match(@%, '.rb$') != -1
    exec '!ruby % '
  elseif match(@%, '.py$') != -1
    exec '!python % '
  elseif match(@%, '.cpp$') != -1
    exec '!g++ % '
    exec '!./a.out'
  elseif match(@%, '.c$') != -1
    exec '!g++ % '
    exec '!./a.out'
  elseif match(@%, '.cs$') != -1
	exec '!mcs % '
	exec '!mono %:r '
  elseif match(@%, '.sh$') != -1
	exec '!sh % '
  elseif match(@%, '.rs$') != -1
	    if !empty(glob('../Cargo.lock')) && !isdirectory('../Cargo.lock')
			exec '!cargo run'
		elseif !empty(glob('Cargo.lock')) && !isdirectory('Cargo.lock')
			exec '!cargo run'
		else
			exec '!rustc % '
			exec '!./%:r'
	  endif
  else
    echo '<< ERROR >> RunFile() only supports rb, py, cpp, c, rs'
  endif
endfunction

