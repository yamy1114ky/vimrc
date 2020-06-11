" Settings
"" visual
set number
set laststatus=2
set cursorline
set t_Co=256
syntax on

"" search
set hlsearch
set ignorecase
set smartcase

"" edit
set expandtab
set tabstop=2
set shiftwidth=2
set encoding=utf-8
set fileencodings=utf-8,iso-2022-jp
autocmd BufWritePre * :%s/\s\+$//ge
runtime macros/matchit.vim

"" move
set incsearch
set whichwrap=b,s,h,l,<,>,[,]
if has('mouse')
  set mouse=a
endif

"" plugin related
let g:neocomplcache_enable_at_startup = 1
let g:ale_fixers = { 'ruby': ['rubocop'] }
let g:user_emmet_leader_key = '<C-t>'

" Key Mappers
"" move
inoremap <expr> <C-a> "\<Esc>I"
inoremap <expr> <C-e> "\<Esc>A"
nnoremap <expr> <C-j> "\<Esc>10j"
nnoremap <expr> <C-k> "\<Esc>10k"
nnoremap <expr> <C-h> "\<Esc>10h"
nnoremap <expr> <C-l> "\<Esc>10l"
vnoremap <expr> <C-j> "10j"
vnoremap <expr> <C-k> "10k"
vnoremap <expr> <C-h> "10h"
vnoremap <expr> <C-l> "10l"
inoremap <expr> ⇒ JumpEndOfBracket()
inoremap <expr> <TAB> pumvisible() ? "\<C-n>" : EscapeBraces()

"" complement
inoremap { {}<LEFT>
inoremap ( ()<LEFT>
inoremap < <><LEFT>
inoremap " ""<LEFT>
inoremap ' ''<LEFT>
inoremap [ []<LEFT>
inoremap <expr> % CreateErbSnippet()
imap <buffer> <expr><CR> pumvisible() ? neocomplcache#smart_close_popup() : IndentBracesDoEndwise()

"" operation
inoremap jk <Esc>l
inoremap jwq <Esc>:wq<CR>
inoremap jww <Esc>:w<CR>
inoremap jqq <Esc>:q!<CR>
nnoremap <Esc><Esc> :noh<CR>
nnoremap / /\v
nnoremap ? :%s///g<LEFT><LEFT>
vnoremap / <Esc>/\%V\v
set pastetoggle=<C-p>

" Functions
function! IndentBracesDoEndwise()
  let nowletter = getline(".")[col(".")-1]
  let beforeletter = getline(".")[col(".")-2]
  if (nowletter == "}" && beforeletter == "{") || (nowletter == "]" && beforeletter == "[") || (nowletter == ")" && beforeletter == "(")
    return "\n\n\<UP>\t"
  else
    return "\<CR>\<Plug>DiscretionaryEnd"
  endif
endfunction

function! EscapeBraces()
  let nowletter = getline(".")[col(".")-1]
  let afterletter = getline(".")[col(".")]
  if nowletter == ")" || nowletter == "\"" || nowletter == "'" || nowletter == ">" || nowletter == "]" || nowletter == "}"
    return "\<RIGHT>"
  elseif nowletter == "%" && afterletter == ">"
    return "\<RIGHT>\<RIGHT>"
  else
    return "\t"
  endif
endfunction

function! JumpEndOfBracket()
  return "\<Esc>/\\v(\}|\\]|\\)|end)\<CR>\<Esc>:noh\<CR>A"
endfunction

function! CreateErbSnippet()
  if getline(".")[col(".")-2] == '<'
    return "%%\<LEFT>"
  else
    return '%'
  endif
endfunction

" Neobundle Plugin Managements
set runtimepath+=~/.vim/bundle/neobundle.vim/

call neobundle#begin(expand('~/.vim/bundle/'))

NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'w0ng/vim-hybrid'
NeoBundle 'mattn/emmet-vim'
NeoBundle 'vim-airline/vim-airline'
NeoBundle 'vim-airline/vim-airline-themes'
NeoBundle 'yamy1114ky/vim-endwise'
NeoBundle 'leafgarland/typescript-vim'
NeoBundle 'Quramy/tsuquyomi'
" NeoBundle 'w0rp/ale'

call neobundle#end()

filetype plugin indent on

NeoBundleCheck

" color schema (need to write neobundle#end())
set background=dark
colorscheme hybrid
