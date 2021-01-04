call plug#begin('~/.vim/plugged')
" General
Plug 'itchyny/lightline.vim'
Plug 'lokaltog/vim-powerline'
Plug 'ryanoasis/vim-devicons'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'altercation/vim-colors-solarized'
Plug 'junegunn/goyo.vim'

" startscreen
Plug 'mhinz/vim-startify'

" theme
Plug 'joshdick/onedark.vim'
Plug 'morhetz/gruvbox'
Plug 'pineapplegiant/spaceduck'

" fuzzy finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" git
Plug 'tpope/vim-fugitive'
Plug 'jreybert/vimagit'
Plug 'junegunn/gv.vim'

" preview
Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }
Plug 'ashisha/image.vim'

" javascipt
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'

" IDE
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'airblade/vim-gitgutter'
Plug 'scrooloose/nerdcommenter'
Plug 'chiel92/vim-autoformat'
Plug 'luchermitte/vim-refactor'
Plug 'vim-syntastic/syntastic'

" syntax
Plug 'sheerun/vim-polyglot'
Plug 'godlygeek/tabular'
Plug 'editorconfig/editorconfig-vim'

" react
"Plug 'tasn/vim-tsx'

" flutter
Plug 'hankchiutw/flutter-reload.vim'

" LaTeX
Plug 'lervag/vimtex'

" Tag autoclose
Plug 'alvan/vim-closetag'
Plug 'tpope/vim-surround'

call plug#end()

" leader
let mapleader=" "

" system clipboard
set clipboard+=unnamedplus

" simple
colorscheme gruvbox
syntax on
set laststatus=2
set encoding=UTF-8
set number
set tabpagemax=15
set mouse=a
set relativenumber

" truecolor
if (has("termguicolors"))
	set termguicolors
endif

" highlight selected line
set cursorline

" jump to last line
if has("autocmd")
	au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" replace
nmap <leader>r :%s//gI<Left><Left><Left>

" fuzzy finder
let g:fzf_commands_expect = 'ctrl-x'
map <c-p> :FZF<CR>

" search file names
nmap <leader><C-f> :Rg<CR>

" spellcheck
nmap <leader><F6>g :setlocal spell spelllang=de_ch<CR>
nmap <leader><F6>e :setlocal spell spelllang=en_us<CR>

" file switcher
filetype plugin on
autocmd BufReadPre,FileReadPre *.ts set ft=typescript
autocmd BufReadPre,FileReadPre *.html set ft=html
autocmd BufReadPre,FileReadPre *.scss set ft=scss

" goyo
nmap <leader>g :Goyo<CR>

" latex
let g:tex_flavor = 'latex'

" IDE
let g:coc_global_extensions = [
			\ 'coc-snippets',
			\ 'coc-pairs',
			\ 'coc-tsserver',
			\ 'coc-vetur',
			\ 'coc-eslint',
			\ 'coc-prettier',
			\ 'coc-json',
			\ 'coc-java',
			\ 'coc-phpls',
			\ 'coc-css',
			\ 'coc-vetur',
			\ 'coc-eslint',
			\ 'coc-flutter',
			\ 'coc-go',
			\ 'coc-rust-analyzer'
			\ ]
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <F2> <Plug>(coc-rename)
nmap <C-_> <plug>NERDCommenterToggle

" syntastic
let g:syntastic_java_checkers = ['checkstyle']
let g:syntastic_java_checkstyle_classpath = '/data/home/michael/tools/checkstyle-8.27.jar'
let g:syntastic_java_checkstyle_conf_file = '/data/home/michael/Documents/java/smash/groupsync-service/conf/checkstyle/checkstyle.xml'
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Fix broken
nmap <leader>q :CocFix<CR>

command! -nargs=0 Prettier :CocCommand prettier.formatFile
"autocmd BufWritePre * :Autoformat
nmap <leader>f :Autoformat<CR>

" preview
let g:Hexokinase_highlighters = ['sign_column']

" Tag autoclose
let g:closetag_filenames = '*.html,*.xhtml,*.php,*.blade.php,*.js,*.vue'
let g:closetag_xhtml_filenames = '*.html,*.xhtml,*.php,*.blade.php,*.js,*.vue'

" filetree

let g:nerdtree_is_open = 0
function! ToggleNerdTree()
	if g:nerdtree_is_open
		NERDTreeClose
		let g:nerdtree_is_open = 0
	else
		if @% == ""
			NERDTreeToggle
		else
			NERDTreeFind
		endif
		let g:nerdtree_is_open = 1
	endif
endfunction
nmap <C-b> :call ToggleNerdTree()<CR>

let NERDTreeWinSize = 40
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

" git
let g:gitgutter_terminal_reports_focus=0

" line
let g:lightline = {
			\ 'colorscheme': 'gruvbox',
			\   'active': {
			\     'left':[ [ 'mode', 'paste' ],
			\              [ 'gitbranch', 'readonly', 'filename', 'modified' ]
			\     ]
			\   },
			\   'component': {
			\     'lineinfo': ' %3l:%-2v',
			\   },
			\   'component_function': {
			\     'gitbranch': 'fugitive#head',
			\   }
			\ }
let g:lightline.separator = {
			\   'left': '', 'right': ''
			\}
let g:lightline.subseparator = {
			\   'left': '', 'right': ''
			\}
