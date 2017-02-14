" Encoding
if !exists ('g:encoding_set') || !has('nvim')
    set encoding=utf-8
    let g:encoding_set=1
endif
scriptencoding utf-8


"--------------------------------------------------------------------------- >manage plugins
"
" Dein.vim
"
" ref. http://qiita.com/kawaz/items/ee725f6214f91337b42b#%E8%A8%AD%E5%AE%9A%E4%BE%8B
" ref. http://qiita.com/delphinus/items/00ff2c0ba972c6e41542
" ref. http://qiita.com/Ress/items/7e71e007cf8d41a07a1a#settings-1

"TODO: vim8 用に XDG Base Directory Specification 処置として (一応．後で外すかと．)
let s:config_home = empty($XDG_CONFIG_HOME) ? expand('$HOME/.config') : $XDG_CONFIG_HOME

" プラグインが実際にインストールされるディレクトリ
let s:cache_home = empty($XDG_CACHE_HOME) ? expand('$HOME/.cache') : $XDG_CACHE_HOME
let s:dein_dir = s:cache_home . '/dein'

" dein.vim 本体
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" dein.vim がなければ github から落としてくる
if !isdirectory(s:dein_repo_dir)
  call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_repo_dir))
  "execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
endif
let &runtimepath = s:dein_repo_dir .",". &runtimepath

" プラグイン読み込み＆キャッシュ作成
if has('nvim')
  let s:toml_file = fnamemodify(expand('<sfile>'), ':h').'/dein.toml'
else
  let s:toml_file = expand('$HOME/dein.toml')
  "TODO: 本来なら XDG 対応をきちんと行っておくべきだと思っている．．．
endif
echom "s:toml_file=" . s:toml_file
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir, [$MYVIMRC, s:toml_file])
  call dein#load_toml(s:toml_file)
  call dein#end()
  call dein#save_state()
endif

" もし，未インストールものものがあったらインストール
if has('vim_starting') && dein#check_install()
  call dein#install()
endif



"--------------------------------------------------------------------------- >common

filetype plugin indent on
syntax on

if has('nvim')
  let g:python3_host_prog = expand('/usr/local/bin/python3')
else
  set pythonthreedll=/usr/local/Cellar/python3/3.6.0/Frameworks/Python.framework/Versions/3.6/Python
  " ref. https://github.com/splhack/macvim-kaoriya/wiki/Readme#perl--python--python3--ruby--lua
endif


" バックアップファイル - off
set nobackup
" スワップファイル - off
set noswapfile
" ビープ
set vb t_vb=
" 保存していない状態でも他のファイルを開く
set hidden
" 検索置換
set smartcase
" クリップボード.os の クリップボードを
set clipboard+=unnamed
" クリップボード.vim の ヤンクを
set clipboard=unnamed



"--------------------------------------------------------------------------- >seach
" 検索の挙動に関する設定:
"
" 検索時に大文字小文字を無視 (noignorecase:無視しない)
set ignorecase
" 大文字小文字の両方が含まれている場合は大文字小文字を区別
set smartcase
" 検索時にファイルの最後まで行ったら最初に戻る (nowrapscan:戻らない)
set wrapscan

" 検索ハイライト on
set hlsearch



"--------------------------------------------------------------------------- >edit
" 編集に関する設定:
"
" タブの画面上での幅
set tabstop=2
" タブをスペースに展開しない (expandtab:展開する)
set noexpandtab
" 自動的にインデントする (noautoindent:インデントしない)
set autoindent
" バックスペースでインデントや改行を削除できるようにする
set backspace=indent,eol,start
" 括弧入力時に対応する括弧を表示 (noshowmatch:表示しない)
set showmatch
"" コマンドライン補完するときに強化されたものを使う(参照 :help wildmenu)
"set wildmenu

