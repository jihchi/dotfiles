" vim-plug (https://github.com/junegunn/vim-plug) settings
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin(stdpath('data') . '/plugged')

Plug 'Raimondi/delimitMate' " Vim plugin, provides insert mode auto-completion for quotes, parens, brackets, etc.
Plug 'haishanh/night-owl.vim' " A 24bit dark Vim colorscheme based on sdras/night-owl-vscode-theme
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } " fzf ❤️  vim
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-surround' " quoting/parenthesizing made simple
Plug 'airblade/vim-gitgutter' " A Vim plugin which shows a git diff in the gutter (sign column) and stages/undoes hunks.
Plug 'tpope/vim-fugitive' " fugitive.vim: a Git wrapper so awesome, it should be i1llegal
Plug 'ntpeters/vim-better-whitespace' " Better whitespace highlighting for Vim
Plug 'scrooloose/nerdtree' " Nerdtree
Plug 'Xuyuanp/nerdtree-git-plugin' " A plugin of NERDTree showing git status flags.
Plug 'prettier/vim-prettier', { 'do': 'yarn install' } " Prettier
Plug 'tpope/vim-commentary' " commentary.vim: comment stuff out
Plug 'machakann/vim-highlightedyank' " Make the yanked region apparent!
Plug 'Asheq/close-buffers.vim' " Useful vim commands to close buffers
Plug 'terryma/vim-multiple-cursors' " True Sublime Text style multiple selections for Vim
Plug 'dyng/ctrlsf.vim' " An ack.vim alternative mimics Ctrl-Shift-F on Sublime Text 2
Plug 'itchyny/lightline.vim' " A light and configurable statusline/tabline plugin for Vim
Plug 'justinmk/vim-sneak' " Jump to any location specified by two characters.
Plug 'editorconfig/editorconfig-vim' " EditorConfig Vim Plugin
Plug 'cespare/vim-toml' " Vim syntax for TOML
Plug 'ekalinin/Dockerfile.vim' " Vim syntax file & snippets for Docker's Dockerfile
Plug 'sheerun/vim-polyglot' " A solid language pack for Vim.
Plug 'itchyny/vim-cursorword' " Underlines the word under the cursor
Plug 'neoclide/coc.nvim', {'branch': 'release'} " Intellisense engine for Vim8 & Neovim, full language server protocol support as VSCode
Plug 'rust-lang/rust.vim' " Vim configuration for Rust.
Plug 'kshenoy/vim-signature' " Plugin to toggle, display and navigate marks
Plug 'andymass/vim-matchup' " vim match-up: even better % 👊 navigate and highlight matching words 👊 modern matchit and matchparen replacement
Plug 'airblade/vim-rooter' " Changes Vim working directory to project root (identified by presence of known directory or file).
Plug 'glippi/lognroll-vim' " 💻 🤘 Make logging in Vim great as it has never been
Plug 'rescript-lang/vim-rescript' " the official vim plugin for ReScript.

call plug#end()

filetype off
set nocompatible

syntax enable
set termguicolors " Enable 24bit true color
colorscheme night-owl
set background=dark " Setting dark mode

set relativenumber " Show relative numbers
set number " Don't show line numbers
set numberwidth=3 " The width of the number column

set fillchars+=vert:\  " Don't show pipes in vertical splits
set list " Show some more characters
set listchars=tab:▸\
set listchars+=extends:❯
set listchars+=nbsp:␣
set listchars+=precedes:❮
set listchars+=trail:·

" indentation
set expandtab " Indent with spaces
set shiftwidth=2 " Number of spaces to use when indenting
set smartindent " Auto indent new lines
set softtabstop=2 " Number of spaces a <tab> counts for when inserting
set tabstop=2 " Number of spaces a <tab> counts for

" spell checking
set nospell " Disable spell checking by default
set spelllang=en_us " Use English US for spell checking

set splitbelow " open new split panes to right and bottom, which feels more natural than Vim default:
set splitright

" backup
set nobackup " switch off automatic creation of backup files
set nowritebackup
set noswapfile

" searching
set ignorecase " ignore case when searching
set smartcase " when searching try to be smart about cases
set hlsearch " highlight search results
set incsearch " makes search act like search in modern browsers

set lazyredraw " don't redraw while executing macros (good performance config)
set showmatch " show matching brackets when text indicator is over them
set autoread " set to auto read when a file is changed from the outside

