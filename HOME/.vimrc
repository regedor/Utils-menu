filetype on  " Automatically detect file types.
set nocompatible  " We don't want vi compatibility.
 
" Add recently accessed projects menu (project plugin)
set viminfo^=!
 
" Minibuffer Explorer Settings
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1
 
" alt+n or alt+p to navigate between entries in QuickFix
map <silent> <m-p> :cp <cr>
map <silent> <m-n> :cn <cr>
 
" Change which file opens after executing :Rails command
let g:rails_default_file='config/database.yml'
 
syntax enable

set number                   
set encoding=utf-8 fenc=utf-8
set guioptions-=T 
" colors slate
filetype plugin indent on    

map <silent> <F5>    :bprev                               <CR>
map <silent> <F6>    :bnext                               <CR>
map <silent> <F7>    :setlocal spell spelllang=en_gb      <CR>
map <silent> <F8>    :setlocal spell spelllang=pt         <CR>
map <silent> <C-t>   :tabnew .                            <CR>
map <silent> <C-\>   :tabnext                             <CR>
" map <silent> <C-tab> :tabnext                             <CR>
nnoremap <F3> :w                                          <CR>
nnoremap <F4> :quit                                       <CR>
nnoremap <C-O> :NERDTreeToggle \| exe "vertical resize".20<CR>
nnoremap <silent> + :exe "resize " . (winheight(0) * 3/2) <CR>
nnoremap <silent> - :exe "resize " . (winheight(0) * 2/3) <CR>


imap <silent><F2> <Esc>v`^me<Esc>gi<C-o>:call Ender()<CR>
function Ender()
  let endchar = nr2char(getchar())
  execute "normal \<End>a".endchar
  normal `e
endfunction

" Backups & Files
set backup                   " Enable creation of backup file.
set backupdir=~/.vim/backups " Where backups will go.
set directory=~/.vim/tmp     " Where temporary files will go.
let g:proj_flags="imstvcg"
