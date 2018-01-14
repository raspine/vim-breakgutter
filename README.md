vim-breakgutter
=============
### Creates breakpoints for debuggers ###

I prefer to do debug sessions in a separate gdb instance and wanted
a convenient way to launch gdb with my breakpoints initially defined.

vim-breakgutter simply adds break-signs to the gutter and then provide
the method `GetGdbBreakpointArgs()` when spawning gdb from Vim.

`GetGdbBreakpointArgs()` returns a gdb argument string in the format:
`-ex file1.c:10 -ex file2.c:20` read by gdb upon start.


## Commands
Example of leader key mappings:
```VimL
" set a breakpoint on the cursor line
nnoremap <leader>bb :BreakpointSet<cr>

" clear the breakpoint on the cursor line
nnoremap <leader>bc :BreakpointClear<cr>

" clear all breakpoints
nnoremap <leader>b<space> :BreakpointClearAll<cr>
```

## Typical usage

```VimL
" start a gdb session in a separate terminal
nnoremap <leader>g :exec "!urxvt -e gdb " . GetGdbBreakpointArgs()<cr>

" Spawn a gdb session in a separate terminal. The ending  '&' unlocks
" Vim while debugging.
nnoremap <leader>g :exec "!urxvt -e gdb " . GetGdbBreakpointArgs() . '&'<cr>

```

When combined with [vim-target](http://github.com/raspine/vim-target) I can launch
gdb with the executable target loaded as well:
```VimL
" start a gdb session in a separate terminal with target loaded as well
nnoremap <leader>g :exec "!urxvt -e gdb " . GetGdbBreakpointArgs(). " " . FindExeTarget()<cr>

" same but allows for adding program arguments and then hit return
nnoremap <leader>g :exec "!urxvt -e gdb " . GetGdbBreakpointArgs(). " --args " . FindExeTarget() . " "
```
## License

Distributed under the same terms as Vim itself.  See the vim license.
