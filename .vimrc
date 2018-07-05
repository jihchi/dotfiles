" vim-plug (https://github.com/junegunn/vim-plug) settings
" Automatically install vim-plug and run PlugInstall if vim-plug not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
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
" fugitive.vim: a Git wrapper so awesome, it should be i1llegal
Plug 'tpope/vim-fugitive'
" Better whitespace highlighting for Vim
Plug 'ntpeters/vim-better-whitespace'
" JavaScript bundle for vim, this bundle provides syntax highlighting and improved indentation.
Plug 'pangloss/vim-javascript'
" 🔦 [Vim script] React JSX syntax pretty highlighting for vim.
Plug 'maxmellon/vim-jsx-pretty'
" React JSX syntax highlighting and indenting for vim.
Plug 'mxw/vim-jsx'
" Molokai color scheme for Vim
Plug 'fatih/molokai'
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
" Useful vim commands to close buffers 📖
Plug 'Asheq/close-buffers.vim'
" indent yaml
Plug 'avakhov/vim-yaml'
" Vim support for Reason/OCaml
Plug 'reasonml-editor/vim-reason-plus'
" Language Server Protocol support for neovim and vim.
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
" This is an experimental project, trying to build a compatibility layer for neovim rpc client working on vim8
Plug 'roxma/vim-hug-neovim-rpc'
" Yet Another Remote Plugin Framework for Neovim
Plug 'roxma/nvim-yarp'
" rainbow parentheses improved, shorter code, no level limit, smooth and fast, powerful configuration.
Plug 'luochen1990/rainbow'
" True Sublime Text style multiple selections for Vim
Plug 'terryma/vim-multiple-cursors'
" Plugin to move lines and selections up and down
Plug 'matze/vim-move'
" Chained completion that works the way you want!
Plug 'lifepillar/vim-mucomplete'
" Go development plugin for Vim
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
" Simple Vim configuration for Ponylang. 🐴 https://github.com/ponylang/ponyc
Plug 'jakwings/vim-pony'
" An ack.vim alternative mimics Ctrl-Shift-F on Sublime Text 2
Plug 'dyng/ctrlsf.vim'
" This plugin for Vim enable an auto-close chars feature for you. For instance
" if you type an '(', ``autoclose`` will automatically insert a ')' and put
" the cursor between than.
Plug 'townk/vim-autoclose'

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

set showcmd

" ============================================================================
" FZF {{{
" https://github.com/junegunn/dotfiles/blob/master/vimrc
" ============================================================================

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
nnoremap <silent> <Leader><Enter> :Buffers<CR>
nnoremap <silent> <Leader>ag :Ag <C-R><C-W><CR>
nnoremap <silent> <Leader>AG :Ag <C-R><C-A><CR>
xnoremap <silent> <Leader>ag y:Ag <C-R>"<CR>

" vim-go
map <C-n> :cnext<CR>
map <C-m> :cprevious<CR>
nnoremap <leader>a :cclose<CR>
" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction
autocmd FileType go nmap ,b :<C-u>call <SID>build_go_files()<CR>
autocmd FileType go nmap ,c <Plug>(go-coverage-toggle)
autocmd FileType go nmap ,r <Plug>(go-run)
autocmd FileType go nmap ,i <Plug>(go-info)
let g:go_fmt_command = "goimports"
let g:go_highlight_types = 1
let g:go_highlight_fields =  1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1
let g:go_auto_type_info = 1
let g:go_metalinter_autosave = 1
set updatetime=250

