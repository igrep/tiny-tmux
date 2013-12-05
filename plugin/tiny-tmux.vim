if exists("g:loaded_tiny_tmux")
  finish
endif

let g:loaded_tiny_tmux = 1

function! g:TinyTmuxSendKeys( target, ... )
  let keys = map( copy( a:000 ), "shellescape( v:val )" )
  call system( "tmux send-keys -t " . a:target . " " . join( keys, " " ) )
endfunction
command! -nargs=+ -complete=shellcmd TinyTmuxSendKeys call g:TinyTmuxSendKeys( <f-args> )

function! g:TinyTmuxSelectWindow( target )
  call system( "tmux select-window -t " . a:target )
endfunction
command! -nargs=+ -complete=shellcmd TinyTmuxSelectWindow call g:TinyTmuxSelectWindow( <f-args> )

function! g:TinyTmuxSendKeysSelectWindow( ... )
  call call( function('g:TinyTmuxSendKeys'), a:000 )
  call g:TinyTmuxSelectWindow( a:1 )
endfunction
command! -nargs=+ -complete=shellcmd TinyTmuxSendKeysSelectWindow call g:TinyTmuxSendKeysSelectWindow( <f-args> )

"
" nomenclature: adopt a name diffrent from tmux's commands when the function's behavior somewhat differs from them.
"
function! g:TinyTmuxSwitchPane( target )
  let target_window = substitute(
        \ a:target,
        \ '\v\.(([+-]?[0-9]+)|top|bottom|left|right|top-left|top-right|bottom-left|bottom-right)$',
        \ '', ''
        \ )
  call system( "tmux select-pane -t " . a:target )
  call system( "tmux select-window -t " . target_window )
endfunction
command! -nargs=+ -complete=shellcmd TinyTmuxSwitchPane call g:TinyTmuxSwitchPane( <f-args> )

function! g:TinyTmuxSendKeysSwitchPane( ... )
  call call( function('g:TinyTmuxSendKeys'), a:000 )
  call g:TinyTmuxSwitchPane( a:1 )
endfunction
command! -nargs=+ -complete=shellcmd TinyTmuxSendKeysSwitchPane call g:TinyTmuxSendKeysSwitchPane( <f-args> )
