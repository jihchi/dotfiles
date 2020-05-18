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

" Retro groove color scheme for Vim - community maintained edition
Plug 'gruvbox-community/gruvbox'


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

" Intellisense engine for Vim8 & Neovim, full language server protocol support as VSCode
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Vim configuration for Rust.
Plug 'rust-lang/rust.vim'

" Plugin to toggle, display and navigate marks
Plug 'kshenoy/vim-signature'

call plug#end()

syntax on
colorscheme gruvbox
set background=dark " Setting dark mode
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
nnoremap <silent> <Leader>s :BLines<CR>
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
set signcolumn=yes

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
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
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
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
nmap <leader><leader>p :Format<CR>


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

" Remap keys for applying codeAction to the current line.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Introduce function text object
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <TAB> for selections ranges.
" NOTE: Requires 'textDocument/selectionRange' support from the language server.
" coc-tsserver, coc-python are the examples of servers that support it.
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
let g:lightline = {
  \ 'colorscheme': 'wombat',
  \ 'active': {
  \   'left': [ [ 'mode', 'paste' ],
  \             [ 'cocstatus', 'readonly', 'filename', 'modified' ] ]
  \ },
  \ 'component_function': {
  \   'cocstatus': 'coc#status'
  \ },
  \ }

" Use auocmd to force lightline update.
autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()
