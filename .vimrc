" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

set   autoindent             " Always set autoindenting
set nobackup                 " Keep backup files
set   bs=2                   " Allow backspacing over everything in insert mode
set   confirm                " Confirm operations
set   expandtab              " Use spaces, not tabs
set   history=100            " Keep N lines of command line history
set   hlsearch               " Highlight the target of a search
set noignorecase             " case sensitive search
set   incsearch              " Do incremental searching
set   joinspaces             " Add two spaces after ., ?, !
set   laststatus=2           " Statusline
set   mps+=<:>               " Also make a pair of these
set   ruler                  " Show the cursor position all the time
set   shiftwidth=4           " Size of indentation
set   softtabstop=4          " Number of spaces that a <Tab> counts for
set   showbreak=\\           " Indicator for wrapped lines
set   showcmd                " Display incomplete commands
set   showmatch              " Show matching brackets
set   showmode               " Show current mode always
set   smartindent            " Try to be smart
set   smarttab               " Insert sw spaces when using tab in front of line
set   tabstop=8              " Must be 8. Always. End of story.
set notitle                  " Set xterm title
set   ttyfast                " Indicates a fast terminal connection
set   errorbells             " Signal errors
set   visualbell             " Visual beeps instead of audio beeps
set   viminfo=""             " Disable viminfo

" Switch syntax highlighting on, when the terminal has colors
if &t_Co > 2 || has("gui_running")
  syntax on
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  if v:version >= 600
    filetype on
    filetype plugin on
    filetype indent on
  endif

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif

  " Use real tabs with makefiles
  autocmd FileType make set noexpandtab shiftwidth=8

endif " has("autocmd")

" Smart mapping for tab completion
if v:version >= 600
  function! InsertTabWrapper(direction)
    let oldisk=&isk "save the iskeyword options
    set isk+=(,),,  "add '(' ')' and ',' character
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
      return "\<tab>"
    elseif "backward" == a:direction
      return "\<c-n>"
    else
      return "\<c-p>"
    endif
    set &isk=oldisk "restore the iskeyword options
  endfunction
  inoremap <tab> <c-r>=InsertTabWrapper ("forward")<cr>
  inoremap <s-tab> <c-r>=InsertTabWrapper ("backward")<cr>
endif

" Indent only when appropriate
imap <tab> <c-o>==
map <tab> ==
