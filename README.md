vim-breakgutter
=============
### Creates breakpoints for debuggers ###

I prefer to do debug sessions in a separate gdb instance and wanted
a convenient way to launch gdb with my breakpoints already defined.

vim-breakgutter simply adds break-signs to the gutter and provides the
method "GetGdbBreakpointArgs()" when spawning gdb from Vim.

GetGdbBreakpointArgs() returns a gdb argument string in the format:
"-ex file1.c:10 -ex file2.c:20" read by gdb upon start.


## Commands
Example of leader key mappings:
```
" set a breakpoint on the cursor line
nnoremap <leader>bb :BreakpointSet<cr>

" clear the breakpoint on the cursor line
nnoremap <leader>bc :BreakpointClear<cr>

" clear all breakpoints
nnoremap <leader>b<space> :BreakpointClearAll<cr>
```

## Typical usage

```
" start a gdb session in a separate terminal
nnoremap <leader>g :exec "!urxvt -e gdb" . GetGdbBreakpointArgs()<cr>

" spawn a gdb session in a separate terminal using Tim Pope's vim-dispatch plugin
nnoremap <leader>g :exec "Spawn urxvt -e gdb" . GetGdbBreakpointArgs()<cr>

```
