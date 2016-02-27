" Encoding
set encoding=utf-8
scriptencoding utf-8


" My Bundles here:
set runtimepath+=~/.vim/dein/repos/github.com/Shougo/dein.vim

call dein#begin(expand('~/.cache/dein'))

    call dein#add('Shougo/dein.vim')
    call dein#add('Shougo/vimproc.vim', {
        \ 'build': {
        \     'windows' : 'tools\\update-dll-mingw',
        \     'cygwin'  : 'make -f make_cygwin.mak',
        \     'mac'     : 'make -f make_mac.mak',
        \     'linux'   : 'make',
        \     'unix'    : 'gmake',
        \    },
        \ })

" completion
    call dein#add('Shougo/neocomplete.vim')
    call dein#add('Shougo/context_filetype.vim')
    call dein#add('Shougo/neosnippet')
    call dein#add('Shougo/neosnippet.vim')
    call dein#add('Shougo/neosnippet-snippets')

" interface
  " unite
    call dein#add('Shougo/unite.vim')
    call dein#add('Shougo/neomru.vim')
    call dein#add('Shougo/unite-outline')
  " filer
    call dein#add('Shougo/vimfiler.vim')
  " ctrlp(?
    call dein#add('ctrlpvim/ctrlp.vim')
    call dein#add('vim-scripts/ctrlp-funky')
    call dein#add('mattn/ctrlp-filer')

" shell
    call dein#add('Shougo/vimshell')

" text editing
  " text object
    call dein#add('kana/vim-operator-user')
    call dein#add('kana/vim-textobj-user')
    call dein#add('kana/vim-textobj-jabraces')
    call dein#add('osyo-manga/vim-textobj-multiblock')
    call dein#add('osyo-manga/vim-textobj-multitextobj')
  " surround
    call dein#add( 'rhysd/vim-operator-surround')
  " comment
    call dein#add( 'tyru/caw.vim')
  " text align
    call dein#add( 'vim-easy-align')
    call dein#add( 'rhysd/clever-f.vim')

" appearance
  " colorscheme
    call dein#add('altercation/vim-colors-solarized')
    call dein#add('molokai')
    call dein#add('Wutzara/vim-materialtheme')
    call dein#add('w0ng/vim-hybrid')
    call dein#add('twerth/ir_black')
  " status line
    call dein#add('itchyny/lightline.vim')

" tools
    call dein#add('thinca/vim-quickrun')
    call dein#add('sukima/xmledit')
    call dein#add('mattn/emmet-vim')
    call dein#add('plasticscafe/vim-less-autocompile')
    call dein#add('groenewege/vim-less')

    call dein#add('toyamarinyon/vim-swift')

    call dein#add('glidenote/memolist.vim')

" web
    call dein#add('mattn/webapi-vim')

    call dein#add('kannokanno/previm')
    call dein#add('joker1007/vim-markdown-quote-syntax')

    call dein#add('tyru/open-browser.vim')

    call dein#add('yuratomo/w3m.vim')
    call dein#add('mrtazz/simplenote.vim')

" misc
    call dein#add('itchyny/calendar.vim')

call dein#end()

let g:dein#types#git#clone_depth = 1
if dein#check_install()
  call dein#install()
endif

filetype plugin indent on



"--------------------------------------------------------------------------- >common
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
"" タブの画面上での幅
"set tabstop=8
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

"バイナリ編集(xxd)モード（vim -b での起動、もしくは *.bin ファイルを開くと発動します）
augroup BinaryXXD
  autocmd!
  autocmd BufReadPre *.bin let &binary =1
  autocmd BufReadPost * if &binary | silent %!xxd -g 1
  autocmd BufReadPost * set ft=xxd | endif
  autocmd BufWritePre * if &binary | %!xxd -r | endif
  autocmd BufWritePost * if &binary | silent %!xxd -g 1
  autocmd BufWritePost * set nomod | endif
