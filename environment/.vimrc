""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim config dongjin.ydj  
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" 显示行号
set nu

" 语法高亮
syntax on

" 设置魔术
set magic

" 打开状态栏标尺
set ruler

" Tab键的宽度
set tabstop=4

" 统一缩进为4
set softtabstop=4
set shiftwidth=4

" 光标移动到buffer的顶部和底部时保持3行距离
set scrolloff=3

" 输入的命令显示出来,看的清楚些
set showcmd

" 不要用空格代替制表符
set expandtab
set ts=4

" 不要使用vi的键盘模式,而是vim自己的
set nocompatible

"搜索忽略大小写
set ignorecase

"搜索逐字符高亮
set hlsearch
set incsearch

"状态行显示的内容
set statusline=%F%m%r%h%w\ [%{&ff}]\ [%Y]\ [%l,%v\ %p%%]

" 总是显示状态行
set laststatus=2
set cmdheight=2

" 隐藏工具栏 菜单栏
set guioptions-=T
set guioptions-=m

" 显示中文帮助
if version >= 603
    set helplang=cn
    set encoding=utf-8
endif

" 设置配色方案
"colorscheme murphy

"字体 
if (has("gui_running")) 
    set guifont=Bitstream\ Vera\ Sans\ Mono\ 10 
endif 
set enc=utf-8
set fencs=utf-8,ucs-bom,shift-jis,gb18030,gbk,gb2312,cp936
set termencoding=utf-8
set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936
set termencoding=utf-8
set encoding=utf-8
set langmenu=zh_CN.UTF-8
set helplang=cn

" 侦测文件类型
filetype on
filetype plugin on
filetype plugin indent on

" 高亮显示匹配的括号
set showmatch
set matchtime=1

"代码补全 
set completeopt=preview,menu 

"允许插件  
filetype plugin on

"共享剪贴板  
set clipboard+=unnamed 

" quickfix模式
autocmd FileType c,cpp map <buffer> <leader><space> :w<cr>:make<cr>

"自动补全
:inoremap ( ()<ESC>i
:inoremap ) <c-r>=ClosePair(')')<CR>
:inoremap { {}<ESC>i
:inoremap } <c-r>=ClosePair('}')<CR>
:inoremap [ []<ESC>i
:inoremap ] <c-r>=ClosePair(']')<CR>
:inoremap " ""<ESC>i
:inoremap ' ''<ESC>i
function! ClosePair(char)
    if getline('.')[col('.') - 1] == a:char
        return "\<Right>"
    else
        return a:char
    endif
endfunction

"新建.c,.h,.sh,.java文件，自动插入文件头 
autocmd BufNewFile *.cpp,*.[ch],*.sh,*.java,*py exec ":call SetTitle()"
"定义函数SetTitle，自动插入文件头 
func SetTitle() 
    "如果文件类型为.sh文件  
    if &filetype == 'sh'
        call setline(1,"\#########################################################################")    
        call append(line("."), "\# File Name: ".expand("%"))   
        call append(line(".")+1, "\# Author: dongjin.ydj")   
        call append(line(".")+2, "\# mail: yudongjin@os.ucweb.com") 
        call append(line(".")+3, "\# Created Time: ".strftime("%c")) 
        call append(line(".")+4, "\#########################################################################") 
        call append(line(".")+5, "\#!/bin/bash")
        call append(line(".")+6, "") 
    endif
    if &filetype == 'python'
        call setline(1,"\#!/usr/bin/env python")
        call append(line("."), "\#coding=utf-8")
        call append(line(".")+1, "'''")
        call append(line(".")+2, "File Name: ".expand("%"))
        call append(line(".")+3, "Author: dongjin.ydj")
        call append(line(".")+4, "mail: yudongjin@os.ucweb.com")
        call append(line(".")+5, "Created Time: ".strftime("%c"))
        call append(line(".")+6, "'''")
        call append(line(".")+7, "")
    endif
    if &filetype == 'cpp'
        call setline(1, "/*************************************************************************")
        call append(line("."), "*    File Name: ".expand("%"))
        call append(line(".")+1, "*    Author: dongjin.ydj")
        call append(line(".")+2, "*    Mail: yudongjin@os.ucweb.com")
        call append(line(".")+3, "*    Created Time: ".strftime("%c"))
        call append(line(".")+4, " ************************************************************************/")
        call append(line(".")+5, "")
        call append(line(".")+6, "#include<iostream>")
        call append(line(".")+7, "using namespace std;")
        call append(line(".")+8, "")
    endif
    if &filetype == 'c'
        call setline(1, "/*************************************************************************")
        call append(line("."), "*    File Name: ".expand("%"))
        call append(line(".")+1, "*    Author: dongjin.ydj")
        call append(line(".")+2, "*    Mail: yudongjin@os.ucweb.com")
        call append(line(".")+3, "*    Created Time: ".strftime("%c"))
        call append(line(".")+4, " ************************************************************************/")
        call append(line(".")+5, "")
        call append(line(".")+6, "#include<stdio.h>")
        call append(line(".")+7, "")
    endif
    "新建文件后，自动定位到文件末尾
    autocmd BufNewFile * normal G
endfunc

"C,C++,java,python,sh 按F5编译运行
map <F5> :call CompileRunGcc()<CR>
func! CompileRunGcc()
    exec "w"
    if &filetype == 'c'
        exec "!g++ % -o %<"
        exec "! ./%<"
    elseif &filetype == 'cpp'
        exec "!g++ % -o %<"
        exec "! ./%<"
    elseif &filetype == 'java' 
        exec "!javac %" 
        exec "!java %<"
    elseif &filetype == 'python' 
        exec "!python %"
    elseif &filetype == 'sh'
        :!./%
    endif
endfunc

"C,C++的调试
map <F8> :call Rungdb()<CR>
func! Rungdb()
    exec "w"
    exec "!g++ % -g -o %<"
    exec "!gdb ./%<"
endfunc
