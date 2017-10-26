" breakgutter.vim - Creates breakpoints for debuggers
" Author:       Jörgen Scott (jorgen.scott@gmail.com)
" Version:      0.1

if exists("g:loaded_breakgutter")
    finish
endif
let g:loaded_breakgutter = 1

sign define breakpoint text=B texthl=special
let s:breakpoint_id = 8236

" public interface
command -nargs=0 BreakpointSet call s:SetBreakpoint()
command -nargs=0 BreakpointClear call s:ClearBreakpoint()
command -nargs=0 BreakpointClearAll call s:ClearAllBreakpoints()

function! GetGdbBreakpointArgs()
    let l:args = ""
    let l:breakpoints = FindBreakpoints()
    for breakpoint in l:breakpoints
        let l:args .= " \-ex=\"b " . breakpoint . "\""
    endfor
    return l:args
endfunction

function! FindBreakpoints()
    let l:breakpoints = []  " <filename:linenumber>

    redir => signs
    silent execute "sign place"
    redir END

    let curr_file = ""
    for sign_line in split(signs, '\n')[1:]
        if sign_line =~ ":"
            let curr_file = reverse(split(sign_line, " "))[0]
        else
            let components = split(sign_line)
            let name = split(components[2], '=')[1]
            if name =~ 'breakpoint'
                let line_number = str2nr(split(components[0], '=')[1])
                call add(breakpoints, curr_file . line_number)
            endif
        endif
    endfor

    return breakpoints
endfunction


" local methods
function! s:SetBreakpoint()
    execute "silent! sign place " . s:breakpoint_id . " line=" . line(".") . " name=breakpoint file=" . expand("%:p")
endfunction

function! s:ClearBreakpoint()
    execute "silent! sign unplace"
endfunction

function! s:ClearAllBreakpoints()
    execute "silent! sign unplace ". s:breakpoint_id
endfunction


