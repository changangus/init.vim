syn region urlTitle matchgroup=mkdDelimiter start="\[" end="\]" oneline concealends nextgroup=urlRef
syn region urlRef matchgroup=mkdDelimiter start="(" end=")" oneline conceal contained

hi link urlTitle notesRealURL
hi link urlRef notesRealURL
