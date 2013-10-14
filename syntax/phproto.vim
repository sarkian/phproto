syn clear

syn keyword phprotoKeyword public protected private static const abstract final class trait function extends implements

syn region phprotoComment start='/\*' end='\*/'
syn region phprotoComment start='//' end='\n'
syn region phprotoString start=+"+ skip=+\\\\\|\\"+ end=+"+

syn region phprotoConstant start="\(const \i* \)\@<=" end="[^a-zA-Z0-9]\@="

syn region phprotoTypename start="\(const \|public \|static \|protected \|protected \|final \|abstract \)\@<=" end="[^a-zA-Z0-9]\@="
"syn region phprotoTypename start="\(\i* \)" end="\( \i*(\)\@="

syn match phprotoFunction "[a-zA-Z][a-z-A-Z0-9]*\s*("

hi phprotoKeyword       guifg=#dadada   gui=bold
hi phprotoComment       guifg=#d75f00   gui=none
hi phprotoTypename      guifg=#5fd75f   gui=none
hi phprotoString        guifg=#5faf00   gui=none
hi phprotoConstant      guifg=#799aff   gui=none
hi phprotoFunction      guifg=#799aff   gui=none

hi phprotoTest          guifg=#ff0000   gui=bold

echo 'ok'
