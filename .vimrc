syn on
colo inkpot
set ttymouse=xterm2
set t_Co=256
set mouse=n
set autoindent
set autoread
set cinoptions=:0,p0,t0,(0,g0,N-s
set cinwords=if,else,while,do,for,switch,case
set confirm
"set diffopt+=iwhite
set formatoptions=tcqr
set hlsearch
set km=startsel
set nocompatible
set restorescreen
set ruler
set showcmd
"set slm=mouse,key
set smartcase
set wildmode=longest,full
set cin
set tw=0 sw=4 ts=4 sts=4 et
set nocp incsearch
set scrolloff=1
set wrap
set tags=tags
set foldlevel=1
set tabpagemax=100
set backspace=indent,eol,start
filetype plugin on
filetype plugin indent on
au BufNewFile,BufRead *gdb* set filetype=gdb
au BufNewFile,BufRead *.val set filetype=valgrind
au BufNewFile,BufRead *.st set filetype=strace
au BufNewFile,BufRead *.jelly set filetype=html
au BufRead,BufNewFile *.proto set filetype=proto
au FileType xml exe ":silent '<,'>!xmllint --format --recover - 2>/dev/null"
autocmd BufNewFile,BufRead *.json set ft=javascript
autocmd BufRead,BufNewFile *.log set syntax=log
if has("autocmd")
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
endi
"map <F7> exe ":silent '<,'>!xmllint --format --recover - 2>/dev/null"

if has('gui_running')
    colo ir-black
    set gfn=Monospace\ 10
    set go=caeim
    set gcr+=a:blinkon0
    set nowrap
    set mouse=
endif

let g:DirDiffExcludes = "*.git,*.class,*.exe,.*.swp,*.hg,*.o,*.so"
let g:DirDiffIgnore = "Id:,Revision:,Date:"
let g:DoxygenToolkit_commentType = "C++"
let g:DirDiffSort = 1
let g:DirDiffWindowSize = 7
let g:DirDiffIgnoreCase = 0
let g:DirDiffDynamicDiffText = 0
let g:DirDiffTextFiles = "Files "
let g:DirDiffTextAnd = " and "
let g:DirDiffTextDiffer = " differ"
let g:DirDiffTextOnlyIn = "Only in "
let g:DoxygenToolkit_briefTag_pre = ""
let g:load_doxygen_syntax=1

set omnifunc=syntaxcomplete#Complete " override built-in C omnicomplete with C++ OmniCppComplete plugin
let OmniCpp_GlobalScopeSearch   = 1
let OmniCpp_DisplayMode         = 1
let OmniCpp_ShowScopeInAbbr     = 0 "do not show namespace in pop-up
let OmniCpp_ShowPrototypeInAbbr = 1 "show prototype in pop-up
let OmniCpp_ShowAccess          = 1 "show access in pop-up
let OmniCpp_SelectFirstItem     = 1 "select first item in pop-up
set completeopt=menuone,menu,longest

fun! ShowFuncName()
    let lnum = line(".")
    let col = col(".")
    echohl ModeMsg
    echo getline(search("^[^ \t#/]\\{2}.*[^:]\s*$", 'bW'))
    echohl None
    call search("\\%" . lnum . "l" . "\\%" . col . "c")
endfun
nmap \ :call ShowFuncName()<cr>

" Custom key maps
nmap <C-i> gt
nmap <S-Tab> gT
map <C-p> :diffoff!<cr>
map <C-s> :vert diffs 
map <C-d> :diffthis<cr>
map tt :TlistToggle<cr>
map tr :NERDTreeToggle<cr>
map Y gqgq
map Q i<cr><esc>l
map <F2> :wn<cr>
map <F3> :qa<cr>
map <F5> :make clean && make<cr><cr><cr>
map <F6> :tabe<space>
"map <F7> :make clean && make -j10<cr><cr><cr>
map <F8> :se paste!<cr>
map <F9> :%s,\s\+$,,<cr>
map <F10> :se wrap!<cr>
map <F11> :%!xxd<cr>
map <F12> :%!xxd -r<cr>
map cn :cnext<cr>
map cp :cprev<cr>
map co :cope<cr><c-w>J
map cc :ccl<cr>
map Sc :grep <cword> src/*.*<cr>
map SS :grep <cword> Common/*.cpp Common/*.h MU/*.cpp MU/*.h<cr>
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>

" Disable arrow keys, yeah, I'm serious
noremap <up> <esc>
inoremap <up> <nop>
noremap <down> <esc>
inoremap <down> <nop>
noremap <right> <esc>
inoremap <right> <nop>
noremap <left> <esc>
inoremap <left> <nop>

" Special settings to include date and my name in TODO FIXME and comments
ab cO Arun \|<esc>:r!date +\%d\%b\%y\ \\|<esc>kJA
ab FIXME FIXME: Arun \|<esc>:r!date +\%d\%b\%y\ \\|<esc>kJA
ab TODO TODO: Arun \|<esc>:r!date +\%d\%b\%y\ \\|<esc>kJA
ab aU @author Arun Chandrasekaran <visionofarun@gmail.com>
cnoreabbrev W w
