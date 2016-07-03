"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim syntax file
"
" Language: javascript.jsx
" Maintainer: MaxMellon <maxmellon1994@gmail.com>
" Depends: othree/yajs.vim
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let s:xml_cpo_save = &cpo
set cpo&vim

syntax case match

if exists('b:current_syntax')
  let s:current_syntax = b:current_syntax
  unlet b:current_syntax
endif

if exists('s:current_syntax')
  let b:current_syntax = s:current_syntax
endif

syntax region jsxRegion
      \ start=+<\z([^ /!?<>"']\+\)+
      \ skip=+<!--\_.\{-}-->+
      \ end=+</\z1\_\s\{-}[^(=>)]>+
      \ fold
      \ contains=jsxTag,jsxCloseTag,jsxRegion,jsxComment,jsxEscapeJs,@Spell
      \ keepend
      \ extend

" <tag id="sample">
" s~~~~~~~~~~~~~~~e
syntax region jsxTag
      \ start=+<[^ /!?<>"']\@=+
      \ end=+>+
      \ contained
      \ contains=jsxError,jsxTagName,jsxAttrib,jsxEqual,jsxString,jsxEscapeJs

" </tag>
" ~~~~~~
syntax match jsxCloseTag
      \ +</[^ /!?<>"']\+>+
      \ contained
      \ contains=jsxNamespace,jsxAttribPunct

" <!-- -->
" ~~~~~~~~
syntax match jsxComment /<!--\_.\{-}-->/ display

syntax match jsxEntity "&[^; \t]*;" contains=jsxEntityPunct
syntax match jsxEntityPunct contained "[&.;]"

" <tag key={this.props.key}>
"  ~~~
syntax match jsxTagName
    \ +[<]\@<=[^ /!?<>"']\++
    \ contained
    \ contains=jsxNamespace,jsxTagHook
    \ display

" <tag:hoge key={this.props.key}>
"      ~~~~
syntax match jsxNamespace
    \ +\(<\|</\)\@<=[^ /!?<>"':]\+[:]\@=+
    \ contained
    \ display

" <tag key={this.props.key}>
"      ~~~
syntax match jsxAttrib
    \ +[-'"<]\@<!\<[a-zA-Z:_][-.0-9a-zA-Z0-9:_]*\>\(['">]\@!\|$\)+
    \ contained
    \ contains=jsxAttribPunct,jsxAttribHook
    \ display

syntax match jsxAttribPunct +[:.]+ contained display

" <tag id="sample">
"        ~
syntax match jsxEqual +=+ display

" <tag id="sample">
"         s~~~~~~e
syntax region jsxString contained start=+"+ end=+"+ contains=jsxEntity,@Spell display

" <tag id='sample'>
"         s~~~~~~e
syntax region jsxString contained start=+'+ end=+'+ contains=jsxEntity,@Spell display

" <tag key={this.props.key}>
"          s~~~~~~~~~~~~~~e
syntax region jsxEscapeJs
    \ contained
    \ contains=javascriptIdentifier,javascriptTemplate,javascriptArrowFunc
    \ matchgroup=jsxCloseTag end=+>+
    \ start=+{+
    \ end=+}+

syntax cluster jsExpression add=jsxRegion
syntax cluster javascriptNoReserved add=jsxRegion

highlight def link jsxTag Function
highlight def link jsxTagName Function
highlight def link jsxString String
highlight def link jsxNameSpace Function
highlight def link jsxComment Error
highlight def link jsxAttrib Type
highlight def link jsxEscapeJs jsxEscapeJs
highlight def link jsxCloseTag Identifier

let b:current_syntax = 'javascript.jsx'

let &cpo = s:xml_cpo_save
unlet s:xml_cpo_save
