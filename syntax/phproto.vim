" Vim syntax file
" Language: phproto
" Maintainer: Sarkian <root@dustus.org>
" Last Change: 2013 Oct 16, 19:23

if version < 600
    syntax clear
elseif exists("b:current_syntax")
    "finish 
endif

syn sync fromstart

"{{{ Common

" Comments
syn region phprotoComment start='/\*' end='\*/'
syn region phprotoComment start='//' end="$"

" Strings
syn region phprotoString start=+"+ skip=+\\\\\|\\"+ end=+"+
syn region phprotoString start=+'+ skip=+\\\\\|\\'+ end=+'+

" Integer
syn match phprotoInt "[0-9]\+" contained

" Float
syn match phprotoFloat "[0-9]*\.[0-9]\+" contained

" Bool
syn case ignore
syn match phprotoBool "true\|false" contained

" Null
syn match phprotoNull "null" contained
syn case match

" void
syn keyword phprotoVoid contained void

" Variables
syn match phprotoVariable "$[a-zA-Z_][a-zA-Z0-9_]*" contained

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


"{{{ Определение класса
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
    \ contains=phprotoComment,phprotoClassUse,phprotoClassConstant,phprotoClassProperty,phprotoClassMethod
"}}}

"{{{ Директивы use
syn region phprotoClassUse start="use " end=";\|$" contained
    \ contains=phprotoClassUseKeyword,phprotoClassUseTraitname

" Ключевое слово "use"
syn keyword phprotoClassUseKeyword contained use

" Имя трейта
syn region phprotoClassUseTraitname start="\(use\s\+\)\@<=" end="[^a-zA-Z0-9]\@=" contained
"}}}

"{{{ Константа класса
syn region phprotoClassConstant start="const\s\+" end=";\|$" contained
    \ contains=phprotoClassConstantKeyword,phprotoClassConstantType,phprotoClassConstantName,phprotoClassConstantValue,phprotoComment

" Ключево слово "const"
syn keyword phprotoClassConstantKeyword contained const

" Тип константы класса
syn region phprotoClassConstantType start="\(const\s\+\)\@<=" end="[^a-zA-Z0-9]\@=" contained

" Имя константы класса
syn region phprotoClassConstantName start="\(const\s\+\i\+\s\+\)\@<=" end="[^a-zA-Z0-9_]\@=" contained

" Значение константы класса
syn region phprotoClassConstantValue start="\(=\s*\)\@<=" end=";\|\n\|$\@=" contained contains=phprotoString,phprotoInt,phprotoFloat,phprotoBool
"}}}

"{{{ Свойство класса
syn match phprotoClassProperty "\(var\|public\|protected\|private\|static\|readonly\)\s\+[^()]\+\(;\|$\)"
    \ contains=phprotoClassPropertyKeyword,phprotoClassPropertyType,phprotoClassPropertyName,phprotoVariable,phprotoClassPropertyValue,phprotoComment

" Ключевые слова "var, public, protected, private, static"
syn keyword phprotoClassPropertyKeyword contained var public protected private static readonly

" Тип свойства класса
syn match phprotoClassPropertyType "\s[a-zA-Z_\\][a-zA-Z0-9_\\\[\]]*\s\+\$"hs=s+1,he=e-2 contained contains=phprotoVariable

" Значение свойства класса
syn region phprotoClassPropertyValue start="\(\$\i\+\s*=\s*\)\@<=" end=";\|$" contained 
    \ contains=phprotoBool,phprotoInt,phprotoFloat,phprotoString,phprotoNull
"}}}