syntax on " Syntax highlight
set t_Co=256 " 256 colors, please
set t_ut= " Fix bg color inside tmux sessions
let g:molokai_original = 1
let g:rehash256 = 1
colorscheme molokai
set relativenumber " Using relative line numbers in Vim
set number " Display line number
filetype indent on " Load filetype-specific indent files
set wildmenu " Visual autocomplete for command menu
set wildmode=longest:full,full
set wildignore=*.swp,*.bak,**/.git/*
set showmatch " Highlight matching [{()}]
set history=1000 " Store a ton of history (default is 20)
set nowrap " Do not wrap long lines
set autoindent " Indent at the same level of the previous line
set tabstop=8 " For tab characters that appear 4-spaces-wide
set shiftwidth=4
set softtabstop=0
set expandtab
set smarttab
set backspace=2


set rtp+=/usr/local/bin/fzf " fzf

"" Vim Better Whitespace Plugin
nmap <leader><leader>w :StripWhitespace<CR>

"" Airline Powerline
let g:airline_powerline_fonts = 1
set laststatus=2
let g:airline#extensions#tabline#enabled = 1

"" NERDTree
nmap <leader>e :NERDTreeToggle<CR>
nmap <leader>r :NERDTreeFind<CR>
let NERDTreeShowHidden=1
" enable line numbers
let NERDTreeShowLineNumbers=1
" make sure relative line numbers are used
autocmd FileType nerdtree setlocal relativenumber
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

" NERDTree Git setup
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "~",
    \ "Untracked" : "⍨",
    \ "Staged"    : "⍢",
    \ "Renamed"   : "⎌",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "⍤",
    \ "Dirty"     : "∙",
    \ "Clean"     : "⎀",
    \ "Unknown"   : "?"
    \ }


" Prettier
let g:prettier#exec_cmd_async = 1
let g:prettier#config#bracket_spacing = 'true'
let g:prettier#config#trailing_comma = 'es5'

" vim-jsx
let g:jsx_ext_required = 0

" Triger `autoread` when files changes on disk
" https://unix.stackexchange.com/questions/149209/refresh-changed-content-of-file-opened-in-vim/383044#383044
" https://vi.stackexchange.com/questions/13692/prevent-focusgained-autocmd-running-in-command-line-editing-mode
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
" Notification after file change
" https://vi.stackexchange.com/questions/13091/autocmd-event-for-autoread
autocmd FileChangedShellPost *
  \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None

" Super fast window movement shortcuts
nmap <C-j> <C-W>j
nmap <C-k> <C-W>k
nmap <C-h> <C-W>h
nmap <C-l> <C-W>l

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

" go next
nnoremap <C-l> :bnext<CR>
" go previous
nnoremap <C-h> :bprevious<CR>
" close this buffer
nnoremap <silent> <leader>q :CloseThisBuffer<CR>
" close other buffer
nnoremap <silent> Q :CloseBuffersMenu<CR>

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

" Reason / OCaml
let g:LanguageClient_autoStart = 1
let g:LanguageClient_serverCommands = {
    \ 'reason': ['ocaml-language-server', '--stdio'],
    \ 'ocaml': ['ocaml-language-server', '--stdio'],
    \ 'javascript': ['javascript-typescript-stdio'],
    \ 'javascript.jsx': ['javascript-typescript-stdio'],
    \ }

" roxma/vim-hug-neovim-rpc & roxma/nvim-yarp
nnoremap <silent> gd :call LanguageClient_textDocument_definition()<cr>
nnoremap <silent> gf :call LanguageClient_textDocument_formatting()<cr>
nnoremap <silent> <cr> :call LanguageClient_textDocument_hover()<cr>

let g:rainbow_active = 1

" 'matze/vim-move'
" <C-k>   Move current line/selections up
" <C-j>   Move current line/selections down
let g:move_key_modifier = 'C'

" MUcomplete
" Mandatory
set completeopt+=menuone,noinsert,noselect
set shortmess+=c   " Shut off completion messages
set belloff+=ctrlg " If Vim beeps during completion
let g:mucomplete#enable_auto_at_startup = 1

set nobackup " Everything will be ok
set nowritebackup
set noswapfile
set autoread " Autoread files

set timeoutlen=500 " Be faster
set ttimeoutlen=10

set novisualbell " Turn noise off
set noerrorbells
set vb t_vb=

set listchars=tab:→\ ,space:·,nbsp:␣,trail:•,eol:¬,precedes:«,extends:»
"set list

" CtrlSF
nmap <C-F>f <Plug>CtrlSFPrompt
vmap <C-F>f <Plug>CtrlSFVwordPath
vmap <C-F>F <Plug>CtrlSFVwordExec
nmap <C-F>n <Plug>CtrlSFCwordPath
nmap <C-F>p <Plug>CtrlSFPwordPath
nnoremap <C-F>o :CtrlSFOpen<CR>
nnoremap <C-F>t :CtrlSFToggle<CR>
inoremap <C-F>t <Esc>:CtrlSFToggle<CR>

" making zz, zt, and zb work nicely with visual selections
" https://www.reddit.com/r/vim/comments/uz8fi/making_zz_zt_and_zb_work_nicely_with_visual/c4zxw7l
vnoremap <silent> zz :<C-u>call setpos('.',[0,(line("'>")-line("'<"))/2+line("'<"),0,0])<Bar>normal! zzgv<CR>
vnoremap <silent> zt :<C-u>call setpos('.',[0,line("'<"),0,0])<Bar>normal! ztgv<CR>
vnoremap <silent> zb :<C-u>call setpos('.',[0,line("'>"),0,0])<Bar>normal! zbgv<CR>

" open new split panes to right and bottom, which feels more natural than Vim’s default:
set splitbelow
set splitright