" 折り返し移動 - <backspace> <enter> h, l,<-, ->
set whichwrap=b,s,h,l,<,>,[,]
"" バックスペース
"set backspace=indent,eol,start

" 保存時の空白削除
augroup bufferWritePrevious
  autocmd!
  autocmd BufWritePre * if &filetype != 'markdown' | :%s/\s\+$//ge | endif
augroup END

" 直前の編集位置を記録 (最後に開かれていた時の行へ自動的にジャンプする)
augroup LastPositionJump
  autocmd!
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END
"ref. :h last-position-jump
"ref. http://blog.papix.net/entry/2012/12/14/042937

"バイナリ編集(xxd)モード（vim -b での起動，もしくは *.bin ファイルを開くと発動します）
augroup BinaryXXD
  autocmd!
  autocmd BufReadPre *.bin let &binary =1
  autocmd BufReadPost * if &binary | silent %!xxd -g 1
  autocmd BufReadPost * set ft=xxd | endif
  autocmd BufWritePre * if &binary | %!xxd -r | endif
  autocmd BufWritePost * if &binary | silent %!xxd -g 1
  autocmd BufWritePost * set nomod | endif
augroup END

" インサートモード時，カーソルの形状を `|`
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1


"--------------------------------------------------------------------------- >complete
" コマンドライン補完するときに強化されたものを使う(参照 :help wildmenu)
set wildmenu

set wildchar=<tab>
set wildmode=list:full
set history=1000
set complete+=k



"--------------------------------------------------------------------------- >appearance
" GUI固有ではない画面表示の設定:
"
" 行番号を表示
set number
" ルーラーを表示 (noruler:非表示)
set ruler
" 不可視文字
set list
set listchars=eol:¬,tab:▸-,trail:_
" 常にステータス行を表示 (詳細は:he laststatus)
set laststatus=2
" コマンドラインの高さ (Windows用gvim使用時はgvimrcを編集すること)
set cmdheight=2
" コマンドをステータス行に表示
set showcmd
" タイトルを表示
set title
" カーソル行
set cursorline
" カーソル行. カレントウィンドウのみ
augroup cch
  autocmd! cch
  autocmd WinLeave * set nocursorline
  autocmd WinEnter,BufRead * set cursorline
augroup END



"--------------------------------------------------------------------------- >key >map >keymap
" ヘルプ
nnoremap <C-i> :<C-u>help<Space>
nnoremap <C-i><C-i> :<C-u>help<Space><C-r><C-w><Enter>
augroup help
  autocmd!
  autocmd FileType help,git-status,git-log nnoremap <buffer> q <C-w>c
augroup END
" ref. http://d.hatena.ne.jp/mickey24/20090429/1240992099
" カーソル移動
nnoremap h <left>
nnoremap j gj
nnoremap k gk
nnoremap l <right>
nnoremap <Down> gj
nnoremap <Up> gk
" カーソル移動.インサートモード
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-h> <Left>
inoremap <C-l> <Right>
" カーソル移動.括弧
"if has('xim')
"  inoremap {} {}<Left>
"  inoremap [] []<Left>
"  inoremap () ()<Left>
"  inoremap <> <><Left>
"  inoremap "" ""<Left>
"  inoremap '' ''<Left>
"  inoremap `` ``<Left>
"endif
" ペースト.インサートモード
imap <C-p> <ESC>"*pa
" バッファ.移動
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
" バッファ.分割方向
nnoremap <C-w>h <C-w>K    " horizontal
nnoremap <C-w>v <C-w>H    " vertical
" 行頭，行末移動
noremap =0 $
" カーソルの位置から行頭，行末まで選択
vnoremap v $h
" 対応する括弧移動
noremap [ %
noremap ] %
" タイムスタンプ
inoremap ,dd <C-r>=strftime('%Y.%m.%d')<Return>
inoremap ,ddd <C-r>=strftime('%Y%m%d')<Return>
"ウィンドウサイズ
map + <C-w>+
map - <C-w>-
" バッファ内すべてのコンテンツをクリップボードへ
noremap ya :%y<CR>
" 折りたたみ
nnoremap zoo zR
nnoremap zcc zM
nnoremap <space> zA
" ref. http://dougblack.io/words/a-good-vimrc.html#fold
vnoremap <c-a> <c-a>gv
vnoremap <c-x> <c-x>gv

