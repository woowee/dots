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
" set background=dark
" let g:solarized_termcolors=256
" colorscheme solarized
colorscheme ir_black

" 透過
" gui
if has('mac')
  " set transparency=10
  set transparency=18   "colorscheme ir_black
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
  set guifont=Ricty_Diminished:h16
elseif has('mac')
  set guifont=Ricty_Diminished:h16
elseif has('xfontset')
  " UNIX用 (xfontsetを使用)
  set guifontset=a14,r14,k14
endif

"-------------------------------------------------- .IM
"" インサートモード抜ける時 ime オフ
set noimdisable
set iminsert=0 imsearch=0
set noimcmdline
" set noimdisableactivate

" im 状態でカーソル色変更(ひらがな入力モード時、赤)
if has('xim')
    " highlight Cursor guifg=NONE guibg=White
    highlight CursorIM guifg=NONE guibg=Red

"    inoremap {} {}<Left>
"    inoremap [] []<Left>
"    inoremap () ()<Left>
"    inoremap <> <><Left>
"    inoremap "" ""<Left>
"    inoremap '' ''<Left>
"    inoremap `` ``<Left>
endif