set noerrorbells " no annoying sound on errors
set novisualbell
set t_vb=
set tm=500
set colorcolumn=80
set wrap " Wrap long lines
filetype plugin indent on
set autoindent
set encoding=utf-8
set wildmenu " Decent wildmenu
set wildmode=list:longest
set wildignore=.hg,.svn,*~,*.png,*.jpg,*.gif,*.settings,Thumbs.db,*.min.js,*.swp,publish/*,intermediate/*,*.o,*.hi,Zend,vendor

" folds
set foldenable " Enable folds
set foldlevelstart=99 " Open all folds by default
set foldmethod=indent " Fold by indentation

" Give more space for displaying messages.
set cmdheight=1

" map <space> as leader
nnoremap <Space> <nop>
vnoremap <Space> <nop>
let mapleader = "\<Space>"

nnoremap <silent> <Leader><Leader>l :nohls <enter>
nnoremap <silent> <C-p> :Files<CR>
nnoremap <silent> <C-l> :Buffers<CR>
nnoremap <silent> <Leader>s :BLines<CR>
nnoremap <silent> <Leader>ag :Ag <C-R><C-W><CR>
nnoremap <silent> <Leader>AG :Ag <C-R><C-A><CR>
xnoremap <silent> <Leader>ag y:Ag <C-R>"<CR>

" Vim Better Whitespace Plugin
nmap <leader><leader>w :StripWhitespace<CR>

" Close this buffer
nnoremap <silent> <leader>q :bp\|bd #<CR>

" Close other buffer
nnoremap <silent> Q :Bdelete menu<CR>

" Quickly insert semicolon at end of line
noremap <leader>; maA;<esc>`a

" Quickly insert comma at end of line
noremap <leader>, maA,<esc>`a

" Quick-save
nmap <leader>w :w<CR>

" Hide/show the cursor line when leaving/entering a window
augroup CursorLine
    au!
    au VimEnter * setlocal cursorline
    au WinEnter * setlocal cursorline
    au BufWinEnter * setlocal cursorline
    au WinLeave * setlocal nocursorline
augroup END

au CursorHold * checktime

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
nmap <C-S>f <Plug>CtrlSFPrompt
vmap <C-S>f <Plug>CtrlSFVwordPath
vmap <C-S>F <Plug>CtrlSFVwordExec
nmap <C-S>n <Plug>CtrlSFCwordPath
nmap <C-S>p <Plug>CtrlSFPwordPath
nnoremap <C-S>o :CtrlSFOpen<CR>
nnoremap <C-S>c :CtrlSFClose<CR>
nnoremap <C-S>t :CtrlSFToggle<CR>
inoremap <C-S>t <Esc>:CtrlSFToggle<CR>

" vim-sneak
let g:sneak#label = 1
let g:sneak#use_ic_scs = 1
map f <Plug>Sneak_s
map F <Plug>Sneak_S

" multi cursor
let g:multi_cursor_exit_from_insert_mode = 0

" coc.nvim
" TextEdit might fail if hidden is not set.
set hidden

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
" xmap <leader>f  <Plug>(coc-format-selected)
" nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
" Note coc#float#scroll works on neovim >= 0.4.3 or vim >= 8.2.0750
nnoremap <nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
inoremap <nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"

" NeoVim-only mapping for visual mode scroll
" Useful on signatureHelp after jump placeholder of snippet expansion
if has('nvim')
  vnoremap <nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#nvim_scroll(1, 1) : "\<C-f>"
  vnoremap <nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#nvim_scroll(0, 1) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR :call CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

nmap <leader><leader>p :Format<CR>

" Search results centered please
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz

" Very magic by default
nnoremap ? ?\v
nnoremap / /\v
cnoremap %s/ %sm/

let g:lognroll#enable_insert_mode = 0

" coc.vim
let g:coc_global_extensions = [
  \ 'coc-rescript',
  \ 'coc-reason',
  \ 'coc-prettier',
  \ 'coc-json',
  \ 'coc-git',
  \ 'coc-eslint',
  \ 'coc-yaml',
  \ 'coc-tsserver',
  \ 'coc-rust-analyzer',
\]

let g:rustfmt_autosave = 1

" Don't jump around when using * to search for word under cursor
" Often I just want to see where else a word appears
nnoremap * :let @/ = '\<'.expand('<cword>').'\>'\|set hlsearch<C-M>

" Save file with sudo by doing :w!!
cmap w!! w !sudo tee % >/dev/null