"{{{ Метод класса
"syn region phprotoClassMethod start="[a-zA-Z][a-zA-Z0-9\s\\\[\]]\+\s*(" end=";\|$" contained
syn match phprotoClassMethod "\(public\|protected\|private\|static\|final\|abstract\)\s\+[^()]\+([^()]*).*\(;\|$\)" contained
    \ contains=phprotoClassMethodKeyword,phprotoClassMethodDefinition,phprotoComment

" Ключевые слова "public, protected, private, static, final, abstract"
syn keyword phprotoClassMethodKeyword contained public protected private static final abstract nextgroup=phprotoClassMethodDefinition

" Определение метода класса без модификаторов (string myMethod())
syn match phprotoClassMethodDefinition "[a-zA-Z\\\[\]_]\+\s\+[a-zA-Z0-9_:\\]\+\s*([^()]*)" contained
    \ contains=phprotoClassMethodType,phprotoClassMethodNameAndArgs

" Тип метода класса
syn region phprotoClassMethodType start="\(\s\)\@<=" end="\s.*\(;\|$\)"me=s contained

" Имя метода и аргументы
syn match phprotoClassMethodNameAndArgs "[a-zA-Z_][a-zA-Z0-9_:\\]*\s*([^()]*)" contained
    \ contains=phprotoClassMethodName,phprotoClassMethodArgs

" Имя метода
syn match phprotoClassMethodName "[a-zA-Z_][a-zA-Z0-9_:\\]*" contained contains=phprotoClassMethodNamePN

" '::' в имени наследуемого метода
syn match phprotoClassMethodNamePN "::" contained

" Аргументы метода
syn region phprotoClassMethodArgs start="(" end=")" contained
    \ contains=phprotoClassMethodArgument,phprotoVoid

" Аргумент метода
syn match phprotoClassMethodArgument "[a-zA-Z0-9_\\\[\]]\+\s\+\$[a-zA-Z0-9_]\+" contained contains=phprotoClassMethodArgType,phprotoVariable
syn region phprotoClassMethodArgument start="[a-zA-Z0-9_\\\[\]]\+\s\+\$[a-zA-Z0-9_]\+\s*=\s*" end="\(,\|)\|]\)\@=" contained 
    \ contains=phprotoClassMethodArgType,phprotoVariable,phprotoString,phprotoInt,phprotoFloat,phprotoBool,phprotoNull

" Тип аргумента метода
syn region phprotoClassMethodArgTypeWrap start="\(,\s*\|(\s*\|(\s*\[\s*\)\@<=" end="\s\+\$"me=s contained contains=phprotoClassMethodArgType
syn match phprotoClassMethodArgType "[a-zA-Z][a-zA-Z0-9\\\[\]]\+" contained
"}}}

"{{{ Метод вне класса
"syn match phprotoMethod "^\s*\(public\|protected\|private\|static\|final\|abstract\)\s\+[a-zA-Z_\\][a-zA-Z0-9_\\:]*\s\+[a-zA-Z_\\][a-zA-Z0-9\_\\:]*\s*([^()]*).*\(;\|$\)"
syn match phprotoMethod "\(public\|protected\|private\|static\|final\|abstract\)\s\+[^()]\+([^()]*).*\(;\|$\)"
    \ contains=phprotoClassMethodKeyword,phprotoClassMethodDefinition,phprotoComment
"}}}

"{{{ Функции
syn match phprotoFunction "^\s*[a-zA-Z_\\][a-zA-Z0-9_\\:]*\s\+[a-zA-Z_\\][a-zA-Z0-9\_\\]*\s*([^()]*).*\(;\|$\)"
    \ contains=phprotoComment,phprotoFunctionType,phprotoClassMethodNameAndArgs

" Возвращаемый тип функции
syn region phprotoFunctionType start="\(^\s*\)\@<=" end="\s.*\(;\|$\)"me=s contained
"}}}


"hi phprotoFunction guifg=#ff0000

"hi phprotoClass             guifg=#000000
"hi phprotoClassDefinition   guifg=#ff0000   gui=bold
"hi phprotoClassBody         guifg=#0000ff
"hi phprotoClassMethod       guifg=#999999
"hi phprotoNamespace         guifg=#00ff00   gui=bold
"hi phprotoClassUse          guifg=#0000ff   gui=bold
"hi phprotoClassProperty     guifg=#ff0000   gui=italic
"hi phprotoClassMethodDefinition guifg=#000000 gui=italic
"hi phprotoClassMethodArgs   guifg=#00ff00   gui=italic

"{{{ Links

" Names
hi def link phprotoNamespaceName                    phprotoName
hi def link phprotoClassName                        phprotoName
hi def link phprotoClassImplementsInterfaceName     phprotoName
hi def link phprotoClassUseTraitname                phprotoName
hi def link phprotoClassConstantName                phprotoName
hi def link phprotoClassMethodName                  phprotoName

" Keywords
hi def link phprotoNamespaceKeyword                 phprotoKeyword
hi def link phprotoClassDefinitionKeyword           phprotoKeyword
hi def link phprotoClassUseKeyword                  phprotoKeyword
hi def link phprotoClassConstantKeyword             phprotoKeyword
hi def link phprotoClassPropertyKeyword             phprotoKeyword
hi def link phprotoClassMethodKeyword               phprotoKeyword

" Types
hi def link phprotoClassConstantType                phprotoType
hi def link phprotoClassPropertyType                phprotoType
hi def link phprotoClassMethodType                  phprotoType
hi def link phprotoClassMethodArgType               phprotoType
hi def link phprotoFunctionType                     phprotoType

"}}}

"{{{ Colorscheme

hi phprotoComment       guifg=#d75f00   gui=none
hi phprotoString        guifg=#5faf00   gui=none
hi phprotoInt           guifg=#5faf5f   gui=none
hi phprotoFloat         guifg=#875fff   gui=none
hi phprotoBool          guifg=#5faf5f   gui=italic
hi phprotoNull          guifg=#cdcdcd   gui=italic
hi phprotoVoid          guifg=#a0a0a0   gui=none
hi phprotoName          guifg=#799aff   gui=none
hi phprotoKeyword       guifg=#dadada   gui=none
hi phprotoType          guifg=#5fd75f   gui=none
hi phprotoVariable      guifg=#d75f5f   gui=none

" }}}

let b:current_syntax = 'phproto'

" vim:foldmethod=marker