augroup END



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
" 検索結果ハイライト
nmap <S-Esc><S-Esc> ;nohlsearch<CR><Esc>
" ヘルプ
nnoremap <C-i> :<C-u>help<Space>
nnoremap <C-i><C-i> :<C-u>help<Space><C-r><C-w><Enter>
augroup help
  autocmd!
  autocmd FileType help nnoremap <buffer> <Esc><Esc> <C-w>c
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
nnoremap <C-w>j <C-w>K
nnoremap <C-w>h <C-w>H
" 行頭、行末移動
noremap =0 $
" カーソルの位置から行頭、行末まで選択
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
" 。/、セットを．/，にする
nnoremap <leader>. :%s/。/．/g<CR>:%s/、/，/g<CR>
" バッファ内すべてのコンテンツをクリップボードへ
noremap ya :%y<CR>
" 折りたたみ
nnoremap zoo zR
nnoremap zcc zM
nnoremap <space> zA
" ref. http://dougblack.io/words/a-good-vimrc.html#fold
vnoremap <c-a> <c-a>gv
vnoremap <c-x> <c-x>gv
" ref. http://vim-jp.org/blog/2015/06/30/visual-ctrl-a-ctrl-x.html


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
" >caw.vim
"
nmap <Leader>x <Plug>(caw:i:toggle)
vmap <Leader>x <Plug>(caw:i:toggle)
nmap <Leader>x0 <Plug>(caw:I:toggle)
vmap <Leader>x0 <Plug>(caw:I:toggle)
nmap <Leader>xa <Plug>(caw:a:toggle)
vmap <Leader>xa <Plug>(caw:a:toggle)


"
" >vim-easy-align
"
vmap <Enter> <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

let g:easy_align_ignore_groups = []
let g:easy_align_delimiters = {
\ '.': { 'pattern': '\.\{2}\|\.\{3}' },
\ '"': { 'pattern': '"', 'filter': 'v/^\s*"/', 'ignore_groups': ['String']},
\ "'": { 'pattern': "'", 'filter': 'v/^\s*"/', 'ignore_groups': ['String']},
\ '#': { 'pattern': ' #' },
\ }
"
" ref. https://github.com/junegunn/vim-easy-align/blob/master/EXAMPLES.md#aligning-in-line-comments
" ref. https://github.com/ervandew/supertab/issues/74#issuecomment-65552406
" :h easy-align-ignoring-delimiters-in-comments-or-strings
" :h easy-align-6-8-1
"
command! -nargs=* -range Align <line1>, <line2>call easy_align#align('<bang>' == '!', 0, '', <q-args>)


"
" >calendar.vim
"
map <Leader>cal ;Calendar -view=year -split=vertical -width=24<CR>
map <Leader>yr ;Calendar -view=year<CR>


"
" >w3m
"
let g:w3m#command = '/usr/local/bin/w3m'

" デフォルトの検索エンジンを google にする
let g:w3m#search_engine = 'http://www.google.com/search?hl=ja&ie=' . &encoding . '&q=%s'
nnoremap <leader>w :W3mTab google<space>
" どうしても、な時のための外部ブラウザは chrome
let g:w3m#external_browser = 'goole-chrome'
nnoremap <leader>w :W3mTab google
" ref. https://sites.google.com/site/hymd3a/vim/w3m-vim#TOC--3


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


"
" >previm
"
map <Leader>pv ;PrevimOpen<cr>



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
" >memolist
"
map <Leader>mn ;MemoNew<cr>
map <Leader>ml ;MemoList<CR>
map <Leader>mg ;MemoGrep<CR>
" my memo dir
let g:memolist_path = '~/Dropbox/memo/'
" tag, categories, grep
let g:memolist_prompt_tags = 1
let g:memolist_prompt_categories = 1
let g:memolist_qfixgrep = 1
" using unite
let g:memolist_unite = 1
let g:memolist_unite_source = 'file'  " file_rec は上手く作動しない?
let g:memolist_unite_option = '-auto-preview -start-insert'
let g:memolist_vimfiler = 0           " no vimfiler
" no need filename prefix
let g:memolist_filename_prefix_none = 1
"ctrlp ?
let g:memolist_ex_cmd = 'CtrlP'



"
" >neocomplete.vim
"
" AutoComplPop オフ
let g:acp_enableAtStartup = 0
" 起動時 neocomplete を有効化
let g:neocomplete#enable_at_startup = 1
" 大文字を入力するまで、大/小文字を無視して補完
let g:neocomplete#enable_smart_case = 1
" 3 文字以上の単語を補完候補としてキャッシュ
let g:neocomplete#sources#syntax#min_keyword_length = 3
" neocompleteを自動的にロックするバッファ名のパターン
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
" 日本語入力時、無効化
let g:neocomplete#lock_iminsert = 1
" 補完開始文字数
let g:neocomplete#auto_completion_start_length=3

" 辞書
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'vim' : $HOME.'/.vim/dict/vim.dict'
        \ }

" キーワードと見なす正規表現を設定
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
" \h: [A-Za-z_] \w: [0-9A-Za-z_] refs help regexp
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g> neocomplete#undo_completion()
" inoremap <expr><C-l> neocomplete#complete_common_string()     # `inoremap <C-l><Right>` を使いたいので

