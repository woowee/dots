" タブ
setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4

" 自動形成について(特に、自動改行) (:h formatoptions, :h fo-table)
" 文字数制限/行は解除
setlocal textwidth=0
" 自動改行を抑制
setlocal formatoptions-=t
setlocal formatoptions-=c
" コメントスタイルの自動挿入を抑制
setlocal formatoptions-=r
setlocal formatoptions-=o

" 強調 empasis のマークは見えるように．
set conceallevel=0