" delete use the black hole register
noremap s "_s
noremap S "_S
noremap c "_c
noremap C "_C
noremap d "_d
noremap D "_D
" http://qiita.com/itmammoth/items/312246b4b7688875d023#10x%E3%82%84s%E3%81%A7%E3%81%AF%E3%83%A4%E3%83%B3%E3%82%AF%E3%81%97%E3%81%AA%E3%81%84
nnoremap dd Vx

xnoremap <expr> p 'pgv"'.v:register.'ygv<esc>'
" http://stackoverflow.com/questions/290465/vim-how-to-paste-over-without-overwriting-register/5093286#5093286


"--------------------------------------------------------------------------- >plugins

"
" >ctrlP
"
" デフォルト起動時にカレントディレクトリベースに検索をするように
let g:ctrlp_cmd = 'CtrlPCurWD'
" ファイル名で検索をデフォルトに(<C-D>で切り替えできる）
let g:ctrlp_by_filename = 1
" CtrlPコマンドの引数省略時の挙動
let g:ctrlp_working_path_mode = 'ra'
" 対象ファイル最大数(default:10000)
let g:ctrlp_max_files  = 100000
" vim終了時にキャッシュクリアする(default:1)
let g:ctrlp_clear_cache_on_exit = 0
" dotfileなども対象にする
let g:ctrlp_show_hidden = 1
" CtrlPFunky
nnoremap <Leader>fu :CtrlPFunky<Cr>
" narrow the list down with a word under cursor
nnoremap <Leader>fU :execute 'CtrlPFunky ' . expand('<cword>')<Cr>
" CtrlPFiler
nnoremap <Leader>cd :CtrlPFiler<Cr>



"
" >calendar.vim
"
map <Leader>cal ;Calendar -view=year -split=vertical -width=24<CR>
map <Leader>yr ;Calendar -view=year<CR>



"
" >vim-less-autocompile
"
autocmd BufRead,BufNewFile *.less set filetype=less
"自動で変換
let g:less_autocompile=1
"圧縮しない
let g:less_compress=0


"
" >vim-less
"
autocmd BufNewFile,BufRead *.less set filetype=css


""
"" >previm
""
"map <Leader>pv ;PrevimOpen<cr>



"
" >quickrun
"
" for python/vimproc
let g:quickrun_config = {}
let g:quickrun_config['*'] = {'runner': 'vimproc'}
" let g:quickrun_config['*'] = {'runmode': "async:remote:vimproc", 'split': 'below'}

let g:quickrun_config['markdown'] = {
      \ 'type': 'markdown/pandoc',
      \ 'cmdopt': '-s'
      \ }
" swift
autocmd BufRead,BufNewFile *.swift set filetype=swift
let g:quickrun_config['swift'] = {
      \ 'command': 'xcrun',
      \ 'cmdopt': 'swift',
      \ 'exec': '%c %o %s',
      \}


"
" >unite-outline
"
let g:unite_winwidth = 40
nnoremap <silent> <Leader>o :<C-u>Unite -vertical -no-quit outline<CR>



"
" >vimshell
"
let g:vimshell_prompt = "% "
let g:vimshell_secondary_prompt="> "

if has('win32') || has('win64')
  " Display user name on Windows.
  let g:vimshell_user_prompt = "$USERNAME.' in '.fnamemodify(getcwd(), ':~')"
else
  " Display user name on Linux.
  let g:vimshell_user_prompt = "$USER.' in '.fnamemodify(getcwd(), ':~')"