" 入力モード ひらがな (im "on" の状態) で改行すると、英字 (im "off") モードになってしまうのでコメント
"" Recommended key-mappings.
"" <CR>: close popup and save indent.
"inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
"function! s:my_cr_function()
"  return neocomplete#close_popup() . "\<CR>"
"endfunction

" TAB で補完できるようにする
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"
" <C-h>, <BS>: ポップアップを閉じ、文字列を削除
" inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>" # `inoremap <C-h><Left>`を使いたいので
" inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"  # `inoremap <C-h><Left>`を使いたいので

" FileType毎のOmni補完を設定
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif



"
" >neosnippet
"
" my defined snippet files.
let g:neosnippet#snippets_directory='~/.vim/snippets'
" Plugin key-mappings.
imap <C-Space>     <Plug>(neosnippet_expand_or_jump)
smap <C-Space>     <Plug>(neosnippet_expand_or_jump)
xmap <C-Space>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
" For snippet_complete marker.
if has('conceal')
set conceallevel=2 concealcursor=niv
endif



"
" >align.vim
"
" 日本語など幅広文字に対応するためのおまじない。(ref. http://vim-users.jp/2009/09/hack77/)
let g:Align_xstrlen=3



"
" >unite
"
let g:unite_source_history_yank_enable = 1
let g:unite_enable_start_insert = 1
let g:unite_enable_ignore_case = 1
let g:unite_enable_smart_case = 1

" path
" let g:neomru#file_mru_path=expand('~/.cache/neomru/file')
" let g:neomru#directory_mru_path=expand('~/.cache/neomru/directory')
let g:unite_source_bookmark_directory=$HOME . '/.vim/unite/bookmarks'

" unite mapping
" unite mapping.the prefix key
noremap [Unite] <Nop>
nmap <Leader>f [Unite]
" unite mapping.mappins
noremap  [Unite]r :<C-u>Unite file_mru<CR>
noremap  [Unite]b :<C-u>Unite buffer<CR>
noremap  [Unite]f :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
noremap  [Unite]m :<C-u>Unite bookmark<CR>
noremap  [Unite]g :<C-u>Unite -buffer-name=register register<CR>
nnoremap [Unite]p :<C-u>Unite mapping<CR>
nnoremap [Unite]i :<C-u>Unite output:message<CR>
nnoremap [Unite]y :<C-u>Unite history/yank<CR>

nnoremap [unite]a :<C-u>UniteBookmarkAdd<CR>

autocmd FileType unite call s:unite_settings()
function! s:unite_settings()
  " ウィンドウを分割して開く
  nnoremap <silent> <buffer> <expr> <C-h> unite#do_action('split')
  inoremap <silent> <buffer> <expr> <C-h> unite#do_action('split')
  " ウィンドウを縦に分割して開く
  nnoremap <silent> <buffer> <expr> <C-v> unite#do_action('vsplit')
  inoremap <silent> <buffer> <expr> <C-v> unite#do_action('vsplit')
  " インサート→ノーマルモード
  imap <buffer> jj <Plug>(unite_insert_leave)
  " 閉じる
  imap <buffer> <Esc><Esc> <Plug>(unite_exit)
  nmap <buffer> <Esc> <Plug>(unite_exit)
  " ref. http://lambdalisue.hatenablog.com/entry/2013/06/23/071344
endfunction

" unite : grep > ag(silver searcher)
nnoremap <silent> ,g  :<C-u>Unite grep:. -buffer-name=search-buffer<CR>
nnoremap <silent> ,gg :<C-u>Unite grep:. -buffer-name=search-buffer<CR><C-R><C-W>
nnoremap <silent> ,r  :<C-u>UniteResume search-buffer<CR>
if executable('ag')
  let g:unite_source_grep_command = 'ag'
  let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
  let g:unite_source_grep_recursive_opt = ''
endif



"
" >unite-outline
"
let g:unite_winwidth = 40
nnoremap <silent> <Leader>o :<C-u>Unite -vertical -no-quit outline<CR>



"
" >vimshell
"
let g:vimshell_split_command="vsplit"
nnoremap <silent> <Leader>vsh :<C-u>VimShellBufferDir -split<CR>
nnoremap <silent> <Leader>sh :<C-u>VimShell<CR>



"
" >vimfiler
"
" デフォルトはvimfiler (netrw ではない)
let g:vimfiler_as_default_explorer = 1
" セーフモードをオフ (ref. http://blog.livedoor.jp/okashi1/archives/51808590.html)
let g:vimfiler_safe_mode_by_default = 0

