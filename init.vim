" Install vim-plug plugin manager if not installed
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" List plugins to be loaded
call plug#begin('~/.vim/plugged')
Plug 'knubie/vim-kitty-navigator'
call plug#end()
 
" Personalised settings
set hidden			" Possibility to have more than one unsaved buffers.
set nu rnu			" Line numbering - relative numbering
