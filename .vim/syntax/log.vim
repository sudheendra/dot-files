"" A simple syntax highlighter for the log files
"" Add the following to your ~/.vimrc file
"" autocmd BufRead,BufNewFile *.log set syntax=log
if exists("b:current_syntax")
    finish
endif

"" This creates a keyword ERROR and puts it in the highlight group called logError
"syn keyword logError ERROR
"" This creates a match on the date and puts in the highlight group called logDate.  The
"" nextgroup and skipwhite makes vim look for logTime after the match
"syn match logDate /^\d\{4}-\d\{2}-\d\{2}/ nextgroup=logTime skipwhite

"" This creates a match on the time (but only if it follows the date)
"syn match logTime /\d\{2}:\d\{2}:\d\{2}.\d\{3}/ nextgroup=logThread contained skipwhite
"syn match logThread /\d\+/  nextgroup=logLevel contained skipwhite
"syn match logLevel /\d\+/  nextgroup=logFile contained skipwhite
"syn match logFile /\d\+:/  nextgroup=logLine contained skipwhite
"syn match logFunc /\d\+:/  nextgroup=logLine contained skipwhite
"syn match logLine /\d\+/  nextgroup=logMsg contained skipwhite

"" Now make them appear:
"" Link just links logError to the colouring for error
"hi link logError Error
"" Def means default colour - colourschemes can override
"hi def logDate		ctermfg=darkgray
"hi def logTime		ctermfg=blue
"hi def logThread	ctermfg=lightgreen
"hi def logLevel		ctermfg=white
"hi def logFile		ctermfg=lightyellow
"hi def logFunc		ctermfg=lightred
"hi def logLine		ctermfg=darkgray

""syn match group1 /^\d\+-\d\+-\d\{2}/ nextgroup=group2 skipwhite
""syn match group2 /\d\+:\d\+:\d\+\.\d\{3}/ nextgroup=group3 contained skipwhite
""syn match group3 /\d\{2}/ nextgroup=group4 contained skipwhite

""hi link group1 Comment
""hi link group2 Conditional
""hi link group3 Comment
""hi def group4  ctermfg=lightgreen
""syn keyword logError ERROR
""hi link logError Error

syntax region fatal start=/^\d\{2}-\d\{2}.*FATAL.*/ end=/\n\d\{2}-\d\{2}/me=s-1,re=s-1
syntax region error start=/^\d\{2}-\d\{2}.*ERROR.*/ end=/\n\d\{2}-\d\{2}/me=s-1,re=s-1
syntax region warn start=/^\d\{2}-\d\{2}.*WARN.*/ end=/\n\d\{2}-\d\{2}/me=s-1,re=s-1
syntax region info start=/^\d\{2}-\d\{2}.*INFO.*/ end=/\n\d\{2}-\d\{2}/me=s-1,re=s-1
syntax region debug start=/^\d\{2}-\d\{2}.*STAMP.*/ end=/\n\d\{2}-\d\{2}/me=s-1,re=s-1
"syntax region trace start=/^\d\{2}-\d\{2}.*TRACE.*/ end=/\n\d\{2}-\d\{2}/me=s-1,re=s-1

" Highlight colors for log levels.
hi fatal ctermfg=DarkRed ctermbg=Black
hi error ctermfg=Red ctermbg=Black
hi warn ctermfg=Magenta ctermbg=Black
hi info ctermfg=LightGreen ctermbg=Black
hi stamp ctermfg=LightCyan ctermbg=Black
"hi trace ctermfg=LightMagenta ctermbg=Black

let b:current_syntax = "log"