" 開く (開いているファイルがあるディレクトリ)
nnoremap <silent> <Leader>fc :<C-u>VimFilerBufferDir -quit<CR>
" ide 風 (開いているファイルがあるディレクトリ)
nnoremap <silent> <Leader>fl :<C-u>VimFilerBufferDir -split -simple -winwidth=35 -toggle -no-quit<CR>

  let g:vimfiler_tree_leaf_icon     = " " " default: '|'
  let g:vimfiler_tree_opened_icon   = "-" " default: '-'
  let g:vimfiler_tree_opened_icon   = "▾"
  let g:vimfiler_tree_closed_icon   = "+" " default: '+'
  let g:vimfiler_tree_closed_icon   = "▸"
  let g:vimfiler_readonly_file_icon = "!" " deafult: 'X'
" let g:vimfiler_file_icon          = '-' " default: '-' why?
  let g:vimfiler_marked_file_icon   = '*' " default: '*'
  " ref. http://blog.scimpr.com/2013/03/06/vimfiler%E3%81%AF%E3%81%98%E3%82%81%E3%81%BE%E3%81%97%E3%81%9F/


augroup vimfiler
  autocmd!
  autocmd FileType vimfiler call s:vimfiler_settings()
augroup END
function! s:vimfiler_settings()
  " tree での制御は、<Space>
  map <silent><buffer> <Space> <NOP>
  nmap <silent><buffer> <Space> <Plug>(vimfiler_expand_tree)
  nmap <silent><buffer> <S-Space> <Plug>(vimfiler_expand_tree_recursive)

  " オープンは、<CR>(enter キー)
  nmap <buffer><expr> <CR> vimfiler#smart_cursor_map(
          \ "\<Plug>(vimfiler_cd_file)",
          \ "\<Plug>(vimfiler_open_file_in_another_vimfiler)")

  " マークは、<C-Space>(control-space)
  nmap <silent><buffer> <C-Space> <Plug>(vimfiler_toggle_mark_current_line)
  vmap <silent><buffer> <C-Space> <Plug>(vimfiler_toggle_mark_selected_lines)

  nnoremap <buffer><expr> <C-h> vimfiler#do_switch_action('split')
  nnoremap <buffer><expr> <C-v> vimfiler#do_switch_action('vsplit')
  " :h vimfiler#do_switch_action()
  " ref. https://github.com/Shougo/vimfiler.vim/issues/274
  " ref. https://github.com/Shougo/vimfiler.vim/issues/114

  " 移動、<Tab> だけでなく <C-l> も
  nmap <buffer> <C-l> <plug>(vimfiler_switch_to_other_window)

  " 閉じる、<Esc> 2 回叩き
  nmap <buffer> <Esc><Esc> <Plug>(vimfiler_exit)
endfunction
" ref. http://www.karakaram.com/vimfiler#vimrc


"
" >vim-operator-surround
"
map sa <Plug>(operator-surround-append)
map ds <Plug>(operator-surround-delete)
map cs <Plug>(operator-surround-replace)

" markdown code block ```...``` !!
let g:operator#surround#blocks = {
\ '-' : [
\       { 'block' : ['[ ', ' ]'], 'motionwise' : ['char', 'line', 'block'], 'keys' : [' ]', ' ['] },
\ ],
\ 'markdown' : [
\       { 'block' : ["**", "**"], 'motionwise' : ['char', 'line', 'block'], 'keys' : ['**'] },
\       { 'block' : ["```\n", "\n```"], 'motionwise' : ['line'], 'keys' : ['`'] },
\ ] }



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
" => 日本語コンテンツ内で使う半角英数字の前後に半角スペースを入れたいと思って。

function! s:FormSpace() range
    let l:current=line('.')
    " シングルバイト英字、前後にスペース
    exe 'silent ' . a:firstline . ',' . a:lastline . 's/[^\x01-\x7E、。「]\zs\(\w\)/ \1/ge'
    exe 'silent ' . a:firstline . ',' . a:lastline . 's/\(\w\)\ze[^\x01-\x7E、。」]/\1 /ge'
    " シングルバイト括弧/数値 前後にスペース
    " 括弧の前 forward
    exe 'silent ' . a:firstline . ',' . a:lastline . 's/[^\x01-\x7E 、。「]\zs\(`[^` ]\{-}`\|''[^'' ]\{-}''\|"[^" ]\{-}"\|<.\{-}>\|(.\{-})\|\[.\{-}\]\|{.\{-}}\)/ \1/ge'
    " 括弧の後 behind
    exe 'silent ' . a:firstline . ',' . a:lastline . 's/\(`[^` ]\{-}`\|''[^'' ]\{-}''\|"[^" ]\{-}"\|<.\{-}>\|(.\{-})\|\[.\{-}\]\|{.\{-}}\)\ze[^\x01-\x7E 、。」]/\1 /ge'
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
" 全角の英数字を半角にする。(自分の win 環境では hz_ja.vim が上手く動いてくれないみたいなので orz)
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
    " 置換処理. 数値の小数点(それ以外は、句点とする)
    exe 'silent! ' . a:firstline . ',' . a:lastline . 's/\d\zs．\ze\d/./ge'