endif

let g:vimshell_split_command="split"
nmap <Leader>vs <Plug>(vimshell_split_switch)
command! Vs :VimShell -split-command=split
" ref. https://github.com/namutaka/dotfiles/blob/76e75c7f00a07788012b2985aeec7c2b649bdd39/vimrc



"
" >vim-textobj-jabraces
"
let g:textobj_multitextobj_textobjects_i = [
    \ "\<Plug>(textobj-multiblock-i)",
    \ "\<Plug>(textobj-jabraces-parens-i)",
    \ "\<Plug>(textobj-jabraces-braces-i)",
    \ "\<Plug>(textobj-jabraces-brackets-i)",
    \ "\<Plug>(textobj-jabraces-angles-i)",
    \ "\<Plug>(textobj-jabraces-double-angles-i)",
    \ "\<Plug>(textobj-jabraces-kakko-i)",
    \ "\<Plug>(textobj-jabraces-double-kakko-i)",
    \ "\<Plug>(textobj-jabraces-yama-kakko-i)",
    \ "\<Plug>(textobj-jabraces-double-yama-kakko-i)",
    \ "\<Plug>(textobj-jabraces-kikkou-kakko-i)",
    \ "\<Plug>(textobj-jabraces-sumi-kakko-i)",
\]
let g:textobj_multitextobj_textobjects_a = [
    \ "\<Plug>(textobj-multiblock-a)",
    \ "\<Plug>(textobj-jabraces-parens-a)",
    \ "\<Plug>(textobj-jabraces-braces-a)",
    \ "\<Plug>(textobj-jabraces-brackets-a)",
    \ "\<Plug>(textobj-jabraces-angles-a)",
    \ "\<Plug>(textobj-jabraces-double-angles-a)",
    \ "\<Plug>(textobj-jabraces-kakko-a)",
    \ "\<Plug>(textobj-jabraces-double-kakko-a)",
    \ "\<Plug>(textobj-jabraces-yama-kakko-a)",
    \ "\<Plug>(textobj-jabraces-double-yama-kakko-a)",
    \ "\<Plug>(textobj-jabraces-kikkou-kakko-a)",
    \ "\<Plug>(textobj-jabraces-sumi-kakko-a)",
\]
omap ab <Plug>(textobj-multitextobj-a)
omap ib <Plug>(textobj-multitextobj-i)
vmap ab <Plug>(textobj-multitextobj-a)
vmap ib <Plug>(textobj-multitextobj-i)
" ref. http://kainokikaede.hatenablog.com/entry/2014/11/09/124636



"
" >vim-markdown-quote-syntax
"
" ref. http://qiita.com/joker1007/items/19632542492f6d6395d6




"--------------------------------------------------------------------------- .myscripts

"
" ><line>,<line>Form
"
" => 日本語コンテンツ内で使う半角英数字の前後に半角スペースを入れたいと思って．

function! s:FormSpace() range
    let l:current=line('.')
    " シングルバイト英字，前後にスペース
    exe 'silent ' . a:firstline . ',' . a:lastline . 's/[^\x01-\x7E，．「]\zs\(\w\)/ \1/ge'
    exe 'silent ' . a:firstline . ',' . a:lastline . 's/\(\w\)\ze[^\x01-\x7E，．」]/\1 /ge'
    " シングルバイト括弧/数値 前後にスペース
    " 括弧の前 forward
    exe 'silent ' . a:firstline . ',' . a:lastline . 's/[^\x01-\x7E ，．「]\zs\(`[^` ]\{-}`\|''[^'' ]\{-}''\|"[^" ]\{-}"\|<.\{-}>\|(.\{-})\|\[.\{-}\]\|{.\{-}}\)/ \1/ge'
    " 括弧の後 behind
    exe 'silent ' . a:firstline . ',' . a:lastline . 's/\(`[^` ]\{-}`\|''[^'' ]\{-}''\|"[^" ]\{-}"\|<.\{-}>\|(.\{-})\|\[.\{-}\]\|{.\{-}}\)\ze[^\x01-\x7E ，．」]/\1 /ge'
    exe l:current
