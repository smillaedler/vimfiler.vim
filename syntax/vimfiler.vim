"=============================================================================
" FILE: syntax/vimfiler.vim
" AUTHOR: Shougo Matsushita <Shougo.Matsu@gmail.com>
" Last Modified: 03 Feb 2013.
" License: MIT license  {{{
"     Permission is hereby granted, free of charge, to any person obtaining
"     a copy of this software and associated documentation files (the
"     "Software"), to deal in the Software without restriction, including
"     without limitation the rights to use, copy, modify, merge, publish,
"     distribute, sublicense, and/or sell copies of the Software, and to
"     permit persons to whom the Software is furnished to do so, subject to
"     the following conditions:
"
"     The above copyright notice and this permission notice shall be included
"     in all copies or substantial portions of the Software.
"
"     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
"     OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
"     MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
"     IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
"     CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
"     TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
"     SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
" }}}
"=============================================================================

if version < 700
  syntax clear
elseif exists('b:current_syntax')
  finish
endif

syntax match   vimfilerNonMarkedFile     '.*'
      \ contains=vimfilerNonMark,vimfilerTypeText,vimfilerTypeImage,
      \vimfilerTypeArchive,vimfilerTypeExecute,vimfilerTypeMultimedia,
      \vimfilerTypeDirectory,vimfilerTypeSystem,vimfilerTypeLink,
      \vimfilerSize,vimfilerDate,vimfilerDateToday,vimfilerDateWeek

syntax match   vimfilerDirectory         '^..$'

syntax match   vimfilerPrompt            '^\[in\]: .*$'
      \ contains=vimfilerSpecial,vimfilerCurrentDirectory
syntax match   vimfilerPromptUnSafe        '^! \[in\]: .*$'
      \ contains=vimfilerSpecial,vimfilerSpecialUnSafe,vimfilerCurrentDirectory
syntax match   vimfilerSpecialUnSafe       '^! ' contained
syntax match   vimfilerSpecial           '\[in\]:' contained
syntax match   vimfilerCurrentDirectory  '\s\zs.*$' contained contains=vimfilerMask
syntax match   vimfilerMask  '\[.*\]$' contained
syntax match   vimfilerFileLine          '\[.*\]$' contained

syntax match   vimfilerTypeText          '.*\[T\]' contained
syntax match   vimfilerTypeText          '.* \~$' contained contains=vimfilerMarker
syntax match   vimfilerTypeImage         '.*\[I\]' contained
syntax match   vimfilerTypeImage         '.* !$' contained contains=vimfilerMarker
syntax match   vimfilerTypeArchive       '.*\[A\]' contained
syntax match   vimfilerTypeArchive       '.* @$' contained contains=vimfilerMarker
syntax match   vimfilerTypeExecute       '.*\[X\]' contained
syntax match   vimfilerTypeExecute       '.* #$' contained contains=vimfilerMarker
syntax match   vimfilerTypeMultimedia    '.*\[M\]' contained
syntax match   vimfilerTypeMultimedia    '.* \$$' contained contains=vimfilerMarker
syntax match   vimfilerTypeDirectory     '.*\[D\]' contained
syntax match   vimfilerTypeDirectory     '.* %$' contained contains=vimfilerMarker
syntax match   vimfilerTypeSystem        '.*\[S\]' contained
syntax match   vimfilerTypeSystem        '.* \^$' contained contains=vimfilerMarker
syntax match   vimfilerTypeLink          '.*\[L\]' contained
syntax match   vimfilerTypeLink          '.* &$' contained contains=vimfilerMarker

syntax match   vimfilerSize              '\s\zs[[:digit:].]\+\s*[GMKB]' contained

syntax match   vimfilerDate              '\s\zs#[^#]\+$' contains=vimfilerDateIgnore contained
syntax match   vimfilerDateToday         '\s\zs\~[^~]\+$' contains=vimfilerDateIgnore contained
syntax match   vimfilerDateWeek          '\s\zs![^!]\+$' contains=vimfilerDateIgnore contained
if has('conceal')
  " Supported conceal features.
  syntax match   vimfilerDateIgnore        '[#~!]' contained conceal
  syntax match   vimfilerMarker        '[~!@#$%^&]$' contained conceal
else
  syntax match   vimfilerMarker        '[~!@#$%^&]$' contained
endif

syntax match vimfilerColumnPrompt /^Columns:/

" Initialize icon patterns."{{{
let s:leaf_icon = vimfiler#util#escape_pattern(
      \ g:vimfiler_tree_leaf_icon)
let s:opened_icon = vimfiler#util#escape_pattern(
      \ g:vimfiler_tree_opened_icon)
let s:closed_icon = vimfiler#util#escape_pattern(
      \ g:vimfiler_tree_closed_icon)
let s:ro_file_icon = vimfiler#util#escape_pattern(
      \ g:vimfiler_readonly_file_icon)
let s:file_icon = vimfiler#util#escape_pattern(
      \ g:vimfiler_file_icon)
let s:marked_file_icon = vimfiler#util#escape_pattern(
      \ g:vimfiler_marked_file_icon)

execute 'syntax match   vimfilerMarkedFile'
      \ '''^\s*\%('  . s:leaf_icon .'\)\?'
      \ . s:marked_file_icon . ' .*$'''
      \ 'contains=vimfilerDate,vimfilerDateToday,vimfilerDateWeek'
execute 'syntax match   vimfilerNonMark'
      \ '''^\s*\%('.s:leaf_icon.'\)\?\%('.s:opened_icon.'\|'
      \ .s:closed_icon.'\|'.s:ro_file_icon.'\|'.s:file_icon.'\)'' contained'

unlet s:opened_icon
unlet s:closed_icon
unlet s:ro_file_icon
unlet s:file_icon
unlet s:marked_file_icon
"}}}

highlight def link vimfilerCurrentDirectory Identifier
highlight def link vimfilerMask Statement

highlight def link vimfilerSpecial Special
highlight def link vimfilerSpecialUnSafe Statement

highlight def link vimfilerNonMark Special
highlight def link vimfilerMarkedFile Type
highlight def link vimfilerDirectory Preproc
highlight def link vimfilerSize Constant

highlight def link vimfilerDateToday Statement
highlight def link vimfilerDateWeek Special
highlight def link vimfilerDate Identifier
highlight def link vimfilerDateIgnore Ignore

highlight def link vimfilerTypeText Constant
highlight def link vimfilerTypeImage Type
highlight def link vimfilerTypeArchive Special
highlight def link vimfilerTypeExecute Statement
highlight def link vimfilerTypeMultimedia Identifier
highlight def link vimfilerTypeDirectory Preproc
highlight def link vimfilerTypeSystem Comment
highlight def link vimfilerTypeLink Comment

highlight default link vimfilerColumnPrompt  Statement

let b:current_syntax = 'vimfiler'

" vim: foldmethod=marker
