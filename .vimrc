set nocompatible
filetype off

"-------------------------------------------------- .neobundlw
if has('vim_starting')
    set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#rc(expand('~/.vim/bundle/'))

    NeoBundle 'Shougo/vimproc', {
    \ 'build' : {
    \     'windows' : 'echo "Sorry, cannot update vimproc binary file in Windows."',
    \     'cygwin' : 'make -f make_cygwin.mak',
    \     'mac' : 'make -f make_mac.mak',
    \     'unix' : 'make -f make_unix.mak',
    \   },
    \ }
    NeoBundle 'Shougo/unite.vim'
    NeoBundle 'Shougo/neomru.vim'

    NeoBundle 'Shougo/neocomplete.vim'
    NeoBundle 'Shougo/neosnippet.vim'
    NeoBundle 'Shougo/neosnippet-snippets'

    NeoBundle 'Shougo/vimshell'
    NeoBundle 'Shougo/vimfiler.vim'
    NeoBundle 'renamer.vim'

    NeoBundle 'The-NERD-Commenter'
    NeoBundle 'surround.vim'
    NeoBundle 'Align'
    NeoBundle 'rhysd/clever-f.vim'
    " NeoBundle 'YankRing.vim'    " comment {2012.09.05} マクロ実行の '@' が効かなくなるので．

    NeoBundle 'altercation/vim-colors-solarized'
    NeoBundle 'molokai'
    NeoBundle 'Lokaltog/vim-powerline'

    NeoBundle 'thinca/vim-quickrun'

    " NeoBundle 'glidenote/memolist.vim'
    NeoBundle 'woowee/memolist.vim'

    NeoBundle 'mattn/webapi-vim'
    NeoBundle 'ujihisa/blogger.vim'
    NeoBundle 'kannokanno/previm'
    NeoBundle 'tyru/open-browser.vim'

filetype plugin indent on     " Required!

