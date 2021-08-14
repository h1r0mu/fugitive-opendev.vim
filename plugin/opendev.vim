if exists('g:loaded_fugitive_opendev')
    finish
endif
let g:loaded_fugitive_opendev = 1


if !exists('g:fugitive_browse_handlers')
    let g:fugitive_browse_handlers = []
endif

if index(g:fugitive_browse_handlers, function('opendev#fugitive_handler')) < 0
    call insert(g:fugitive_browse_handlers, function('opendev#fugitive_handler'))
endif
