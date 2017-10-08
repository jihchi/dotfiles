" vim-plug (https://github.com/junegunn/vim-plug) settings
" Automatically install vim-plug and run PlugInstall if vim-plug not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" A small sensible Vim configuration
Plug 'tpope/vim-sensible'
" Plugin outside ~/.vim/plugged with post-update hook
" brew install the_silver_searcher
" brew install fzf
" https://github.com/junegunn/fzf#respecting-gitignore-hgignore-and-svnignore
Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'
" Things you can do with fzf and Vim.
Plug 'junegunn/fzf.vim'
" Lean & mean status/tabline for vim that's light as air.
Plug 'vim-airline/vim-airline'
" quoting/parenthesizing made simple
Plug 'tpope/vim-surround'
" A Vim plugin which shows a git diff in the gutter (sign column) and stages/undoes hunks.
Plug 'airblade/vim-gitgutter'
" fugitive.vim: a Git wrapper so awesome, it should be illegal
Plug 'tpope/vim-fugitive'
" Better whitespace highlighting for Vim
Plug 'ntpeters/vim-better-whitespace'
" JavaScript bundle for vim, this bundle provides syntax highlighting and improved indentation.
Plug 'pangloss/vim-javascript'
" React JSX syntax highlighting and indenting for vim.
Plug 'mxw/vim-jsx'
" Chained completion that works the way you want!
Plug 'lifepillar/vim-mucomplete'
" UltiSnips is the ultimate solution for snippets in Vim.
Plug 'SirVer/ultisnips'
" This repository contains snippets files for various programming languages.
Plug 'honza/vim-snippets'
" Dracula theme
Plug 'dracula/vim'
" Nerdtree
Plug 'scrooloose/nerdtree'
" A plugin of NERDTree showing git status flags.
Plug 'Xuyuanp/nerdtree-git-plugin'
" Full path fuzzy file, buffer, mru, tag, ... finder for Vim.
Plug 'ctrlpvim/ctrlp.vim'
" A vim plugin wrapper for prettier
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql'] }
" commentary.vim: comment stuff out
Plug 'tpope/vim-commentary'
" Asynchronous Lint Engine
Plug 'w0rp/ale'

call plug#end()

"" Leader key
let mapleader = '\'
" open ag.vim
nnoremap <leader>a :Ag

"" Text Wrapping
set textwidth=79
set colorcolumn=80
set nowrap

"" Encoding
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8
set bomb
set binary
set ttyfast

"" Enable hidden buffers
set hidden

"" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase
nnoremap <leader><space> :nohls <enter>

"" Folding
set foldenable " Enable folding
set foldlevelstart=10 " Open most folds by default
set foldnestmax=10 " 10 nested fold max
set foldmethod=indent " Fold based on indent level
" space open/closes folds
nnoremap <space> za

"" Movement
" move vertically by visual line
nnoremap j gj
nnoremap k gk

" highlight last inserted text
nnoremap gV `[v`]

"" The Silver Searcher
if executable('ag')
  let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -g ""'
  set grepprg=ag\ --nogroup\ --nocolor
endif

" Save temporary/backup files not in the local directory, but in your ~/.vim
" directory, to keep them out of git repos.
" But first mkdir backup, swap, and undo first to make this work
call system('mkdir ~/.vim')
call system('mkdir ~/.vim/backup')
call system('mkdir ~/.vim/swap')
set backupdir=~/.vim/backup/
set directory=~/.vim/swap/

" Keep undo history across sessions by storing it in a file
if has('persistent_undo')
    call system('mkdir ~/.vim/undo')
    set undodir=~/.vim/undo//
    set undofile
    set undolevels=1000
    set undoreload=10000
endif

"" UI Config
syntax enable " Syntax highlight
set cursorline " Highlight current line
set relativenumber " Using relative line numbers in Vim
set number " Display line number
colorscheme dracula " Color scheme
filetype indent on " Load filetype-specific indent files
set wildmenu " Visual autocomplete for command menu
set showmatch " Highlight matching [{()}]

"" Tabs
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set backspace=2

set rtp+=/usr/local/bin/fzf " fzf

"" Vim: Creating parent directories on save
function s:MkNonExDir(file, buf)
  if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
    let dir=fnamemodify(a:file, ':h')
    if !isdirectory(dir)
      call mkdir(dir, 'p')
    endif
  endif
endfunction
augroup BWCCreateDir
  autocmd!
  autocmd BufWritePre * :call s:MkNonExDir(expand('<afile>'), +expand('<abuf>'))
augroup END

"" Vim Better Whitespace Plugin
" strip all trailing whitespace everytime you save the file for all file types
autocmd BufEnter * EnableStripWhitespaceOnSave

"" mucomplete
set completeopt=menuone,noinsert,noselect
set shortmess+=c   " Shut off completion messages
set belloff+=ctrlg " If Vim beeps during completionc
let g:mucomplete#enable_auto_at_startup = 1
inoremap <expr> <c-e> mucomplete#popup_exit("\<c-e>")
inoremap <expr> <c-y> mucomplete#popup_exit("\<c-y>")
inoremap <expr>  <cr> mucomplete#popup_exit("\<cr>")
call add(g:mucomplete#chains['default'], 'ulti')

"" Airline Powerline
let g:airline_powerline_fonts = 1
set laststatus=2
let g:airline#extensions#tabline#enabled = 1
nnoremap <leader><leader><space> :Buffers<CR>
nnoremap <leader><leader><tab> :bnext<CR>
nnoremap <leader><leader>q :bdelete<CR>

"" NERDTree
map <leader>f :NERDTreeToggle<CR>
nmap <leader>r :NERDTreeFind<CR>
let NERDTreeShowHidden=1
" enable line numbers
let NERDTreeShowLineNumbers=1
" make sure relative line numbers are used
autocmd FileType nerdtree setlocal relativenumber
" How can I close vim if the only window left open is a NERDTree?
"autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" NERDTress File highlighting
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
 exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
 exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction

call NERDTreeHighlightFile('jade', 'green', 'none', 'green', '#151515')
call NERDTreeHighlightFile('ini', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('md', 'blue', 'none', '#3366FF', '#151515')
call NERDTreeHighlightFile('yml', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('config', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('conf', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('json', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('html', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('styl', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('css', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('coffee', 'Red', 'none', 'red', '#151515')
call NERDTreeHighlightFile('js', 'Red', 'none', '#ffa500', '#151515')
call NERDTreeHighlightFile('php', 'Magenta', 'none', '#ff00ff', '#151515')

" ctrlp
let g:ctrlp_match_window = 'bottom,order:ttb'
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 0
let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'

" Prettier
let g:prettier#exec_cmd_async = 1
let g:prettier#config#bracket_spacing = 'true'
let g:prettier#config#trailing_comma = 'es5'

" Operations such as yy, D, and P work with the system clipboard
se mouse+=a
set clipboard=unnamed

" vim-jsx
let g:jsx_ext_required = 0

" Ale
let g:ale_sign_error = '●' " Less aggressive than the default '>>'
let g:ale_sign_warning = '.'
let g:ale_lint_on_enter = 0 " Less distracting when opening a new file

" Triger `autoread` when files changes on disk
" https://unix.stackexchange.com/questions/149209/refresh-changed-content-of-file-opened-in-vim/383044#383044
" https://vi.stackexchange.com/questions/13692/prevent-focusgained-autocmd-running-in-command-line-editing-mode
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
" Notification after file change
" https://vi.stackexchange.com/questions/13091/autocmd-event-for-autoread
autocmd FileChangedShellPost *
  \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None