" Installation check.
if neobundle#exists_not_installed_bundles()
    echomsg 'Not installed bundles : ' .
     \ string(neobundle#get_not_installed_bundle_names())
    echomsg 'Please execute ":NeoBundleInstall" command.'
"finish
endif

"-------------------------------------------------- .common
" $PATH
let $PATH="/usr/local/bin:/Users/koo/.cabal/bin:".$PATH
" バックアップファイル - off
set nobackup
" スワップファイル - off
set noswapfile
" ファイルタイプ識別 - on
filetype plugin on
" ビープ
set vb t_vb=
" 保存していない状態でも他のファイルを開く
set hidden
" 検索置換
set smartcase
" クリップボード.os の クリップボードを
set clipboard+=unnamed
" クリップボード.vim の ヤンクを
set clipboard=unnamed


"-------------------------------------------------- .appearance
" 行番号
set number
" 不可視文字 - 表示
set list
set listchars=tab:>-,trail:_
" カーソル行
set cursorline
" カーソル行. カレントウィンドウのみ
augroup cch
  autocmd! cch
  autocmd WinLeave * set nocursorline
  autocmd WinEnter,BufRead * set cursorline
augroup END
" 全角スペースの可視化 >> ricty 導入にともない


"-------------------------------------------------- .edit
" インサートモード時imeオフ
set noimdisable
set iminsert=0 imsearch=0
set noimcmdline
" inoremap <silent> <ESC> <ESC>:set iminsert=0<CR>
" 折り返し移動 - <backspace> <enter> h, l,<-, ->
set whichwrap=b,s,h,l,<,>,[,]
" バックスペース
set backspace=indent,eol,start

" タブ
" タブ. 画面上表示するタブ幅
set tabstop=4
" タブ. <tab>押下によるタブ幅(tabstopと同じにした）
set softtabstop=4
" タブ.
set shiftwidth=4

" 保存時の空白削除
" autocmd BufWritePre * :%s/\s\+$//ge
autocmd BufWritePre * if &ft != 'markdown' | :%s/\s\+$//ge  | endif
autocmd BufWritePre * :%s/\t/    /ge
autocmd BufWritePre * :%s/　\+$//ge

" 折り返し
set textwidth=0
set formatoptions=q

autocmd FileType text setlocal wrap


"-------------------------------------------------- .complete
set wildmenu
set wildchar=<tab>
set wildmode=list:full
set history=1000
set complete+=k


"-------------------------------------------------- .key mapping
" 検索ハイライト off
set hlsearch
" nmap <ESC><ESC> :nohlsearch<CR><ESC>
nmap <ESC><ESC> ;noh<CR><ESC>
" ヘルプ
nnoremap <C-i> :<C-u>help<Space>
nnoremap <C-i><C-i> :<C-u>help<Space><C-r><C-w><Enter>
" カーソル移動
nnoremap h <left>
nnoremap j gj
nnoremap k gk
nnoremap l <right>
nnoremap <Down> gj
nnoremap <Up> gk
" ウィンドウ移動
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
" 行頭、行末移動
noremap =0 $
" カーソルの位置から行頭、行末まで選択
vnoremap v $h
" 対応する括弧移動
noremap [ %
noremap ] %
" カーソル位置の単語yank
nnoremap vy vawy
"  about text object mapping ★

" タイムスタンプ
inoremap ,dd <C-r>=strftime('%Y.%m.%d')<Return>
"ウィンドウサイズ
map + <C-w>+
map - <C-w>-

" 。/、セットを．/，にする
nnoremap <leader>. :%s/。/．/g<CR>:%s/、/，/g<CR>

"copy all
noremap ya :%y<CR>


"-------------------------------------------------- .encording
set ffs=unix,dos,mac  " 改行文字
set encoding=utf-8    " デフォルトエンコーディング

" 文字コード関連
" from ずんWiki http://www.kawaz.jp/pukiwiki/?vim#content_1_7
" 文字コードの自動認識
if &encoding !=# 'utf-8'
  set encoding=japan
  set fileencoding=japan
endif
if has('iconv')
  let s:enc_euc = 'euc-jp'
  let s:enc_jis = 'iso-2022-jp'
  " iconvがeucJP-msに対応しているかをチェック
  if iconv("\x87\x64\x87\x6a", 'cp932', 'eucjp-ms') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'eucjp-ms'
    let s:enc_jis = 'iso-2022-jp-3'
  " iconvがJISX0213に対応しているかをチェック
  elseif iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'euc-jisx0213'
    let s:enc_jis = 'iso-2022-jp-3'
  endif
  " fileencodingsを構築
  if &encoding ==# 'utf-8'
    let s:fileencodings_default = &fileencodings
    let &fileencodings = s:enc_jis .','. s:enc_euc .',cp932'
    let &fileencodings = &fileencodings .','. s:fileencodings_default
    unlet s:fileencodings_default
  else
    let &fileencodings = &fileencodings .','. s:enc_jis
    set fileencodings+=utf-8,ucs-2le,ucs-2
    if &encoding =~# '^\(euc-jp\|euc-jisx0213\|eucjp-ms\)$'
      set fileencodings+=cp932
      set fileencodings-=euc-jp
      set fileencodings-=euc-jisx0213
      set fileencodings-=eucjp-ms
      let &encoding = s:enc_euc
      let &fileencoding = s:enc_euc
    else
      let &fileencodings = &fileencodings .','. s:enc_euc
    endif
  endif
  " 定数を処分
  unlet s:enc_euc
  unlet s:enc_jis
endif
" 日本語を含まない場合は fileencoding に encoding を使うようにする
if has('autocmd')
  function! AU_ReCheck_FENC()
    if &fileencoding =~# 'iso-2022-jp' && search("[^\x01-\x7e]", 'n') == 0
      let &fileencoding=&encoding
    endif
  endfunction
  autocmd BufReadPost * call AU_ReCheck_FENC()
endif
" 改行コードの自動認識
set fileformats=unix,dos,mac
" □とか○の文字があってもカーソル位置がずれないようにする
if exists('&ambiwidth')
  set ambiwidth=double
endif

" cvsの時は文字コードをeuc-jpに設定
autocmd FileType cvs :set fileencoding=euc-jp
" 以下のファイルの時は文字コードをutf-8に設定
autocmd FileType svn :set fileencoding=utf-8
autocmd FileType js :set fileencoding=utf-8
autocmd FileType css :set fileencoding=utf-8
autocmd FileType html :set fileencoding=utf-8
autocmd FileType xml :set fileencoding=utf-8
autocmd FileType java :set fileencoding=utf-8
autocmd FileType scala :set fileencoding=utf-8

" ワイルドカードで表示するときに優先度を低くする拡張子
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.to

" 指定文字コードで強制的にファイルを開く
command! Cp932 edit ++enc=cp932
command! Eucjp edit ++enc=euc-jp
command! Iso2022jp edit ++enc=iso-2022-jp
command! Utf8 edit ++enc=utf-8
command! Jis Iso2022jp
command! Sjis Cp932

" my commands . blogger.vim
command! -nargs=0 List :e blogger:list
command! -nargs=0 Post :w blogger:create

"-------------------------------------------------- .plugins
" ********** (source)
if filereadable(expand('~/.pwd.blogger'))
    source ~/.pwd.blogger
endif
" ref. http://vim-users.jp/2009/12/hack108/

" ********** quickrun
" for python/vimproc
let g:quickrun_config = {}
let g:quickrun_config['*'] = {'runner': 'vimproc'}
" let g:quickrun_config['*'] = {'runmode': "async:remote:vimproc", 'split': 'below'}

let g:quickrun_config['markdown'] = {
      \ 'type': 'markdown/pandoc',
      \ 'cmdopt': '-s'
      \ }

" ********* memolist
map <Leader>mn ;MemoNew<cr>
" map <Leader>ml ;MemoList<CR>
map <Leader>ml ;Unite file:<C-r>=g:memolist_path<CR><CR>
map <Leader>mg ;MemoGrep<CR>

let g:memolist_path = '~/Dropbox/memo'

let g:memolist_prompt_tags = 0
let g:memolist_prompt_categories = 1
let g:memolist_qfixgrep = 1
let g:memolist_vimfiler = 0

let g:memolist_filename_prefix_none = 1
" ********** vimplenote
if filereadable(expand('~/.vimrc.local'))
  source ~/.vimplenoterc
endif


" ********** the nerd commenter
let NERDSpaceDelims=1
let NREDShutUp=1
map <leader>x <leader>c<space>


" ********** neocompletechash
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplete#close_popup() . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplete#close_popup()
inoremap <expr><C-e>  neocomplete#cancel_popup()
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? neocomplete#close_popup() : "\<Space>"

" For cursor moving in insert mode(Not recommended)
"inoremap <expr><Left>  neocomplete#close_popup() . "\<Left>"
"inoremap <expr><Right> neocomplete#close_popup() . "\<Right>"
"inoremap <expr><Up>    neocomplete#close_popup() . "\<Up>"
"inoremap <expr><Down>  neocomplete#close_popup() . "\<Down>"
" Or set this.
"let g:neocomplete#enable_cursor_hold_i = 1
" Or set this.
"let g:neocomplete#enable_insert_char_pre = 1

" AutoComplPop like behavior.
"let g:neocomplete#enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplete#enable_auto_select = 1
"let g:neocomplete#disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
" ********** neosnippet
" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: "\<TAB>"

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif


" ********** align.vim
" 日本語など幅広文字に対応するためのおまじない。(ref. http://vim-users.jp/2009/09/hack77/)
let g:Align_xstrlen=3


" ********** unite
" The prefix key.
nnoremap    [unite]   <Nop>
nmap    <Leader>f [unite]

" unite.vim keymap
" https://github.com/alwei/dotfiles/blob/3760650625663f3b08f24bc75762ec843ca7e112/.vimrc
nnoremap <silent> [unite]f :<C-u>UniteWithBufferDir file -buffer-name=files<CR>
nnoremap <silent> [unite]b :<C-u>Unite<Space>buffer<CR>
nnoremap <silent> [unite]k :<C-u>Unite<Space>bookmark<CR>
nnoremap <silent> [unite]m :<C-u>Unite<Space>file_mru<CR>
nnoremap <silent> ,vr :UniteResume<CR>

autocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings()
    nmap <buffer> <esc><esc>    <Plug>(unite_exit)
    imap <buffer> jj    <Plug>(unite_insert_leave)
endfunction

nnoremap <C-p> :Unite file_rec/async<CR>
nnoremap <Space>/ :Unite grep:.<CR>
nnoremap <Space>y :Unite history/yanks<CR>

" ウィンドウを分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-J> unite#do_action('split')
au FileType unite inoremap <silent> <buffer> <expr> <C-J> unite#do_action('split')
" ウィンドウを縦に分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-K> unite#do_action('vsplit')
au FileType unite inoremap <silent> <buffer> <expr> <C-K> unite#do_action('vsplit')

let g:unite_enable_start_insert = 1

" vinarise
" let g:vinarise_enable_auto_detect = 1

" ********** surround.vim
let g:surround_{char2nr('c')} = "``` \1language\1 \r ```"



"-------------------------------------------------- .myscript

" ********** anchor
function! s:MakeAnchor() range
    let l:cnt = 0
    for l:rec in range (a:firstline, a:lastline)
        let s:out = substitute(getline(l:rec), '\[\(.\{-}\)\](\(.\{-}\))', '<a href="\2">\1<\/a>', '')
        call setline(l:rec, s:out)
        let l:cnt += 1
    endfor
endfunction
command! -nargs=0 -range Anchor <line1>, <line2> call <SID>MakeAnchor()

" ********** google maps，my maps の description 用 html を生成
function! s:MakeGoogleMapsDescription() range
    let l:ref = 0    "flag

    let l:cnt = 0
    for l:rec in range (a:firstline, a:lastline)
        if l:ref == 1
            let s:out = s:MakeAnchor(getline(l:rec))
            call setline(l:rec, s:out )
        else
            let s:out = s:CharacterReference(getline(l:rec))

            if match(getline(l:rec), "* acc") >= 0
                let s:out = substitute(s:out, '[', '<strong>', 'g')
                let s:out = substitute(s:out, ']', '<\/strong>', 'g')
            endif

            call setline(l:rec, s:out)
        endif
        " ### ref ?
        if match(getline(l:rec), '### ref') >= 0
            let l:ref = 1
        endif
        " increment
        let l:cnt += 1
    endfor

    exe 'silent'.'''<,''>s/\n/<br>/g'

    call setline(a:firstline, '<div dir="ltr">'.getline(a:firstline).'</div>')
endfunction
function! s:CharacterReference(str)
    let l:str = a:str

    let l:str = substitute(l:str, '&', '\&amp;', "g")
    let l:str = substitute(l:str, '<', '\&lt;', "g")
    let l:str = substitute(l:str, '>', '\&gt;', "g")
    return l:str
endfunction
function! s:MakeAnchor(str)
    let l:tmp = matchstr(a:str, '^\d.\{-}\ze[')

    let l:title = matchstr(a:str, '\[\zs.\{-}\ze\]')
    let l:title = s:CharacterReference(l:title)

    let l:url = matchstr(a:str, '\](\zs.\{-}\ze)')

    if l:tmp == '' && l:url == '' && l:title == ''
        let s:out = a:str
    else
        let s:out = l:tmp . '[<a href="' . l:url . '" target="_blank">' . l:title . '</a>]'
    endif

    return s:out
endfunction
command! -nargs=0 -range Maps <line1>, <line2> call <SID>MakeGoogleMapsDescription()


" ********** googlemaps, mymaps の kml を生成
function! s:MakeGooglemapsKML()
    let l:mymapinfo = 1       " flag
    let l:mymapName = ''
    let l:mymapDescription = []

    let l:line = 1

    "===== MYMAP INFORMATION
    while l:mymapinfo == 1
        let l:lineStr = getline(l:line)

        " <name>
        if match(l:lineStr, 'name;') >= 0
            let l:mymapName = substitute(l:lineStr, 'name;\s\(.*\)', '\1', 'g')
        elseif match(getline(l:line), '\(-\)\{5,}') >= 0
        " <description>
        elseif match(l:lineStr, 'description;') >= 0
        elseif match(getline(l:line), '\(-\s\)\{3,}') >= 0
            let l:mymapinfo = 0
        else
            call add(l:mymapDescription, l:lineStr)
        endif

        if match(getline(l:line), 'pin;') >= 0
            let l:pin = getline(l:line + 1)
        endif

        let l:line += 1
    endwhile

    " delete the information rows
    while getline(l:line) == ""
        let l:line += 1
    endwhile
    exe 'silent 1,'.(l:line - 1).' del'

    "===== EACH PLACES
    let l:description = 0     " flag
    let l:description_ref = 0 " flag

    let l:line = 1
    let l:id = 1

    while l:line <= line('$')
        let l:lineStr = getline(l:line)

        if l:description >= 1
            if l:lineStr == ""
                call setline(l:line, '</div>]]></description>')
                let l:description = 0

                " <Point>
                call append(l:line, ["    <styleUrl>#style".l:id."</styleUrl>", "    <Point>","      <coordinates>".l:coordinates_longitude.','.l:coordinates_latitude.','.l:coordinates_altitude."</coordinates>","    </Point>","  </Placemark>"])
                let l:line += 4

                let l:description_ref = 0
            else
                if l:description_ref == 1
                    " ### ref
                    let l:tmp = s:MakeAnchor(getline(l:line))."<br>"
                    call setline(l:line, l:tmp)
                else
                    " <coordinates>
                    if match(getline(l:line), '* coordinates') >= 0
                        let l:tmp = substitute(getline(l:line), '* coordinates \(.*\)', '\1', 'g')
                        let l:coordinates_longitude = split(l:tmp, ',')[0]
                        let l:coordinates_latitude = split(l:tmp, ',')[1]
                        let l:coordinates_altitude = split(l:tmp, ',')[2]

                        exe 'silent '.l:line.' del'

                        let l:line -= 2
                    else
                    " normal line
                        let l:lineStr = substitute(l:lineStr, '<', '\&lt;', 'g')
                        let l:lineStr = substitute(l:lineStr, '>', '\&gt;', 'g')
                        if getline(l:line + 1) != ""
                            call setline(l:line, l:lineStr . "<br>")
                        endif
                    endif
                endif

                let l:description += 1
            endif
        endif

        if l:lineStr == '=='
            " point No
            let l:id += 1
            " coordinates
            let l:coordinates_longitude = ""
            let l:coordinates_latitude = ""
            let l:coordinates_altitude = ""

            " <Placemark>
            call append(l:line - 2, '  <Placemark>')

            let l:line += 1

            " <name>
            let l:tmp = getline(l:line - 1)
            call setline(l:line - 1, '    <name>' . l:tmp . '</name>')

            " <description>
            call setline(l:line, '    <description><![CDATA[<div dir="ltr"><font face="arial" size="2">')
            let l:description = 1
        elseif match(getline(l:line), '### ref') >= 0
            let l:description_ref = 1
        endif

        let l:line += 1
    endwhile

    call append(0, '<?xml version="1.0" encoding="UTF-8"?>')
    call append(1, '<kml xmlns="http://earth.google.com/kml/2.2">')
    call append(2, '<Document>')
    call append(3, '  <name>'. l:mymapName .'</name>')
    call append(4, '  <description><![CDATA['. l:mymapDescription[0])
    if len(l:mymapDescription) > 1
        call append(5, l:mymapDescription[1:])
    endif
    call append(5 + (len(l:mymapDescription) - 2), ']]></description>')

    let l:line = 5 + (len(l:mymapDescription) - 2)
    let l:cnt = 1

    let l:iconsUrl = '<href>http://maps.gstatic.com/mapfiles/ms2/micons/pink-dot.png</href>'
    while l:cnt <= l:id
        call append(l:line + 1,'  <Style id="style'.l:cnt.'">')
        call append(l:line + 2,'    <IconStyle>')
        call append(l:line + 3,'      <Icon>')
        call append(l:line + 4,'        <href>'.l:pin.'</href>')
        call append(l:line + 5,'      </Icon>')
        call append(l:line + 6,'    </IconStyle>')
        call append(l:line + 7,'  </Style>')
        let l:line += 7
        let l:cnt += 1
    endwhile

    call append(line('$'), '</Document>')
    call append(line('$'), '</kml>')

    exe 'silent %s/<br>\n/<br>/g'
    exe 'silent %s/<font face="arial" size="2">\n/<font face="arial" size="1">/g'
    exe 'silent %s/<\/Placemark>\n\n/<\/Placemark>/g'

endfunction
command! -nargs=0 Mapskml call <SID>MakeGooglemapsKML()


" ********** googlemaps, kml から mymaps 用メモを生成
function! s:MakeGooglemapsMemo()
    exe 'silent 1,2 del'
    exe 'silent %s/<Document>\n//g'
    exe 'silent %s/<\/Document>\n//g'
    for l:line in range(1, line('$'))
        " name
        if match(getline(l:line),'<name>') >= 0
            exe 'silent '.l:line.' s/^.\{-}<name>\(.\{-}\)<\/name>/name; \1----------description;/g'
            let line += 2
        endif

        if match(getline(l:line),'<description>') >= 0
            exe 'silent '.l:line.' s/^.\{-}<description><!\[CDATA\[//g'
        endif

        if match(getline(l:line),'<\/description>') >= 0
            call setline(l:line, '- - - - - - - - - -')
            call append(l:line, ['',''])
            call append(l:line - 1, '')
            let l:line +=3

            let l:beg = l:line + 1
        endif

        if match(getline(l:line),'<Placemark>') >= 0
            let l:end = l:line - 1
            break
        endif
    endfor
    exe 'silent '.l:beg.','.l:end.' del'

    call s:ExistenceCheckAndSubstitute('^.\{-}<Snippet>.\{-}\n', '')

    exe 'silent %s/<styleUrl>.\{-}<\/styleUrl>\n//g'
    exe 'silent %s/<Point>\n//g'
    exe 'silent %s/<\/Point>\n//g'
    exe 'silent %s/<Placemark>\n//g'
    exe 'silent %s/<\/Placemark>\n//g'

    exe 'silent %s/^.\{-}<name>\(.\{-}\)<\/name>/\1==/g'
    exe 'silent %s/^.\{-}<description><!\[CDATA\[//g'
    exe 'silent %s/\]\]><\/description>\n//g'

    " 不要なタグを削除
    call s:ExistenceCheckAndSubstitute('<span.\{-}>', '')
    call s:ExistenceCheckAndSubstitute('<\/span>', '')
    call s:ExistenceCheckAndSubstitute('<font.\{-}>', '')
    call s:ExistenceCheckAndSubstitute('<\/font>', '')

    call s:ExistenceCheckAndSubstitute('&lt;br&gt;', '')

    call s:ExistenceCheckAndSubstitute('<div.\{-}>', '')
    call s:ExistenceCheckAndSubstitute('<\/div>', '')

    call s:ExistenceCheckAndSubstitute('&amp;', '\&')
    call s:ExistenceCheckAndSubstitute('&nbsp;', ' ')
    call s:ExistenceCheckAndSubstitute('&lt;', '<')
    call s:ExistenceCheckAndSubstitute('&gt;', '>')
    call s:ExistenceCheckAndSubstitute('<br>', '')

    exe 'silent %s/<\/kml>//g'

    exe 'silent %s/\(^\d.\{-}\)\[<a href="\(.\{-}\)".\{-}>\(.\{-}\)<\/a>\]/\1\[\3\](\2)/g'

    let l:line = 1
    while l:line <= line('$')
        if match(getline(l:line),'* acc') >= 0
            let l:line_coordinates = l:line
        endif
        if match(getline(l:line),'<coordinates>') >= 0
            call append(l:line_coordinates, '* coordinates '.matchstr(getline(l:line),'<coordinates>\zs.\{-}\ze<\/coordinates>'))
            let l:line += 1

            " delete the line ; '<coordinates>000.000000,00.000000,0.000000</coordinates>'
            call setline(l:line,'')
        endif
        let l:line += 1
    endwhile

    "clean the format
    exe 'silent %s/^\s//g'
    let l:line = 1
    while l:line <= line('$')
        let l:lineStr = getline(l:line)

        if l:lineStr == '=='
            let l:lineTo = l:line
            while getline(l:lineTo) != ""
                if getline(l:lineTo) == ""
                    break
                endif
                let l:lineTo -= 1
            endwhile
            let l:lineFrom = l:lineTo
            while getline(l:lineFrom) == ""
                if getline(l:lineFrom) != ""
                    break
                endif
                let l:lineFrom -= 1
            endwhile

            exe 'silent '.(l:lineFrom + 1).','.l:lineTo.' del'

            call append(l:lineFrom, ['',''])

        endif

        let l:line += 1
    endwhile

endfunction
function! s:ExistenceCheckAndSubstitute(pat, sub)
    if search(a:pat) > 0
        exe 'silent %s/'.a:pat.'/'.a:sub.'/g'
    endif
endfunction
command! -nargs=0 Mapsmemo call <SID>MakeGooglemapsMemo()


" ********** googlemaps engine lite 用の csv を生成する
function! s:MakeMapToCSV()
    let l:flg = 1
    let l:line = 1
    while l:flg == 1
        if match(getline(l:line), '==') >= 0
            let l:flg = 0
            break
        endif
        let l:line += 1
    endwhile
    exe 'silent 1,'.(l:line - 2).' del'

    let l:line = 1
    while l:line <= line('$')
        if match(getline(l:line), '* coordinates ') >= 0
            let l:tmp = substitute(getline(l:line), '* coordinates ', '', 'g')
            let l:array = split(l:tmp, ',')
            call setline(l:line, '* coordinates "'.l:array[0].'","'.l:array[1].'"')
            " call setline(l:line, '* coordinates '.l:tmp)
        endif
        let l:line += 1
    endwhile

    " call append(0, '"flg","category","name","summary","station","address","open-close","access","coordinates","checkitems","misc","ref"')
    call append(0, '"flg","category","name","summary","station","address","open-close","access","longitude","latitude","checkitems","misc","ref"')

    "-- title >> "flag","category","name"
    exe 'silent'.'%s/^\(包\|豆漿\|食\|飯\|夜市\|粽\|餅\|餃\|飯\|麺\|湯\)\.\(.*$\)/"","\1","\2",/g'
    exe 'silent'.'%s/^★\(包\|豆漿\|食\|飯\|夜市\|粽\|餅\|餃\|飯\|麺\|湯\)\.\(.*$\)/"★","\1","\2",/g'
    exe 'silent'.'%s/^☆\(包\|豆漿\|食\|飯\|夜市\|粽\|餅\|餃\|飯\|麺\|湯\)\.\(.*$\)/"☆","\1","\2",/g'

    "-- data >> "eye-catch"
    exe 'silent'.'%s/^\(*.\{-}\*\)\n/"\1",/g'
    "-- data >> "sta","add","opn","acc"
    exe 'silent'.'%s/\(\* \(sta\|add\|opn\|acc\) \)\(.*\)\n/"\3",/g'
    " exe 'silent'.'%s/\(\* \(coordinates\) \)\(.*\)/"\3",/g'
    exe 'silent'.'%s/\(\* \(coordinates\) \)\(.*\)/\3,/g'
    "-- data >> "url <a></a>"
    exe 'silent'.'%s/\[\(.\{-}\)\](\(.\{-}\))\(.*\)/<a href=''\2'' target=''_blank''>\1<\/a>\3/g'

    exe 'silent'.'%s/\n^==\n//g'

    "-- note >> "" 囲みの開き " をセット，行末の改行削除
    " \(### \(items\|misc\|ref\)\)\n/",\1"/g
    exe 'silent'.'%s/\(### items\)\n/\1"/g'
    exe 'silent'.'%s/\(### \(misc\|ref\)\)\n/",\1"/g'
    "-- note >> "" 囲みの閉じ " をセット，前行の改行削除
    " \n^\(",### \(items\|misc\|ref\)\)/\1/g
    exe 'silent'.'%s/\n^\(### items\)/\1/g'
    exe 'silent'.'%s/\n^\(",### \(misc\|ref\)\)/\1/g'
    "-note >> タイトル削除
    exe 'silent'.'%s/\(### \(items\|misc\|ref\)\)//g'

    "コメント行削除
    call s:ExistenceCheckAndSubstitute('<!--.\{-}-->\n','')

    "最後の 閉じ " セット
    " exe 'silent'.'%s/\n\{3}/"改行改行改行/g'
    exe 'silent'.'%s/\n\{2,3}/"/g'
endfunction
command! -nargs=0 Csv call <SID>MakeMapToCSV()


" ********** Single
function! s:ChangeToSingleByte()
    let l:dic = {}
    call extend(l:dic, {'０':'0','１':'1','２':'2','３':'3','４':'4','５':'5','６':'6','７':'7','８':'8','９':'9'})
    call extend(l:dic, {'①':'1','②':'2','③':'3','④':'4','⑤':'5','⑥':'6','⑦':'7','⑧':'8','⑨':'9'})
    call extend(l:dic, {'Ａ':'A','Ｂ':'B','Ｃ':'C','Ｄ':'D','Ｅ':'E','Ｆ':'F','Ｇ':'G','Ｈ':'H','Ｉ':'I','Ｊ':'J','Ｋ':'K','Ｌ':'L','Ｍ':'M','Ｎ':'N','Ｏ':'O','Ｐ':'P','Ｑ':'Q','Ｒ':'R','Ｓ':'S','Ｔ':'T','Ｕ':'U','Ｖ':'V','Ｗ':'W','Ｘ':'X', 'Ｙ':'Y','Ｚ':'Z'})
    call extend(l:dic, {'ａ':'a','ｂ':'b','ｃ':'c','ｄ':'d','ｅ':'e','ｆ':'f','ｇ':'g','ｈ':'h','ｉ':'i','ｊ':'j','ｋ':'k','ｌ':'l','ｍ':'m','ｎ':'n','ｏ':'o','ｐ':'p','ｑ':'q','ｒ':'r','ｓ':'s','ｔ':'t','ｕ':'u','ｖ':'v','ｗ':'w','ｘ':'x','ｙ':'y','ｚ':'z'})
    call extend(l:dic, {'（':'(', '）':')', '［':'[', '］':']', '｛':'{', '｝':'}', '＜':'<', '＞':'>', '”':'"', "’":"'", "‘":"'", '“':'"'})
    call extend(l:dic, {'￥':'\\','＆':'\&','／':'\/','：':':', '；':';', '＊':'*', '％':'%', '？':'?', '　':' ', '！':'!', '～':'-', '〜':'-', '―':'-', '＝':'=', '＋':'+'})
    "# do substitute
    for l:key in keys(l:dic)
        exe 'silent %s/'.l:key.'/'.l:dic[l:key].'/ge'
    endfor
    " exe 'silent %s/\d\zs．\ze\d[^$]/./ge'
    exe 'silent %s/\d\zs．d/./ge'
endfunction
command! -nargs=0 Single call <SID>ChangeToSingleByte()


" ********** Numb
" ref. http://kikaibunsho.web.fc2.com/monologo/memoro/08_11.html
" ref. http://vimdoc.sourceforge.net/htmldoc/eval.html#printf%28%29
function! s:InsertNumbering(cnt) range
    echo "'" . a:cnt . "'"
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

" ********** for google blogger
" html
command! Poff call <SID>htmlPTag(0)
command! Pon call <SID>htmlPTag(1)


command! Draft call <SID>markdownToHtml(0)
command! Release call <SID>markdownToHtml(1)
function! s:markdownToHtml(edition)
    if &filetype != 'markdown'
        echo 'the type of this file is not markdown ...'
        return
    endif

    "# quickrun ; markdown > html
    exe "QuickRun -runner system"

    exe "normal \<c-w>w"
    exe "%y"
    exe "tabnew"
    exe 0."put"
    exe "set ft=html"
    exe 0

    "# <p> tag
    call s:htmlPTag(a:edition)

    " # footnotes
    " call s:Footnotes()
    " # cleaning
    call s:htmlClean()

    "# done!!
    exe 0
endfunction
" via http://d.hatena.ne.jp/mFumi/20110920/1316525906
" via http://archiva.jp/web/tool/vim_basic.html

" markdown
command! Down call <SID>htmlToMarkdown()
let s:dicTag = {'<ul>':'</ul>', '<ol>':'</ol>'}
let s:tagisUl = 'ul'
let s:tagisOl = 'ol'
function! s:htmlToMarkdown()
    exe '%y'
    exe 'tabnew'
    exe 0.'put'
    exe 'set ft=markdown'
    exe 0

    call s:htmlPTag(1)
    call s:htmlClean()
    call s:markdown()

    exe 1
endfunction

function! s:htmlPTag(flg)
    if a:flg == 0    "off <!--p--><--/p-->
        let l:tagStart = ['<p>','<!--p-->']
        let l:tagEnd = ['<\/p>','<!--\/p--><br \/>']
    else    "on <p></p>
        let l:tagStart = ['<!--p-->','<p>']
        let l:tagEnd = ['<!--\/p--><br \/>','<\/p>']
    endif
    exe 'silent'.'%s/'.l:tagStart[0].'\(.\_.\{-}\)'.l:tagEnd[0].'/'.l:tagStart[1].'\1'.l:tagEnd[1].'/ge'

    "clean
    if a:flg == 0
    else
        exe 'silent'.'%s/$\n<br \/>\ze$\n//ge'
        exe 'silent'.'%s/$\n<br \/><!--\/p-->\ze$\n//ge'
    endif

endfunction

command! Clean call <SID>htmlClean()
function! s:htmlClean()
    "# list as the contents
    "## url
    exe 'silent'.'%s/\(<li><a \).\{-}\(href="\).\{-}\(#.\{-}<\/a>\)/\1\2\3/ge'
    "## mark «
    exe 'silent'.'%s/\(<li.\{-}><a href="#.\{-}\)\(\|\( \)*«\|\(&nbsp;\)*«\)\(<\/a>\)/\1 «\5/g'


    "# headings
    call s:htmlCleanHeadings()

    "# anchor
    call s:htmlCleanAnchor()

    "# <div></div>
    exe 'silent'.'%s/<div>\_s\{-}<\/div>//ge'
endfunction

function! s:Footnotes()
    let s:flg = 0

    let s:id = 0
    let s:footnotes = {}

    for s:line in range(1, line('$'))
        let s:lineStr = getline(s:line)

        " set any anchors of the footnotes & store them as a dictionary
        if match(s:lineStr, '((') >= 0
            let s:tmp = matchstr(s:lineStr, '((.\{-}))')
            if s:tmp == ""
                let s:tmp = substitute(matchstr(s:lineStr, '((.*'), '  $', '<br>', 'g')
                let s:flg = 1
            else
                let s:footnotes[s:id] = s:tmp
                let s:flg = 0
                let s:id += 1
            endif
            let s:dropaline = s:FootnoteStr(0, s:id, s:tmp).substitute(matchstr(s:lineStr,'((.*'),'&quot;', '"', 'g') "why '&quot;' ?
            call setline(s:line, substitute(s:lineStr, '((.*', s:dropaline, 'g'))
        elseif s:flg == 1
            if match(s:lineStr, '))') >= 0
                let s:footnotes[s:id] = s:tmp . matchstr(s:lineStr, '^.\{-}))')
                let s:flg = 0
                let s:id += 1
            else
                let s:tmp = s:tmp . substitute(s:lineStr, '  $', '<br>', 'g')
            endif
        endif
    endfor

    call append(line('$'), ['','',''])

    " write the footlines
    call append(line('$'), '<div class="footnote">')
    for s:id in keys(s:footnotes)
        " echo s:id .': '. s:footnotes[s:id]
        call append(line('$'), s:FootnoteStr(1, s:id, s:footnotes[s:id]))
    endfor
    call append(line('$'), '</div>')

    exe 'silent'.'%s/((.\_.\{-}))//g'

endfunction
function! s:FootnoteStr(switch, id, str)
    if a:switch == 0
        let s:temp = substitute(a:str, '\(((\|))\|  $\)', '', 'g')
        let s:temp = substitute(s:temp, '\(<a.\{-}>\|<\/a>\)', '', 'g')
        " let s:return = '<a href="#f'.a:id.'" name="fn'.a:id.'" title="'.s:temp.'" class="footnote-num">*'.a:id.'</a>'
        let s:return = '<a href="#f'.a:id.'" name="fn'.a:id.'" class="footnote-num">*'.a:id.'</a>'
    else
        let s:temp = matchstr(a:str, '((\zs.\{-}\ze))')
        let s:return = '<p class="footnote"><a href="#fn'.a:id.'" name="f'.a:id.'" class="footnote-num">*'.a:id.'</a>: <span class="footnote-txt">'.s:temp.'</span></p>'
    endif
    return s:return
endfunction
command! Footnotes call <SID>Footnotes()
" function! s:Footnotes()
    " let s:flg = 0

    " let s:id = 0
    " let s:footnotes = {}

    " for s:line in range(1, line('$'))
        " let s:lineStr = getline(s:line)
        " "
        " " set any anchors of the footnotes & store them as a dictionary
        " if match(s:lineStr, '((') >= 0
            " let s:tmp = matchstr(s:lineStr, '((.\{-}))')
            " if s:tmp == ""
                " let s:tmp = substitute(matchstr(s:lineStr, '((.*'), '  $', '<br>', 'g')
                " let s:flg = 1
            " else
                " let s:footnotes[s:id] = s:tmp
                " let s:flg = 0
                " let s:id += 1
            " endif
            " call setline(s:line, substitute(s:lineStr, '((.*', s:FootnoteStr(0, s:id, s:tmp).matchstr(s:lineStr,'((.*'), 'g'))
        " elseif s:flg == 1
            " if match(s:lineStr, '))') >= 0
                " let s:footnotes[s:id] = s:tmp . matchstr(s:lineStr, '^.\{-}))')
                " let s:flg = 0
                " let s:id += 1
            " else
                " let s:tmp = s:tmp . substitute(s:lineStr, '  $', '<br>', 'g')
            " endif
        " endif
    " endfor

    " call append(line('$'), ['','',''])

    " " write the footnotes
    " call append(line('$'), '<div class="footnote">')
    " for s:id in keys(s:footnotes)
        " " echo s:id .': '. s:footnotes[s:id]
        " call append(line('$'), s:FootnoteStr(1, s:id, s:footnotes[s:id]))
    " endfor
    " call append(line('$'), '</div>')

    " exe 'silent'.'%s/((.\_.\{-}))//g'

" endfunction
" function! s:FootnoteStr(switch, id, str)
    " if a:switch == 0
        " let s:temp = substitute(a:str, '\(((\|))\|  $\)', '', 'g')
        " let s:return = '<a href="#f'.a:id.'" name="fn'.a:id.'" title="'.s:temp.'">*'.a:id.'</a>'
    " else
        " let s:temp = matchstr(a:str, '((\zs.\{-}\ze))')
        " let s:return = '<p class="footnote"><a href="#fn'.a:id.'" name="f'.a:id.'" class="footnote-num">*'.a:id.'</a>: <span class="footnote-txt">'.s:temp.'</span>'
    " endif
    " return s:return
" endfunction
" command! Footnotes call <SID>Footnotes()

function! s:htmlCleanHeadings()
    "# write in a line
    exe 'silent'.'%s/\(<h\d.\{-}>\)\n\(.\+\)\n\(<\/h\d>\)/\1\2\3/ge'
    "# set the id into the headings
    let l:dicId = {}
    "## get id and title
    for l:line in range(1, line('$'))
        if match(getline(l:line),'<li><a href="#') >= 0
            let l:lineIs = getline(l:line)

            let l:tmpID = matchstr(l:lineIs, '<li><a href="#\zs.\{-}\ze"')
            let l:tmpTitle = matchstr(l:lineIs, '<li><a.\{-}>\zs.\{-}\ze\s«')

            let l:dicId[l:tmpID] = l:tmpTitle

        endif
    endfor

    "## delete anchor in the headings
    exe '%s/\(<h\d.\{-}>\)<a.\{-}>\(.\{-}\)<\/a>\(<\/h\d>\)/\1\2\3/ge'

    "## set id into the heading
    let l:line = 1
    while l:line <= line('$')
        let l:lineIs = getline(l:line)

        "### search for the headings
        if matchstr(l:lineIs,'<h\d') != ""
            "#### get the level of the headings
            let l:tagIs = 'h'.matchstr(l:lineIs, '<h\zs\d\+\ze.\{-}>')

            "#### get title
            let l:myTitle = matchstr(l:lineIs, '<h\d.\{-}">\zs.\{-}\ze<\/h\d>')

            let l:myLineIs = ''
            "#### check id
            if matchstr(l:myTitle, '{\zs.\+\ze}$') != ""
                "#### defined id in the headings (eg.#### title{#id} -> <h4 id="id">title</h4>)
                let l:myLineIs = '<'.l:tagIs.' id="'.matchstr(l:myTitle, '{#\zs.\{-}\ze}$').'">'.matchstr(l:myTitle, '^.\{-}\ze{').'</'.l:tagIs.'>'
            else
                "#### check wheter or not the target header
                let l:myId = ''
                for [l:tmpId, l:tmpTitle] in items(l:dicId)
                    if l:tmpTitle == l:myTitle
                        let l:myId = l:tmpId
                        break
                    endif
                endfor
                let l:myLineIs = '<'.l:tagIs.' id="'.l:myId.'">'.l:myTitle.'</'.l:tagIs.'>'
            endif

            "### set
            call setline(l:line, l:myLineIs)
        endif

        let l:line += 1
    endwhile
endfunction

function! s:htmlCleanAnchor()
    let l:line = 1
    while l:line <= line('$')
        let l:lineIs = getline(l:line)
        "# anchor 'target="_blank"'
        if stridx(l:lineIs, '<a href=') >= 0 && stridx(l:lineIs, '<li>') < 0
            let l:tmp = split(matchstr(l:lineIs, '<a href="\zs.\{-}\ze"'),'/')[-1]

            if match(tolower(l:tmp), '\.jpg$') >= 0 || match(tolower(l:tmp), '\.png$') >= 0 || match(tolower(l:tmp), '\.gif$') >= 0
            elseif match(tolower(l:tmp), '#') >= 0
            else
                if stridx(l:lineIs, 'target="_blank">') >= 0
                else
                    call setline(l:line, substitute(l:lineIs, '\(<a .\{-}\)>', '\1 target="_blank">', 'g'))
                endif
            endif
        endif

        let l:line += 1
    endwhile
endfunction
function! s:markdown()
    "# headings
    exe 'silent'.'%s/<h\(\d\) id="\(.*\)">\(.\+\)\{-}<\/h\d>/\=repeat("#", submatch(1))." ".submatch(3)/ge'
    exe 'silent'.'%s/\(# \[.\{-}\)\(\]()\)/\1]/g'

    "# headings.if ...
    exe 'silent'.'%s/<h\(\d\)>\(.\+\)\{-}<\/h\d>/\=repeat("#", submatch(1))." ".submatch(2)/ge'
    exe 'silent'.'%s/#\s\[\(.\{-}\)\]$/# \1/ge'

    "# paragraphs
    exe 'silent'.'%s/<p>\(.\_.\{-}\)<\/p>/\1/ge'

    "# line breaks
    " exe 'silent'.'%s/<br \/>$/  /ge'
    exe 'silent'.'%s/\(br>\)\@<!<br>$/  /ge'
    exe 'silent'.'%s/\(br \/>\)\@<!<br \/>$/  /ge'
    " exe 'silent'.'%s/<br \/>//ge'
    exe 'silent'.'%s/\(br>\|^\)\@<!<br>//ge'
    exe 'silent'.'%s/\(br \/>\|^\)\@<!<br \/>//ge'

    "# list
    call s:markdownList()

    "# to clipboard
    exe '%y'

    "# set new buffer
    exe 'tabnew'
    exe 0.'put'
    exe 'set ft=markdown'
    exe 1
endfunction

function! s:markdownList()
    let l:rec = 1
    while l:rec <= line('$')
        let l:line = getline(l:rec)

        let l:cntTag_start = 0 " level by list
        let l:cntTag_end   = 0 " level by list

        if stridx(l:line, '<ul>') >= 0 || match(l:line, '<ol.\{-}>') >= 0
            "; which tag <ul> or <ol>
            let l:tagis = s:whichList(l:line)

            let l:recBeg = l:rec    "from

            let l:recList = l:recBeg
            while l:recList <= line('$')
                "; start-tag
                if stridx(getline(l:recList), '<ul>') >= 0 || match(getline(l:recList), '<ol.\{-}>') >= 0
                    let l:cntTag_start += 1
                "; end-tag
                elseif stridx(getline(l:recList), '</ul>') >= 0 || match(getline(l:recList), '</ol>') >= 0
                    let l:cntTag_end += 1

                    "; is the end of <ul>or<ol> section ?
                    if l:cntTag_start == l:cntTag_end
                        "; --- WRITE ---
                        let l:rec =  s:rewriteList(l:recBeg, l:recList, l:tagis)
                        break
                    endif
                endif

                "; to next record
                let l:recList += 1
            endwhile
        endif

        "; to next record
        let l:rec += 1
    endwhile
endfunction

function! s:rewriteList(beg, end, tagis)
    "; init
    let l:levelIs = 0

    let l:recBeg = a:beg " 処理中に更新したい為
    let l:recEnd = a:end " 処理中に更新したい為

    "; tag identification
    let l:tagId = []
    let l:dictmp = {}
    let l:dictmp[a:tagis] = 0
    call add(l:tagId, l:dictmp)

    let l:rec = l:recBeg
    while l:rec <= l:recEnd
        "; init , off the flag whatever delete the brank line
        let l:lineDel = 0

        "; read
        let l:lineTarget = getline(l:rec)

        if l:rec == l:recBeg
            let l:line = substitute(l:lineTarget, '<'.a:tagis.'.\{-}>', '', '')
            let l:lineDel = s:doThislineDel(l:line)
            "; init
            let l:recBeg = -1
        elseif l:rec == l:recEnd
            let l:line = substitute(l:lineTarget, '</'.a:tagis.'>', '', 'g')
            "; write
            call setline(l:rec, l:line)
            "; end of the section <ul>/<ol>
            return l:rec
        else
            if stridx(l:lineTarget, '<li>') >= 0

                "tag identification
                call map(l:tagId[l:levelIs],"v:val + 1")    "count up

                if get(l:tagId[l:levelIs], s:tagisUl) > 0
                    let l:markIs = "\* "
                elseif get(l:tagId[l:levelIs], s:tagisOl) > 0
                    let l:markIs = get(l:tagId[l:levelIs], s:tagisOl)."\. "
                endif

                let l:line = repeat("\t", l:levelIs) . substitute(l:lineTarget, '<li>', l:markIs,'')
                let l:line = substitute(l:line, '</li>', '','')

                "have id?
                if match(l:lineTarget, '<a href="#.\{-}"') >= 0
                    let l:idIs = matchstr(l:lineTarget, '<a href="#\zs.\{-}\ze"')
                    let l:line = matchstr(l:lineTarget, '<a .\{-}>\zs.\{-}\ze<')

                    let l:line = l:markIs . '['.l:line.']' . '(#'.l:idIs.')'
                endif

            elseif stridx(l:lineTarget, '<ul>') >= 0 || match(l:lineTarget, '<ol.\{-}>') >= 0
                let l:levelIs += 1
                "tag identification
                let l:tagis = s:whichList(l:lineTarget)
                let l:dictmp = {}
                let l:dictmp[l:tagis] = 0
                call add(l:tagId, l:dictmp)
                "get contents ; delete tag <ul>
                let l:line = substitute(l:lineTarget, '<'.l:tagis.'.\{-}>', '', '')
                " let l:line = substitute(l:lineTarget, '<ul>', '', '')
                let l:lineDel = s:doThislineDel(l:line)
            elseif stridx(l:lineTarget, '</ul>') >= 0 || stridx(l:lineTarget, '</ol>') >= 0
                if has_key(l:tagId[l:levelIs], s:tagisUl)
                    let l:tagEndis = s:tagisUl
                elseif has_key(l:tagId[l:levelIs], s:tagisOl)
                    let l:tagEndis =  s:tagisOl
                else
                endif

                if l:levelIs <= 0
                    let l:levelIs = 0
                else
                    let l:levelIs -= 1
                endif
                "get contents ; delete tag </ul>
                let l:line = substitute(l:lineTarget, '</'.l:tagEndis.'>', '', '')

                " let l:line = substitute(l:lineTarget, '</ul>', '', '')
                let l:lineDel = s:doThislineDel(l:line)
            else
                let l:line = substitute(l:lineTarget, '</li>', '', 'g')
                let l:lineDel = s:doThislineDel(l:line)
            endif
        endif

        if l:lineDel == 1
            "delete this record
            exe l:rec . 'd'
            let l:recEnd -= 1
        else
            "write
            call setline(l:rec, l:line)
            "next record
            let l:rec += 1
        endif

    endwhile
endfunction

function! s:doThislineDel(line)
    if a:line == '' || a:line == '</li>'
        return 1
    endif
    return 0
endfunction

function! s:whichList(str)
    if stridx(a:str, '<ul>') >= 0
        let l:yourtagis = 'ul'
    elseif match(a:str, '<ol.\{-}>') >= 0
        let l:yourtagis = 'ol'
    else
    endif
    return l:yourtagis
endfunction

" 引用符, 括弧の設定 (ref. http://ymkjp.blogspot.jp/2012/04/vim.html)
inoremap {} {}<Left>
inoremap [] []<Left>
inoremap () ()<Left>
inoremap """ ""<Left>
inoremap ''' ''<Left>
inoremap <> <><Left>

" augroup ExitBracket
    " autocmd!
    " autocmd InsertLeave * call ExitBracket()
" augroup END
" function! ExitBracket()
    " exe "set iminsert=0"
    " if mode() ==# 'n'
        " let matchend_idx = matchend(getline('.'), '.',  col('.') - 1)
        " let check_str = strpart(getline('.'), matchend_idx, 1)

        " let str_bracket = ')]}>"'''
        " if check_str != '' && stridx(str_bracket, check_str) != -1
            " if col('$') == matchend_idx + 2
                " startinsert!
            " else
                " call cursor(line('.'), matchend_idx + 2)
                " startinsert
            " endif
        " endif
    " endif
" endfunction

"-------------------------------------------------- .

noremap ; :
noremap : ;

" 何か set nocompatible あるとハイライト? がおかしくなるんですよ... 気持ち悪いので，強引スマートじゃないのは分かっているけど無理矢理．
source ~/.gvimrc
