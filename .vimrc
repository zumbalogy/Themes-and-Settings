set backspace=indent,eol,start
" map control-backspace to delete the previous word
:imap <C-BS> <C-W>
:au FocusLost * :wa
:au FocusLost * silent! wa
:au! CursorHoldI,CursorHold,BufLeave <buffer> silent! :update
