function! opendev#homepage_for_remote(remote) abort
  let domain_match = '^https\=://\zs\(opendev.org\)[/:].\{-\}\ze\%(\.git\)\=$'
  let root = matchstr(a:remote, domain_match)
  if empty(root)
    return ''
  endif
  return root
endfunction

function! opendev#fugitive_handler(opts, ...) abort
  let path   = substitute(get(a:opts, 'path', ''), '^/', '', '')
  let line1  = get(a:opts, 'line1')
  let line2  = get(a:opts, 'line2')
  let remote = get(a:opts, 'remote')

  let root = opendev#homepage_for_remote(remote)
  if empty(root)
    return ''
  endif

  if path =~# '^\.git/refs/heads/'
    return root . '/src/branch/' . path[16:-1]
  elseif path =~# '^\.git/refs/tags/'
    return root . '/src/tag/' . path[15:-1]
  elseif path =~# '^\.git\>'
    return root
  endif
  if a:opts.commit =~# '^\d\=$'
    return ''
  else
    let commit = a:opts.commit
  endif

  let path = get(a:opts, 'path', '')
  let url = root . "/src/branch/" . commit . '/' . path
  if line2 
    let url = root . "/src/commit/" . commit . '/' . path
    if line1 == line2
      let url .=  '#L' . line1
    else
      let url .= '#L' . line1 . '-L' . line2
    endif
  endif

  return url
endfunction
