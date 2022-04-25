syntax on
source ~/.vim/cscope_maps.vim
set modelines=1

let tlist_objc_settings = 'ObjectiveC;P:protocols;i:interfaces;I:implementation;M:ppmacro;types(...);m:Objectmethod;c:Classmethod;v:Global;F:ObjectField;f:function;p:property;t:typealias;s:structure;e:enumeration'

" set autoindent

set wrap
set linebreak
set nolist  " list disables linebreak
set textwidth=0
set wrapmargin=0

cmap w!! w !sudo tee >/dev/null %

