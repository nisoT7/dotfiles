"
"基本設定
"
"viとの互換をなくす
set nocompatible
"改行コードの自動認識
set fileformats=unix,dos,mac
"ビープ音を消す
set vb t_vb=

"
"	文字コード
"
"UTF-8を使用する
set fenc=utf-8
set fencs=iso-2022-jp,euc-jp,cp932,utf-8
set enc=utf-8
set encoding=utf-8

"
"	表示
"

"タブ幅の設定
set ts=4 sw=4
set softtabstop=4
set expandtab
set smarttab
"折り返しを無効
"set nowrap
"行番号の表示
set number
"自動インデントの無効
set noautoindent
set nocindent
"ステータス行を追加
set laststatus=2
"ステータス行に文字コードと改行コードを表示
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P
"コマンドを表示する
set showcmd
"タイトルをウィンドウ枠に表示
set title
"括弧入力時対応括弧を表示
set showmatch
"対応する括弧の表示時間を2にする
set matchtime=2
"シンタックスハイライトを有効
syntax on
"コメント文の色を変更
highlight Comment ctermfg=DarkCyan
"コマンドライン補完を拡張モードにする
set wildmenu
" 全角スペースの表示
highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=darkgray
match ZenkakuSpace /　/

"
"	検索
"

"検索語を画面中央に
nmap n nzz
nmap N Nzz
"検索結果文字列をハイライト表示する
set hlsearch
"検索時に最終行から先頭行に戻る
set wrapscan
"インクリメンタル検索
set incsearch
"コマンド,検索パターンを100個まで履歴に残す
set history=100
"検索時に大文字小文字を区別しない
set ignorecase
"検索のとき大文字が含まれている場合区別する
set smartcase


"
"   その他機能
"

" ビジュアルモードで選択したテキストが、クリップボードに入るようにする
" http://nanasi.jp/articles/howto/editing/clipboard.html
set clipboard=autoselect
  
"無名レジスタに入るデータを、*レジスタにも入れる。
"set clipboard+=unnamed
set clipboard=unnamedplus


"マウス機能有効化
"a:すべての機能のときにマウスを使うことができる
set mouse=a

"Backspaceの設定
"start:ノーマルモードから再び挿入モードに戻ったときにバックスペースで自由に削除を行える
"eol:行頭でバックスペースを行うと行の連結を行う
"オートインデントモードのインデントも削除可能
"好きなものを加えるとよい
set backspace=start,eol,indent

"先頭や末尾からのカーソル移動
set whichwrap=b,s,[,],<,>,~

"tab補完 補完時の一覧表示機能有効化
"候補が二つ以上ある時にすべての候補を一覧表示
"最初に並ぶ候補を補完対象とする
set wildmenu wildmode=list:full

set expandtab "タブ入力を複数の空白入力に置き換える
set autoindent "改行時に前の行のインデントを継続する
set smartindent "改行時に入力された行の末尾に合わせて次の行のインデントを増減する

" コマンド補完を開始するキー
set wildchar=<tab>

"スクリーンで256色使用可能(どのような時に使用できるか現在不明)
set t_Co=256
"起動時のメッセージ省略
set shortmess+=I
"listを使用するときに必要(多分↓を使用する際に必要になるのでは？)
set list
"空白の可視化
set listchars=tab:>-,trail:-,extends:>,precedes:<
"バイナリファイルの非印字可能文字16進数で表示
set display=uhex
"コマンドラインの行数
set cmdheight=2
"カーソルの位置の表示
set ruler
"カーソル上下に表示する最小限の行数
set scrolloff=2
"対応する括弧を表示
set showmatch
"現時点では何をしているのかよく分からない
set formatoptions+=mM

"autodate
let g:autodate_format = '%Y-%m-%d'
let g:autodate_keyword_pre = 'Last Modified:'
let g:autodate_keyword_post = '$'

