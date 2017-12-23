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
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
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
" 🔦 [Vim script] React JSX syntax pretty highlighting for vim.
Plug 'maxmellon/vim-jsx-pretty'
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
" A vim plugin wrapper for prettier
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql'] }
" commentary.vim: comment stuff out
Plug 'tpope/vim-commentary'
" Asynchronous Lint Engine
Plug 'w0rp/ale'
" 📐 Simple indentation guides for your buffers
Plug 'thaerkh/vim-indentguides'
" 📑 Automated Vim session management and file auto-save
Plug 'thaerkh/vim-workspace'
" vim plugin which formated javascript files by js-beautify
Plug 'maksimr/vim-jsbeautify'
" Useful vim commands to close buffers 📖
Plug 'Asheq/close-buffers.vim'
" Vim plugin that displays tags in a window, ordered by scope
Plug 'majutsushi/tagbar'
" Tern plugin for Vim
Plug 'ternjs/tern_for_vim'
" indent yaml
Plug 'avakhov/vim-yaml'
" Vim support for Reason/OCaml
Plug 'reasonml-editor/vim-reason-plus'
" Language Server Protocol support for neovim and vim.
Plug 'autozimu/LanguageClient-neovim'
" This is an experimental project, trying to build a compatibility layer for neovim rpc client working on vim8
Plug 'roxma/vim-hug-neovim-rpc'
" Yet Another Remote Plugin Framework for Neovim
Plug 'roxma/nvim-yarp'

call plug#end()

"" Leader key
let mapleader = '\'

"" Text Wrapping
set textwidth=79
set colorcolumn=80
set sidescroll=1
set formatoptions+=t

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
set showcmd

" highlight last inserted text
nnoremap gV `[v`]

" ============================================================================
" FZF {{{
" https://github.com/junegunn/dotfiles/blob/master/vimrc
" ============================================================================

if has('nvim') || has('gui_running')
  let $FZF_DEFAULT_OPTS .= ' --inline-info'
endif

" Hide statusline of terminal buffer
autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

nnoremap <silent> <C-p> :Files<CR>
nnoremap <silent> <expr> <Leader><Leader> (expand('%') =~ 'NERD_tree' ? "\<c-w>\<c-w>" : '').":Files\<cr>"
nnoremap <silent> <Leader>C :Colors<CR>
nnoremap <silent> <Leader><Enter> :Buffers<CR>
nnoremap <silent> <Leader>l :Lines<CR>
nnoremap <silent> <Leader>ag :Ag <C-R><C-W><CR>
nnoremap <silent> <Leader>AG :Ag <C-R><C-A><CR>
xnoremap <silent> <Leader>ag y:Ag <C-R>"<CR>
nnoremap <silent> <Leader>` :Marks<CR>
" nnoremap <silent> q: :History:<CR>
" nnoremap <silent> q/ :History/<CR>

inoremap <expr> <c-x><c-t> fzf#complete('tmuxwords.rb --all-but-current --scroll 500 --min 5')
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
inoremap <expr> <c-x><c-d> fzf#vim#complete#path('blsd')
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

function! s:plug_help_sink(line)
  let dir = g:plugs[a:line].dir
  for pat in ['doc/*.txt', 'README.md']
    let match = get(split(globpath(dir, pat), "\n"), 0, '')
    if len(match)
      execute 'tabedit' match
      return
    endif
  endfor
  tabnew
  execute 'Explore' dir
endfunction

command! PlugHelp call fzf#run(fzf#wrap({
  \ 'source': sort(keys(g:plugs)),
  \ 'sink':   function('s:plug_help_sink')}))

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
let g:airline#extensions#tabline#buffer_nr_show = 1
nnoremap <leader><leader><tab> :bnext<CR>
nnoremap <leader><leader>q :CloseThisBuffer<CR>

"" NERDTree
nmap <leader>e :NERDTreeToggle<CR>
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

" Prettier
let g:prettier#exec_cmd_async = 1
let g:prettier#config#bracket_spacing = 'true'
let g:prettier#config#trailing_comma = 'es5'

" vim-jsx
let g:jsx_ext_required = 0

" Ale
let g:ale_sign_warning = '▲'
let g:ale_sign_error = '✗'
let g:ale_lint_on_enter = 0 " Less distracting when opening a new file
highlight link ALEWarningSign String
highlight link ALEErrorSign Title

" Triger `autoread` when files changes on disk
" https://unix.stackexchange.com/questions/149209/refresh-changed-content-of-file-opened-in-vim/383044#383044
" https://vi.stackexchange.com/questions/13692/prevent-focusgained-autocmd-running-in-command-line-editing-mode
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
" Notification after file change
" https://vi.stackexchange.com/questions/13091/autocmd-event-for-autoread
autocmd FileChangedShellPost *
  \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None

" vim-workspace
nnoremap <leader>s :ToggleWorkspace<CR>

" vim-indentguides
let g:indentguides_ignorelist = ['text', 'json']

" vim-jsbeautify
autocmd FileType json noremap <buffer> <leader>b :call JsonBeautify()<cr>
autocmd FileType html noremap <buffer> <leader>b :call HtmlBeautify()<cr>
let g:config_Beautifier = {
  \ 'html': {
  \   'indent_style': 'space',
  \   'indent_size': '2'
  \ }
\}

" Super fast window movement shortcuts
nmap <C-j> <C-W>j
nmap <C-k> <C-W>k
nmap <C-h> <C-W>h
nmap <C-l> <C-W>l

" Search for visually selected text
vnoremap <expr> // 'y/\V'.escape(@",'\').'<CR>'

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

" http://vim.wikia.com/wiki/Easier_buffer_switching
" Mappings to access buffers (don't use "\p" because a
" delay before pressing "p" would accidentally paste).
" \1 \2 \3 : go to buffer 1/2/3 etc
nnoremap <Leader>1 :1b<CR>
nnoremap <Leader>2 :2b<CR>
nnoremap <Leader>3 :3b<CR>
nnoremap <Leader>4 :4b<CR>
nnoremap <Leader>5 :5b<CR>
nnoremap <Leader>6 :6b<CR>
nnoremap <Leader>7 :7b<CR>
nnoremap <Leader>8 :8b<CR>
nnoremap <Leader>9 :9b<CR>
nnoremap <Leader>0 :10b<CR>
" It's useful to show the buffer number in the status line.
set laststatus=2 statusline=%02n:%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P

" Reason / OCaml
let g:LanguageClient_autoStart = 1
let g:LanguageClient_serverCommands = {
    \ 'reason': ['ocaml-language-server', '--stdio'],
    \ 'ocaml': ['ocaml-language-server', '--stdio'],
    \ }

" roxma/vim-hug-neovim-rpc & roxma/nvim-yarp
let g:python3_host_prog="/usr/local/opt/python3/Frameworks/Python.framework/Versions/3.6/bin/python3"
nnoremap <silent> gd :call LanguageClient_textDocument_definition()<cr>
nnoremap <silent> gf :call LanguageClient_textDocument_formatting()<cr>
nnoremap <silent> <cr> :call LanguageClient_textDocument_hover()<cr>
" For debugging used
"let $NVIM_PYTHON_LOG_FILE="nvim_log"
"let $NVIM_PYTHON_LOG_LEVEL="DEBUG"
