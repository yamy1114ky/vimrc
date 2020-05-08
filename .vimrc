
" settings
set expandtab
set tabstop=2
set shiftwidth=2
set encoding=utf-8
set fileencodings=utf-8,iso-2022-jp
if has('mouse')
  set mouse=a
endif
set whichwrap=b,s,h,l,<,>,[,]
set number
syntax on
colorscheme jellybeans
set t_Co=256
let g:neocomplcache_enable_at_startup = 1
let g:user_emmet_leader_key = '<C-E>'
set laststatus=2
autocmd BufWritePre * :%s/\s\+$//ge

" mappers
inoremap <silent><C-e> :NERDTreeToggle<CR>
inoremap { {}<LEFT>
inoremap ( ()<LEFT>
inoremap < <><LEFT>
inoremap " ""<LEFT>
inoremap ' ''<LEFT>
inoremap [ []<LEFT>
inoremap <expr> % CreateErbSnippet()
inoremap <expr> ⇒ JumpEndOfBracket()
nnoremap <expr> <C-j> "\<Esc>10j"
nnoremap <expr> <C-k> "\<Esc>10k"
nnoremap <expr> <C-h> "\<Esc>10h"
nnoremap <expr> <C-l> "\<Esc>10l"


imap <buffer> <expr><CR> pumvisible() ? neocomplcache#smart_close_popup() : IndentBracesDoEndwise()
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : EscapeBraces()

" 括弧や begin ~ end などの位置を調整して入力しやすくする
function! IndentBracesDoEndwise()
  let nowletter = getline(".")[col(".")-1]
  let beforeletter = getline(".")[col(".")-2]
  if (nowletter == "}" && beforeletter == "{") || (nowletter == "]" && beforeletter == "[") || (nowletter == ")" && beforeletter == "(")
    return "\n\n\<UP>\t"
  else
    return "\<CR>\<Plug>DiscretionaryEnd"
  endif
endfunction

" tab で括弧内からエスケープ
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

" Shift+Enter で次の閉じ括弧までジャンプ
" （itemr2 の設定で Shift+Enter を別の文字に置き換えておく必要あり）
function! JumpEndOfBracket()
  return "\<Esc>/\\v(\}|\\]|\\)|end)\<CR>\<Esc>A"
endfunction

function! CreateErbSnippet()
  if getline(".")[col(".")-2] == '<'
    return "%%\<LEFT>"
  else
    return ''
  endif
endfunction

"---------------------------
" Start Neobundle Settings.
"---------------------------
set runtimepath+=~/.vim/bundle/neobundle.vim/

" Required:
"
call neobundle#begin(expand('~/.vim/bundle/'))

NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'scrooloose/nerdtree'
" NeoBundle 'Townk/vim-autoclose'
NeoBundle 'Shougo/neocomplcache'
""NeoBundle 'tomasr/molokai'
NeoBundle 'nanotech/jellybeans.vim'
" NeoBundle 'jiangmiao/simple-javascript-indenter'
NeoBundle 'mattn/emmet-vim'
NeoBundle 'vim-airline/vim-airline'
NeoBundle 'vim-airline/vim-airline-themes'
" NeoBundle 'tpope/vim-endwise'
NeoBundle 'yamy1114ky/vim-endwise'
NeoBundle 'leafgarland/typescript-vim'
" NeoBundle 'Shougo/vimproc'
NeoBundle 'Quramy/tsuquyomi'
" NeoBundle 'thinca/vim-quickrun'
NeoBundle 'Shougo/vimproc', {
    \ 'build' : {
    \     'windows' : 'make -f make_mingw32.mak',
    \     'cygwin' : 'make -f make_cygwin.mak',
    \     'mac' : 'make -f make_mac.mak',
    \     'unix' : 'make -f make_unix.mak',
    \    },
    \ }

call neobundle#end()

" Required:
filetype plugin indent on

NeoBundleCheck

"-------------------------
" End Neobundle Settings.
"-------------------------