if has("autocmd")
    filetype plugin indent on
    augroup vimrcEx
    au!
    autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g `\"" |
    \ endif

    augroup  END
endif "has("autocmd")

" 日本語を含まない場合は fileencoding に encoding を使うようにする
if has('autocmd')
 function! AU_ReCheck_FENC()
    if &fileencoding =~# 'iso-2022-jp' && search("[^\x01-\x7e]", 'n') == 0
        let &fileencoding=&encoding
    endif
 endfunction
 autocmd BufReadPost * call AU_ReCheck_FENC()
endif

"-------------------------
" Start Neobundle Settings.
"-------------------------
"bundle管理するディレクトリの指定

set runtimepath+=~/.vim/bundle/neobundle.vim/

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

"neobandle自体をneobundleで管理
NeoBundleFetch 'Shougo/neobundle.vim'
"-------ここから追加のプラグインを書く-------------

"NERDTreeを設定
NeoBundle 'scrooloose/nerdtree'
"autoclose
NeoBundle 'Townk/vim-autoclose'
"quickrun
NeoBundle 'thinca/vim-quickrun'
"grep.vim
NeoBundle 'grep.vim'
"syntastic
NeoBundle 'scrooloose/syntastic'
if ! empty(neobundle#get("syntastic"))
    "Disable automatic check at file open/close
    let g:syntastic_check_on_open=0
    let g:syntastic_check_on_wq=0
    "C
    let g:syntastic_c_check_header = 1
    "C++
    let g:syntastic_cpp_check_header = 1
endif
"c++11:シンタックスハイライト
NeoBundleLazy 'vim-jp/cpp-vim', {
            \ 'autoload' : {'filetypes' : 'cpp'}
            \ }

"Align
NeoBundle 'Align'
"-------ここまでプラグインを書く場所--------------
call neobundle#end()

" Required:
filetype plugin indent on

"未インストールのプラグインがある場合、インストールをするかどうかのチェック
NeoBundleCheck

"----------------------
"End Neobundle Settings.
"----------------------

"------------------------
"Vim-Texのプラグインの設定
"-------------------------
filetype plugin on
filetype indent on
set shellslash
set grepprg=grep\ -nH\ $*
let g:tex_flavor='latex'
let g:Imap_UsePlaceHolders = 1
let g:Imap_DeleteEmptyPlaceHolders = 1
let g:Imap_StickyPlaceHolders = 0
let g:Tex_DefaultTargetFormat = 'pdf'
let g:Tex_MultipleCompileFormats='dvi,pdf'
"let g:Tex_FormatDependency_pdf = 'pdf'
let g:Tex_FormatDependency_pdf = 'dvi,pdf'
"let g:Tex_FormatDependency_pdf = 'dvi,ps,pdf'
let g:Tex_FormatDependency_ps = 'dvi,ps'
let g:Tex_CompileRule_pdf = 'ptex2pdf -u -l -ot "-synctex=1 -interaction=nonstopmode -file-line-error-style" $*'
"let g:Tex_CompileRule_pdf = 'pdflatex -synctex=1 -interaction=nonstopmode -file-line-error-style $*'
"let g:Tex_CompileRule_pdf = 'lualatex -synctex=1 -interaction=nonstopmode -file-line-error-style $*'
"let g:Tex_CompileRule_pdf = 'luajitlatex -synctex=1 -interaction=nonstopmode -file-line-error-style $*'
""let g:Tex_CompileRule_pdf = 'xelatex -synctex=1 -interaction=nonstopmode -file-line-error-style $*'
"let g:Tex_CompileRule_pdf = 'ps2pdf $*.ps'
let g:Tex_CompileRule_ps = 'dvips -Ppdf -o $*.ps $*.dvi'
let g:Tex_CompileRule_dvi = 'uplatex -synctex=1 -interaction=nonstopmode -file-line-error-style $*'
let g:Tex_BibtexFlavor = 'upbibtex'
let g:Tex_MakeIndexFlavor = 'mendex -U $*.idx'
let g:Tex_UseEditorSettingInDVIViewer = 1
let g:Tex_ViewRule_pdf = 'xdg-open'
""let g:Tex_ViewRule_pdf = 'evince'
"let g:Tex_ViewRule_pdf = 'okular --unique'
"let g:Tex_ViewRule_pdf = 'zathura -s -x "vim --servername synctex -n --remote-silent +\%{line} \%{input}"'
"let g:Tex_ViewRule_pdf = 'qpdfview --unique'
""let g:Tex_ViewRule_pdf = 'texworks'
"let g:Tex_ViewRule_pdf = 'mupdf'
""let g:Tex_ViewRule_pdf = 'firefox -new-window'
"let g:Tex_ViewRule_pdf = 'chromium --new-window'plugin on
filetype indent on
set shellslash
set grepprg=grep\ -nH\ $*

" コンパイル時に使用するコマンド
let g:Tex_CompileRule_dvi = 'platex --interaction=nonstopmode $*' 
let g:Tex_BibtexFlavor = 'jbibtex'
let g:Tex_CompileRule_pdf = 'dvipdfmx $*.dvi'

" " ファイルのビューワー
let g:Tex_ViewRule_dvi = 'xdvi'
let g:Tex_ViewRule_pdf = 'evince'

let g:tex_flavor='latex'
