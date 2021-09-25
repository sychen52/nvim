fun! s:find_proc_in_tree(rootpid, names, accum) abort
    if a:accum > 9 || !exists('*nvim_get_proc')
        return v:false
    endif
    let p = nvim_get_proc(a:rootpid)
    if !empty(p) && index(a:names, p.name) >= 0
        return v:true
    endif
    for c in nvim_get_proc_children(a:rootpid)[:9]
        if s:find_proc_in_tree(c, a:names, 1 + a:accum)
            return v:true
        endif
    endfor
    return v:false
endfun
tnoremap <silent><expr> <esc> <SID>find_proc_in_tree(b:terminal_job_pid, ['nvim'], 0) ? '<esc>' : '<c-\><c-n>'
