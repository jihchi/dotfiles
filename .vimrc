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
" This is an experimental project, trying to build a compatibility layer for
" neovim rpc client working on vim8
Plug 'roxma/vim-hug-neovim-rpc'
" Yet Another Remote Plugin Framework for Neovim
Plug 'roxma/nvim-yarp'
" rainbow parentheses improved, shorter code, no level limit, smooth and fast, powerful configuration.
Plug 'luochen1990/rainbow'
" True Sublime Text style multiple selections for Vim
Plug 'terryma/vim-multiple-cursors'
" Go development plugin for Vim
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
" An ack.vim alternative mimics Ctrl-Shift-F on Sublime Text 2
Plug 'dyng/ctrlsf.vim'
" A light and configurable statusline/tabline plugin for Vim
Plug 'itchyny/lightline.vim'
" Provides the branch name of the current git repository
Plug 'itchyny/vim-gitbranch'
" Underlines the word under the cursor
Plug 'itchyny/vim-cursorword'
" Jump to any location specified by two characters.
Plug 'justinmk/vim-sneak'
" A better JSON for Vim: distinct highlighting of keywords vs values, JSON-specific (non-JS) warnings, quote concealing. Pathogen-friendly.
Plug 'elzr/vim-json'
" EditorConfig Vim Plugin
Plug 'editorconfig/editorconfig-vim'
" A collection of language packs for Vim.
Plug 'sheerun/vim-polyglot'
" Edit large files quickly (keywords: large huge speed)
Plug 'vim-scripts/LargeFile'
" Vim configuration for Rust.
Plug 'rust-lang/rust.vim'
" 🌠 Dark powered asynchronous completion framework for neovim/Vim8
Plug 'Shougo/deoplete.nvim'
" ☀️ A vim plugin for highlighting and navigating through different words in a buffer.
Plug 'lfv89/vim-interestingwords'

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
nnoremap <silent> <C-l> :nohls <enter>

"" Folding
set foldenable " Enable folding
set foldlevelstart=10 " Open most folds by default
set foldnestmax=10 " 10 nested fold max
set foldmethod=syntax " Fold based on indent level

set showcmd
set lazyredraw
set regexpengine=1

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

nnoremap <silent> <C-p> :Files<CR>
nnoremap <silent> <C-i> :Buffers<CR>
nnoremap <silent> <Leader>f :BLines<CR>
nnoremap <silent> <Leader>ag :Ag <C-R><C-W><CR>
nnoremap <silent> <Leader>AG :Ag <C-R><C-A><CR>
xnoremap <silent> <Leader>ag y:Ag <C-R>"<CR>

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
set noshowmode " -- INSERT -- is unnecessary anymore because the mode information is displayed in the statusline.
set cursorline

"" Vim Better Whitespace Plugin
nmap <leader><leader>w :StripWhitespace<CR>

"" NERDTree
" https://stackoverflow.com/a/41544696
function! IsNerdTreeEnabled()
    return exists('t:NERDTreeBufName') && bufwinnr(t:NERDTreeBufName) != -1
endfunction

" https://stackoverflow.com/a/46171509
function MyNerdToggle()
    if &filetype == 'nerdtree' || IsNerdTreeEnabled()
        :NERDTreeToggle
    else
        :NERDTreeFind
    endif
endfunction
nnoremap <leader>e :call MyNerdToggle()<CR>

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

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

" close this buffer
nnoremap <silent> <leader>q :bp\|bd #<CR>

" close other buffer
nnoremap <silent> Q :Bdelete menu<CR>

let g:LanguageClient_autoStart = 1
let g:LanguageClient_serverCommands = {
    \ 'reason': ['reason-language-server'],
    \ 'javascript': ['javascript-typescript-stdio'],
    \ 'javascript.jsx': ['javascript-typescript-stdio'],
    \ 'typescript': ['javascript-typescript-stdio'],
    \ 'typescript.jsx': ['javascript-typescript-stdio'],
    \ 'go': ['go-langserver'],
    \ 'rust': ['rls'],
    \ }

" roxma/vim-hug-neovim-rpc & roxma/nvim-yarp
nnoremap <silent> gd :call LanguageClient_textDocument_definition()<cr>
nnoremap <silent> gf :call LanguageClient_textDocument_formatting()<cr>
nnoremap <silent> <cr> :call LanguageClient_textDocument_hover()<cr>

let g:rainbow_active = 1

set nobackup " Everything will be ok
set nowritebackup
set noswapfile
set autoread " Autoread files

set timeoutlen=500 " Be faster
set ttimeoutlen=10

set novisualbell " Turn noise off
set noerrorbells
set vb t_vb=

set listchars=tab:→\ ,nbsp:␣,trail:•,precedes:«,extends:»
set list

" CtrlSF
nmap <C-F>f <Plug>CtrlSFPrompt
vmap <C-F>f <Plug>CtrlSFVwordPath
vmap <C-F>F <Plug>CtrlSFVwordExec
nmap <C-F>n <Plug>CtrlSFCwordPath
nmap <C-F>p <Plug>CtrlSFPwordPath
nnoremap <C-F>o :CtrlSFOpen<CR>
nnoremap <C-F>c :CtrlSFClose<CR>
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

" lightline
let g:lightline = {
      \ 'tabline': {
      \   'left': [ ['bufferline'] ]
      \ },
      \ 'component_expand': {
      \   'bufferline': 'LightlineBufferline',
      \ },
      \ 'component_type': {
      \   'bufferline': 'tabsel',
      \ },
      \ 'component_function': {
      \   'filename': 'LightlineFilename',
      \ }
      \ }

function! LightlineBufferline()
  call bufferline#refresh_status()
  return [ g:bufferline_status_info.before, g:bufferline_status_info.current, g:bufferline_status_info.after]
endfunction

function! LightlineFilename()
  let root = fnamemodify(get(b:, 'gitbranch_path'), ':h:h')
  let path = expand('%:p')
  if path[:len(root)-1] ==# root
    return path[len(root)+1:]
  endif
  return expand('%')
endfunction

" vim-sneak
let g:sneak#label = 1
let g:sneak#use_ic_scs = 1
map f <Plug>Sneak_s
map F <Plug>Sneak_S

" multi cursor
let g:multi_cursor_exit_from_insert_mode = 0

" deoplete
let g:deoplete#enable_at_startup = 1

" deoplete + mutiple cursor
function g:Multiple_cursors_before()
  call deoplete#custom#buffer_option('auto_complete', v:false)
endfunction
function g:Multiple_cursors_after()
  call deoplete#custom#buffer_option('auto_complete', v:true)
endfunction

" deoplete.txt: Q: I want to close the preview window after completion is done.
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | silent! pclose | endif
