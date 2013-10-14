"{{{ Hieararchy
"   phprotoNamespace
"       phprotoNamespaceKeyword
"       phprotoNamespaceName
"   phprotoClass
"       phprotoClassDefinition
"           phprotoClassDefinitionKeyword (*phprotoKeyword)
"           phprotoClassName (*phprotoName)
"           phprotoClassImplements
"               phprotoClassImplementsInterfaceName (*phprotoName)
"       phprotoClassBody
"           phprotoMethod
"}}}

"{{{ Init
if !exists("main_syntax")
    if version < 600
        syntax clear
    elseif exists("b:current_syntax")
        "finish
        syntax clear
    endif
    let main_syntax='phproto'
endif
let s:cpo_save = &cpo
set cpo&vim
"}}}

"{{{ Комментарии, строки и числа

" Комментарии
syn region phprotoComment start='/\*' end='\*/'
syn region phprotoComment start='//' end="$"

" Строки
syn region phprotoString start=+"+ skip=+\\\\\|\\"+ end=+"+

" Integer
syn match phprotoInt "[0-9]\+" contained

" Float
syn match phprotoFloat "[0-9]*\.[0-9]\+" contained

" Bool
syn case ignore
syn match phprotoBool "true\|false" contained
syn case match

"}}}

"{{{ Namespaces

" Определение пространства имён
syn region phprotoNamespace start="namespace " end=";\|$"
    \ contains=phprotoNamespaceKeyword,phprotoNamespaceName

" Ключевое слово "namespace"
syn keyword phprotoNamespaceKeyword contained namespace

" Имя пространства имён
syn region phprotoNamespaceName start="\(namespace\s\+\)\@<=" end="[^a-zA-Z0-9\\_]\@=" contained

"}}}


" Определение класса полностью
syn region phprotoClass start="\(class\s\+\|abstract\s\+class\s\+\|final\s\+class\s\+\)" end="}"
    \ contains=phprotoClassDefinition,phprotoClassBody

" Определение класса, исключая тело
syn region phprotoClassDefinition start="\(class\s\+\|abstract\s\+class\s\+\|final\s\+class\s\+\)" end="{\@=" contained
    \ contains=phprotoComment,phprotoClassName,phprotoClassImplements,phprotoClassDefinitionKeyword

" Ключевые слова в определении класса
syn keyword phprotoClassDefinitionKeyword contained class final abstract implements extends

" Имена классов в определении
syn region phprotoClassName start="\(class\s\+\|extends\s\+\)\@<=" end="[^a-zA-Z0-9]\@=" contained

" Интерфесы в определении
syn region phprotoClassImplements start="\(implements\s\+\)\@<=" end="{\@=" contained
    \ contains=phprotoComment,phprotoClassImplementsInterfaceName

" Имена интерфейсов в определении
syn match phprotoClassImplementsInterfaceName "[a-zA-Z][a-zA-Z0-9_\\]\+" contained

" Тело класса
syn region phprotoClassBody start="\({\)\@<=" end="}\@=" contained
    \ contains=phprotoComment,phprotoMethod,phprotoClassUse,phprotoClassConstant

" Директивы use
syn region phprotoClassUse start="use " end=";\|$" contained
    \ contains=phprotoClassUseKeyword,phprotoClassUseTraitname

" Ключевое слово "use"
syn keyword phprotoClassUseKeyword contained use

" Имя трейта
syn region phprotoClassUseTraitname start="\(use\s\+\)\@<=" end="[^a-zA-Z0-9]\@=" contained

" Константа класса
syn region phprotoClassConstant start="const\s\+" end=";\|$" contained
    \ contains=phprotoClassConstantKeyword,phprotoClassConstantType,phprotoClassConstantName,phprotoClassConstantValue,phprotoComment

" Ключево слово "const"
syn keyword phprotoClassConstantKeyword contained const

" Тип константы класса
syn region phprotoClassConstantType start="\(const\s\+\)\@<=" end="[^a-zA-Z0-9]\@=" contained

" Имя константы класса
syn region phprotoClassConstantName start="\(const\s\+\i\+\s\+\)\@<=" end="[^a-zA-Z0-9_]\@=" contained

" Значение константы класса
syn region phprotoClassConstantValue start="\(=\s*\)\@<=" end=";\|\n\|$\@=" contains=phprotoString,phprotoInt,phprotoFloat,phprotoBool

" Метод
syn region phprotoMethod start="[a-zA-Z][a-zA-Z0-9 ]\+(" end=")" contained



"syn region phprotoConstant start="\(const \i* \)\@<=" end="[^a-zA-Z0-9]\@="
"syn region phprotoTypename start="\(const \|public \|static \|protected \|protected \|final \|abstract \)\@<=" end="[^a-zA-Z0-9]\@=" 
"syn region phprotoTypename start="\(\i* \)" end="\(\i*()\)\@="

"hi phprotoKeyword       guifg=#dadada   gui=bold
"hi phprotoTypename      guifg=#5fd75f   gui=none
"hi phprotoString        guifg=#5faf00   gui=none
"hi phprotoConstant      guifg=#799aff   gui=none
"hi phprotoFunction      guifg=#799aff   gui=none

hi phprotoClass             guifg=#000000
hi phprotoClassDefinition   guifg=#ff0000   gui=bold
hi phprotoClassBody         guifg=#0000ff
hi phprotoMethod            guifg=#999999
hi phprotoNamespace         guifg=#00ff00   gui=bold
hi phprotoClassUse          guifg=#0000ff   gui=bold
hi phprotoClassConstant     guifg=#ffffff   gui=italic

"{{{ Init
let b:current_syntax = "phproto"
if main_syntax == 'phproto'
    unlet main_syntax
endif
let b:spell_options="contained"
let &cpo = s:cpo_save
unlet s:cpo_save
"}}}

"{{{ Обобщения

" Имена
hi def link phprotoNamespaceName                    phprotoName
hi def link phprotoClassName                        phprotoName
hi def link phprotoClassImplementsInterfaceName     phprotoName
hi def link phprotoClassUseTraitname                phprotoName
hi def link phprotoClassConstantName                phprotoName

" Ключевые слова
hi def link phprotoNamespaceKeyword                 phprotoKeyword
hi def link phprotoClassDefinitionKeyword           phprotoKeyword
hi def link phprotoClassUseKeyword                  phprotoKeyword
hi def link phprotoClassConstantKeyword             phprotoKeyword

" Типы
hi def link phprotoClassConstantType                phprotoType

"}}}


"{{{ Цветовая схема

hi phprotoComment       guifg=#d75f00   gui=none
hi phprotoString        guifg=#5faf00   gui=none
hi phprotoInt           guifg=#5faf5f   gui=none
hi phprotoFloat         guifg=#875fff   gui=none
hi phprotoBool          guifg=#d75f5f   gui=none
hi phprotoName          guifg=#799aff   gui=none
hi phprotoKeyword       guifg=#dadada   gui=none
hi phprotoType          guifg=#5fd75f   gui=none

" }}}

" vim:foldmethod=marker