endfunction
command! -nargs=0 -range Form <line1>, <line2> call s:FormSpace()
" :h command-range



"
" ><line>,<line>Rcp
"
" => レシピメモ用に :p
function! s:RecipeIngredients() range
      execute 'silent ' . a:firstline . ',' . a:lastline . 's/\((.\{-})\)*\(適\|大\|大匙\|大さじ\|中[^華国]\|小匙\|小さじ\|少\|少\|少\|小\|お好み\|各\|数\|あれば\|一\|半\|\d\|ひと\)/\1\.\.\2/e'
    execute a:firstline . ',' . a:lastline . 'Form'

    execute a:firstline . ',' . a:lastline . 'EasyAlign .'
    execute 'silent ' . a:firstline . ',' . a:lastline . 's/^/* /e'
endfunction
command! -nargs=0 -range Rcp <line1>, <line2> call s:RecipeIngredients()

function! s:RecipeProcess() range
    execute 'silent ' . a:firstline . ',' . a:lastline . 'g/\(^.*の作り方\d\+\|^.*の下準備\d\+\|^写真.*$\)/d'
    execute 'silent ' . a:firstline . ',' . a:lastline . 's/^\(STEP\)*\(\d\+\)\(:\|\n\)/\2. /ge'
endfunction
command! -nargs=0 -range Rcpp <line1>, <line2> call s:RecipeProcess()



"
" :<line>,<line>Single
"
" 全角の英数字を半角にする．(自分の win 環境では hz_ja.vim が上手く動いてくれないみたいなので orz)
function! s:ChangeToSingleByte() range
    " テーブル生成
    let l:dic = {}
    call extend(l:dic, {'０':'0','１':'1','２':'2','３':'3','４':'4','５':'5','６':'6','７':'7','８':'8','９':'9'})
    call extend(l:dic, {'①':'1','②':'2','③':'3','④':'4','⑤':'5','⑥':'6','⑦':'7','⑧':'8','⑨':'9'})
    call extend(l:dic, {'Ａ':'A','Ｂ':'B','Ｃ':'C','Ｄ':'D','Ｅ':'E','Ｆ':'F','Ｇ':'G','Ｈ':'H','Ｉ':'I','Ｊ':'J','Ｋ':'K','Ｌ':'L','Ｍ':'M','Ｎ':'N','Ｏ':'O','Ｐ':'P','Ｑ':'Q','Ｒ':'R','Ｓ':'S','Ｔ':'T','Ｕ':'U','Ｖ':'V','Ｗ':'W','Ｘ':'X', 'Ｙ':'Y','Ｚ':'Z'})
    call extend(l:dic, {'ａ':'a','ｂ':'b','ｃ':'c','ｄ':'d','ｅ':'e','ｆ':'f','ｇ':'g','ｈ':'h','ｉ':'i','ｊ':'j','ｋ':'k','ｌ':'l','ｍ':'m','ｎ':'n','ｏ':'o','ｐ':'p','ｑ':'q','ｒ':'r','ｓ':'s','ｔ':'t','ｕ':'u','ｖ':'v','ｗ':'w','ｘ':'x','ｙ':'y','ｚ':'z'})
    call extend(l:dic, {'（':'(', '）':')', '［':'[', '］':']', '｛':'{', '｝':'}', '＜':'<', '＞':'>', '”':'"', "’":"'", "‘":"'", '“':'"'})
    call extend(l:dic, {'￥':'\\','＆':'\&','／':'\/','：':':', '；':';', '＊':'*', '％':'%', '？':'?', '　':' ', '！':'!', '～':'-', '〜':'-', '―':'-', '＝':'='})    " 句点の "．" は対象外

    " 置換処理
    for l:key in keys(l:dic)
        exe 'silent! ' . a:firstline . ',' . a:lastline . 's/' . l:key . '/' .l:dic[l:key] . '/ge'
    endfor
    " 置換処理. 数値の小数点(それ以外は，句点とする)
    exe 'silent! ' . a:firstline . ',' . a:lastline . 's/\d\zs．\ze\d/./ge'