endfunction
command! -nargs=0 -range Single <line1>, <line2> call s:ChangeToSingleByte()



"
" :<line>,<line>Num {startNum}[format]
"
" 連番を先頭に挿し込む。
" 引数は1つのみ、必須。開始値を指定する。(無い場合は1から)

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



" "
" " s:FormMarkdownEOL()
" "
" " markdown 形式における各行末のフォーマット調整。(ただし不完全 :P)
" " とりわけ <br> の行末スペースx2を確認し、必要に応じ追加、書き換える。
" "
" " !note の箇所は、導入時、要注意。
" "   置換先の文字列は、いずれも "半角スペース2つに改行"。
" "   改行コードは `<C-v><CR>`。
" "   ```
" "   :s/\(\/$\)\n\(\/g\)/\1  \^M\2/g
" "   ```
" "   上述置換処理の `^M` は `<C-v><CR>` で改行コード。
" function! s:FormMarkdownEOL()
"   let l:cur = line('.')
"   " 行末空白がx3以上の場合
"   exe 'silent %s/^[^$].*\S\zs\s\{3,}$\n\ze[^$]/  /ge'
"   " 行末空白がx1の場合
"   exe 'silent %s/^[^$].*\S\zs\s\{1}$\n\ze[^$]/  /ge'
"   " 行末空白がx0の場合
"   exe 'silent %s/^[^$].*\S\zs$\n\ze[^$]/  /ge'
"
"   " -- header
"   exe 'silent g/^\(=\|-\)\{3,}\s*$/s/\s\+$//ge'
"   exe 'silent g/^\(=\|-\)\{3,}\s*$/-1s/\s\+$//ge'
"
"   exe 'silent g/^#\+[^#]/s/\s\+$//ge'
"   exe 'silent g/^#\+[^#]/-1s/\s\+$//ge'
"
"   " -- horizontal rules
"   exe 'silent g/^\(-\|*\|_\|-\s\|*\s\|_\s\)\{3,}/s/\s\+$//ge'
"
"   " -- code
"   " exe 'silent g/\(^```\s*\a\+\)\_[^`]*\(^```\)/s/\s\+$//gc'
"
"   " -- lists
"   " exe 'silent g/^\(\s\|\t\)*\(\*\|-\|\d*\.\)\s\/s/\s\+$//ge'
"
"   " -- table
"   exe 'silent g/^\(\s\|\t\)*|.*|\s\+$/s/\s\+$//ge'
"
"   " --- html tag
"   exe 'silent g/^\(\s\|\t\|.\)*<.*>\s*$/s/\s\+$//ge'
"
"   " -- Reference-style links
"   exe 'silent %s/^\[\d\+\]:.*\zs\s\{2}$//ge'
"
"
"   let l:iscode = 0  "not erase
"   for l:line in range(1, line('$'))
"     let l:lineStr = getline(l:line)
"   " -- code
"     if match(l:lineStr, '^\s*```') >= 0
"       if l:iscode == 0
"         let l:iscode = 1  "switch mode = 'erase'
"       else
"         exe 'silent ' . l:line . 's/\s\+$//ge'
"         let l:iscode = 0  "switch mode = 'not erase'
"       endif
"     endif
"
"     if l:iscode == 1
"       "erase the blanks on EOL
"       exe 'silent ' . l:line . 's/\s\+$//ge'
"     else
"   " -- list
"       if match(l:lineStr, '^\s*\(-\s\|*\s\|\d\{-}\.\s\)') >= 0 &&
"        \ match (getline(l:line + 1), '^\s*\($\|-\s\|*\s\|\d\{-}\.\s\)') >= 0
"         exe 'silent ' . l:line . 's/\s\{-1,}$//ge'
"       endif
"     endif
"   endfor
"
"   exe l:cur
" endfunction
" command! Mdown call s:FormMarkdownEOL()

"--------------------------------------------------------------------------- .misc

noremap ; :
noremap : ;
