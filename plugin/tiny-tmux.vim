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
