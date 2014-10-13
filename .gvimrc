" -------------------------------------------------- .common
" menu，toolbar を消す
if has ('win32') || ('win63')
  set guioptions-=m
  set guioptions-=T
elseif has ('mac')
  set guioptions-=""
endif

" フルスクリーン化
if has ('win32') || ('win64')
 au GUIEnter * simalt ~x
elseif has ('mac')
 set fuoptions=maxvert,maxhorz
 au GUIEnter * set fullscreen
endif

"-------------------------------------------------- .appearance
" カラースキーマ
" colorscheme molokai
" colorscheme hybrid
set background=dark
let g:solarized_termcolors=256
colorscheme solarized
if has('xim')
    " highlight Cursor guifg=NONE guibg=White
    highlight CursorIM guifg=NONE guibg=Red
endif

" 透過
" gui
if has('mac')
  set transparency=10
  " set transparency=2
elseif has('win32') || has('win64')
  set transparency=200
endif

" フォント
if has('win32')
  " Windows用
  set guifont=MS_Gothic:h12:cSHIFTJIS
  " 行間隔の設定
  set linespace=1
  " 一部のUCS文字の幅を自動計測して決める
  if has('kaoriya')
    set ambiwidth=auto
  endif
elseif has('gui_macvim')
  set guifont=Ricty:h16
elseif has('mac')
  set guifont=Ricty:h16
elseif has('xfontset')
  " UNIX用 (xfontsetを使用)
  set guifontset=a14,r14,k14
endif
