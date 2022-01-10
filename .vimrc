set nocompatible " be iMproved, required
filetype off     " required

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" install with PlugInstall command
" Keep Plug commands between plug#begin() and plug#end().
call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-fugitive'         " :Gblame
Plug 'sheerun/vim-polyglot'       " syntax for most languages
Plug 'delphinus/vim-firestore'    " syntax for firestore security rules
Plug 'vim-airline/vim-airline'    " Vim powerline
Plug 'ctrlpvim/ctrlp.vim'         " Fuzzy search
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'nanotech/jellybeans.vim'
Plug 'joshdick/onedark.vim'

" All of your Plugins must be added before the following line
call plug#end()              " required

syntax on
set re=0
filetype plugin indent on

let mapleader = "g"

" Disable backups and swap files
set nobackup
set nowritebackup
set noswapfile

" TextEdit might fail if hidden is not set.
set hidden

" prettier
" map space to something more useful
nnoremap <space> :Prettier<CR>
command! -nargs=0 Prettier :call CocAction('runCommand', 'prettier.formatFile')

" Javascript supports flow syntax
let g:javascript_plugin_flow = 1

" CtrlP ignore module and git folders
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']

" Use english for spellchecking, but don't spellcheck by default
if version >= 700
  " turn on spell checking for these files
  autocmd FileType tex setlocal spell spelllang=en_us
endif

set encoding=utf-8

" powerline fonts
let g:airline_powerline_fonts = 1

" toggle paste mode
nnoremap <leader>p :set paste!<CR>

" up and down go by screen instead of by line 
nmap j gj
nmap k gk

" cycle through buffers
noremap L :bnext<CR>
noremap H :bprev<CR>

" remap scroll up and down
noremap J <C-d>
noremap K <C-u>

" always switch to current directory
set autochdir

" Better search
set hlsearch
set incsearch
set ignorecase
set smartcase

" Indenting
set autoindent
set smartindent

set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab

" Visual
set number
set nohls
set showcmd

" change curser highlight colors for match parens
highlight MatchParen ctermbg=4
highlight Pmenu ctermbg=black ctermfg=white guibg=black

" theme configs
" NOTE: italics will cause bad highlighting in terminals that don't support italics
" let g:jellybeans_use_term_italics = 1
let g:jellybeans_overrides = {
\    'background': { 'guibg': '000000' },
\}
" let g:onedark_terminal_italics = 1
let g:onedark_color_overrides = {
\ "black": {"gui": "#000000", "cterm": "0", "cterm16": "0" },
\}
let g:airline_theme = 'onedark'

set background=dark	
set termguicolors
colorscheme onedark

" behavior
set backspace=indent,eol,start
set showmatch

" status line stuff
set laststatus=2
set statusline=%F%m%r%h%w\ (%{&ff}){%Y}\ [%l,%v][%p%%]

set shellslash
set grepprg=grep\ -nH\ $*
let g:tex_flavor='latex'

" Fonts and window options
if has("gui_running")
	set gfn=Courier_New:h9:cANSI
	set guioptions-=T	" remove toolbar
endif

" remap sequence to escape insert mode
inoremap jk <Esc>

" no longer press shift to enter commands
nnoremap ; :
nnoremap : ;
vnoremap ; :
vnoremap : ;

" easy split screen nav
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

" no error bells
set noerrorbells

" wild menu on bottom
set wildmenu
set wildmode=list:longest,full
set wildignore=*.dll,*.o,*.obj,*.bak,*.exe,*.pyc,*.jpg,*.gif,*.png,*.swp,*~

" use mouse everywhere
set mouse=a

" map tab keys
nnoremap <silent> <C-Right> :tabnext<CR>
nnoremap <silent> <C-Left> :tabprevious<CR>
nnoremap <silent> <C-Up> :tabnew<CR>
nnoremap <silent> <C-Down> :tabclose<CR>
nnoremap <silent> <C-t> :tabnew<CR>

" map the function keys to switch tabs
nnoremap <F2> 1gt
nnoremap <F3> 2gt
nnoremap <F4> 3gt
nnoremap <F5> 4gt
nnoremap <F6> 5gt
nnoremap <F7> 6gt
nnoremap <F8> 7gt
nnoremap <F9> 8gt
nnoremap <F10> 9t
nnoremap <F11> 10gt
nnoremap <F12> 11gt

" center on searchs
map N Nzz
map n nzz

" CoC Settings

" CoC extensions
let g:coc_global_extensions = ['coc-solargraph', 'coc-tsserver', 'coc-json']

" Add CoC Prettier if prettier is installed
if isdirectory('./node_modules') && isdirectory('./node_modules/prettier')
  let g:coc_global_extensions += ['coc-prettier']
endif

" Add CoC ESLint if ESLint is installed
if isdirectory('./node_modules') && isdirectory('./node_modules/eslint')
  let g:coc_global_extensions += ['coc-eslint']
end

" Give more space for displaying messages.
set cmdheight=2

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

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> <leader>d <Plug>(coc-definition)
nmap <silent> <leader>y <Plug>(coc-type-definition)
nmap <silent> <leader>i <Plug>(coc-implementation)
nmap <silent> <leader>r <Plug>(coc-references)

" Use <leader>d to show documentation in preview window.
nnoremap <silent><leader>d :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocActionAsync('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

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

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
