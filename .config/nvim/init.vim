" vim-plug (https://github.com/junegunn/vim-plug) settings
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin(stdpath('data') . '/plugged')

" fzf ❤️  vim
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

" quoting/parenthesizing made simple
Plug 'tpope/vim-surround'

" A Vim plugin which shows a git diff in the gutter (sign column) and stages/undoes hunks.
Plug 'airblade/vim-gitgutter'

" fugitive.vim: a Git wrapper so awesome, it should be i1llegal
Plug 'tpope/vim-fugitive'

" Better whitespace highlighting for Vim
Plug 'ntpeters/vim-better-whitespace'

" Dracula dark theme for Vim https://draculatheme.com/vim
Plug 'dracula/vim', { 'as': 'dracula' }

" Nerdtree
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin' " A plugin of NERDTree showing git status flags.

" Prettier
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }

" commentary.vim: comment stuff out
Plug 'tpope/vim-commentary'

" Useful vim commands to close buffers
Plug 'Asheq/close-buffers.vim'

" True Sublime Text style multiple selections for Vim
Plug 'terryma/vim-multiple-cursors'

" An ack.vim alternative mimics Ctrl-Shift-F on Sublime Text 2
Plug 'dyng/ctrlsf.vim'

" A light and configurable statusline/tabline plugin for Vim
Plug 'itchyny/lightline.vim'

" Jump to any location specified by two characters.
Plug 'justinmk/vim-sneak'

" EditorConfig Vim Plugin
Plug 'editorconfig/editorconfig-vim'

" Vim syntax for TOML
Plug 'cespare/vim-toml'

" A solid language pack for Vim.
Plug 'sheerun/vim-polyglot'

" Underlines the word under the cursor
Plug 'itchyny/vim-cursorword'

" Highlight several words in different colors simultaneously.
" Plug 'inkarkat/vim-mark'
" The difference is that this repo is the standalone version. This one does NOT depend on any other library or plugin. All you need is vim itself, nothing more!
Plug 'ayuanx/vim-mark-standalone'

call plug#end()

syntax on
colorscheme dracula
set relativenumber " using relative line numbers in Vim
set number " display line number
set cursorline
set listchars=tab:→\ ,nbsp:␣,trail:•,precedes:«,extends:»
set list
set tabstop=4 " the width of a TAB is set to 4. Still it is a \t. It is just that Vim will interpret it to be having a width of 4.
set shiftwidth=4 " indents will have a width of 4
set softtabstop=4 " sets the number of columns for a TAB
set expandtab " expand TABs to spaces
" switch off automatic creation of backup files
set nobackup
set nowritebackup
set noswapfile
" open new split panes to right and bottom, which feels more natural than Vimâ€™s default:
set splitbelow
set splitright
" ignore case when searching
set ignorecase
" when searching try to be smart about cases
set smartcase
" highlight search results
set hlsearch
" makes search act like search in modern browsers
set incsearch
" don't redraw while executing macros (good performance config)
set lazyredraw
" show matching brackets when text indicator is over them
set showmatch
" set to auto read when a file is changed from the outside
set autoread
au CursorHold * checktime
" no annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" map <space> as leader
nnoremap <Space> <nop>
vnoremap <Space> <nop>
let mapleader = ' '

nnoremap <silent> <Leader><Leader>l :nohls <enter>
nnoremap <silent> <C-p> :Files<CR>
nnoremap <silent> <C-l> :Buffers<CR>
nnoremap <silent> <Leader>f :BLines<CR>
nnoremap <silent> <Leader>ag :Ag <C-R><C-W><CR>
nnoremap <silent> <Leader>AG :Ag <C-R><C-A><CR>
xnoremap <silent> <Leader>ag y:Ag <C-R>"<CR>
" Vim Better Whitespace Plugin
nmap <leader><leader>w :StripWhitespace<CR>
" close this buffer
nnoremap <silent> <leader>q :bp\|bd #<CR>
" close other buffer
nnoremap <silent> Q :Bdelete menu<CR>

autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

" NERDTree
let NERDTreeShowHidden=1
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

" vim-sneak
let g:sneak#label = 1
let g:sneak#use_ic_scs = 1
map f <Plug>Sneak_s
map F <Plug>Sneak_S

" multi cursor
let g:multi_cursor_exit_from_insert_mode = 0
