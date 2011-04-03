"" Syntax highlighting for MU log files
syntax match logDate /^\d\{4}-\d\{2}-\d\{2}/ containedin=logDateTimeTypeLine nextgroup=logTime skipwhite
syntax match logTime /\d\{2}:\d\{2}:\d\{2},\d\{3}/ containedin=logDateTimeTypeLine,logTrace
syntax match logDateTimeTypeLine /^\d\{4}-\d\{2}-\d\{2} \d\{2}:\d\{2}:\d\{2},\d\{3}.*/
syntax region logTrace matchgroup=logErrorStartLine start=/^\d\{4}-\d\{2}-\d\{2} \d\{2}:\d\{2}:\d\{2},\d\{3}.*ERROR.*/ms=s,rs=e+1 end=/^\d\{4}-\d\{2}-\d\{2} \d\{2}:\d\{2}:\d\{2},\d\{3}/me=s-1,he=s-1,re=s-1
hi link logTrace Error
hi link logDateTimeTypeLine Keyword
hi link logDate String
hi link logTime Comment
hi logErrorStartLine guifg=red
" Syntaxt highlighting ends