endfunction
command! -nargs=0 -range Single <line1>, <line2> call s:ChangeToSingleByte()



"
" :<line>,<line>Num {startNum}[format]
"
" 連番を先頭に挿し込む．
" 引数は1つのみ，必須．開始値を指定する．(無い場合は1から)

function! s:InsertNumbering(cnt) range
    " echo "'" . a:cnt . "'"
    let l:cntr = split(substitute(a:cnt, '\(^.\{-}\)\(\d\+\)\(.\{-}$\)', '\1,\2,\3', ''),',',1)

    let l:cnt = str2nr(l:cntr[1])

    let l:digits = (strlen(l:cntr[1]) < strlen(l:cnt + (a:lastline - a:firstline))) ? strlen(l:cnt + (a:lastline - a:firstline)) : strlen(l:cntr[1])

    let l:item = (a:cnt[0] != 0) ? "%" : "%0"

    for l:rec in range (a:firstline, a:lastline)
        let l:out = printf(l:item.l:digits.'d', l:cnt)
        call setline(l:rec, l:cntr[0] . l:out . l:cntr[2] . getline(l:rec))
        let l:cnt += 1
    endfor
endfunction
command! -nargs=+ -range Num <line1>, <line2> call <SID>InsertNumbering(<f-args>)
" ref. http://kikaibunsho.web.fc2.com/monologo/memoro/08_11.html
" ref. http://vimdoc.sourceforge.net/htmldoc/eval.html#printf%28%29



"
" ．/，セットを．/，にする
"
function! s:Punctuation( mode_is ) range
  let l:pos = getpos(".")

  if a:mode_is == "n"
    let l:firstline_is = 1
    let l:lastline_is = line("$")
  else
    let l:firstline_is = a:firstline
    let l:lastline_is = a:lastline
  endif

  call <SID>Punctuation_process(l:firstline_is, l:lastline_is)

  call setpos('.', l:pos)
endfunction

function! s:Punctuation_process(firstline_is, lastline_is)
  for l:line in range(a:firstline_is, a:lastline_is)
    " quote line?
    if match(getline(l:line), '^\s*>') >= 0
      " nothin'
    else
      call setline(l:line, substitute(getline(l:line), "。", "．", "ge"))
      call setline(l:line, substitute(getline(l:line), '、', '，', 'ge'))
    endif
  endfor
endfunction
command! -nargs=1 -range Pct <line1>, <line2> call <SID>Punctuation(<f-args>)
" :h command-range
nnoremap <leader>. :<C-u>Pct n<cr>
vnoremap <leader>. :Pct v<cr>


" 強調
augroup HilightsForce
  autocmd!
  autocmd WinEnter,BufRead,BufNew,Syntax * :silent! call matchadd('Todo', '\(TODO\|NOTE\|INFO\|XXX\|TEMP\):')
  autocmd WinEnter,BufRead,BufNew,Syntax * highlight Todo guibg=Red guifg=White
" TEMP: 行番号はどの colorscheme 使っても一律目立たせる
  autocmd WinEnter,BufRead,BufNew,Syntax * highlight CursorLineNr cterm=NONE ctermfg=15 gui=NONE guifg=#f5f5f5
  autocmd WinEnter,BufRead,BufNew,Syntax * highlight LineNr ctermfg=7 guifg=#949494
augroup END

"--------------------------------------------------------------------------- .misc

noremap ; :
noremap : ;

" set termguicolors


" vim:set foldmethod=marker:
