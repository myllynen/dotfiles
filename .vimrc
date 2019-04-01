" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

set   autoindent             " take indent for new line from previous line
set   backspace=2            " allow backspacing over everything in Insert mode
set nobackup                 " do not keep a backup file
set   confirm                " confirm operations on unsaved/read-only files
set nocursorline             " highlight the screen line of the cursor
set   directory=~/.cache/vim " list of directory names for the swap file
set   errorbells             " ring the bell for error messages
set   expandtab              " use spaces when <Tab> is inserted
set   history=100            " number of command-lines that are remembered
set   ignorecase             " ignore case in search patterns
set   incsearch              " highlight match while typing search pattern
set   joinspaces             " two spaces after a period with a join command
set   laststatus=2           " tells when last window has status lines
set   lazyredraw             " don't redraw while executing macros
set   matchpairs+=<:>        " pairs of characters that "%" can match
set   ruler                  " show cursor line and column in the status line
set   scrolloff=2            " minimum nr. of lines above and below cursor
set   shiftwidth=4           " number of spaces to use for (auto)indent step
set   showbreak=\\           " string to use at the start of wrapped lines
set   showcmd                " show (partial) command in status line
set   showmatch              " briefly jump to matching bracket if insert one
set   showmode               " message on status line to show current mode
set   showtabline=1          " tells when the tab pages line is displayed
set   smartcase              " no ignore case when pattern has uppercase
set   smartindent            " smart autoindenting for C programs
set   smarttab               " use 'shiftwidth' when inserting <Tab>
set   softtabstop=4          " number of spaces that <Tab> uses while editing
set   splitbelow             " new window from split is below the current one
set   splitright             " new window is put right of the current one
set   startofline            " commands move cursor to first non-blank in line
set   swapfile               " whether to use a swapfile for a buffer
set notitle                  " let Vim set the title of the window
set   ttyfast                " indicates a fast terminal connection
set   visualbell             " use visual bell instead of beeping
set   viminfo=""             " use .viminfo file upon startup and exiting
set   wildmenu               " use menu for command line completion
set   wildmode=longest:list,full " mode for 'wildchar' command-line expansion

" jk is escape
noremap jk <Esc>
noremap! jk <Esc>

" leader is minus
let mapleader = "-"

" reload configuration
noremap <Leader>r :so ~/.vimrc<CR>:echo "~/.vimrc reloaded"<CR>

" timeouts
set ttimeout ttimeoutlen=500

" create swapfile directory on startup
if !isdirectory($HOME . "/.cache/vim")
  call mkdir($HOME . "/.cache/vim", "p", 0700)
endif

" toggle mouse on or off
nnoremap <Leader>m :exec &mouse != "" ? "set mouse=" : "set mouse=a"<CR>
  \<Bar>:exec &mouse != "" ? "echo 'mouse on'" : "echo 'mouse off'"<CR>

" support resizing with mouse in tmux
if exists('$TMUX') | set ttymouse=xterm2 | endif

" toggle line numbers on or off
nnoremap <silent> <Leader>l :set number!<CR>

" toggle folding on or off
nnoremap <silent> <Leader>f :set foldenable!<CR>

" folding style
set nofoldenable
set   foldlevel=1
set   foldmethod=indent
set   foldnestmax=2
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>

" handle paste automatically
let &t_SI .= "\<Esc>[?2004h"
let &t_EI .= "\<Esc>[?2004l"
function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunction
inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()

if &t_Co > 2 || has("gui_running")
  syntax on                    " syntax to be loaded for current buffer
  set hlsearch                 " highlight matches with last search pattern
  noremap <silent> <Leader><CR> :nohlsearch<CR>" stop highlighting matches
endif

" go to first character or column
function! FirstCharOrFirstCol()
  let current_col = virtcol('.')
  normal ^
  let first_char = virtcol('.')
  if current_col == first_char
    normal 0
  endif
endfunction
noremap <silent> ga :call FirstCharOrFirstCol()<CR>

" select text entered
nnoremap gV `[v`]

" remove all trailing whitespace
nnoremap <Leader>tw :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<CR>

if has("autocmd")
  " file type detection and settings, do language-dependent indenting
  filetype plugin indent on
  " function for filetype-specific completion
  set omnifunc=syntaxcomplete#Complete

  augroup local
  autocmd!

  " rebalance windows on vim resize
  autocmd VimResized * :wincmd =

  " style based on file type
  autocmd FileType make setlocal noexpandtab shiftwidth=8
  autocmd FileType sh setlocal tabstop=2 shiftwidth=2 softtabstop=2
  autocmd FileType yaml setlocal tabstop=2 shiftwidth=2 softtabstop=2

  " highlight trailing whitespace
  highlight ExtraWhitespace ctermbg=red guibg=red
  match ExtraWhitespace /\s\+$/

  augroup END
endif

" tab completion or regular tab after space
function! InsertTabWrapper(direction)
  let idx = col('.') - 1
  let str = getline('.')
  if a:direction == "backward" && idx >= 2 && str[idx - 1] == ' '
      \ && str[idx - 2] =~? '[a-z]'
    if &softtabstop && idx % &softtabstop == 0
      return "\<BS>\<Tab>\<Tab>"
    else
      return "\<BS>\<Tab>"
    endif
  elseif idx == 0 || str[idx - 1] !~? '[a-z]'
    return "\<Tab>"
  elseif a:direction == "backward"
    return "\<C-p>"
  else
    return "\<C-n>"
  endif
endfunction
inoremap <expr> <silent> <Tab> InsertTabWrapper("forward")
inoremap <expr> <silent> <S-Tab> InsertTabWrapper("backward")

" indent lines appropriately
noremap <silent> <Leader><Tab> ==
inoremap <silent> <Leader><Tab> <C-o>==

" diff against original
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
    \ | wincmd p | diffthis | wincmd w
endif

" pylint
function! RunPyLint()
  cclose
  let l:makeprg_save = &makeprg
  let &makeprg = 'pylint --output-format=parseable --reports=n'
  silent! make! %
  let &makeprg = l:makeprg_save
  let l:mod_total = 0
  let l:win_count = 1
  windo let l:win_count = l:win_count + 1
  if l:win_count <= 2 | let l:win_count = 4 | endif
  windo let l:mod_total = l:mod_total + winheight(0)/l:win_count |
    \ execute 'resize +'.l:mod_total
  execute 'belowright copen '.l:mod_total
  redraw!
endfunction
noremap <silent> <F3> :call RunPyLint()<CR>
noremap! <silent> <F3> :call RunPyLint()<CR>
