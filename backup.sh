rsync -vmrc $1 --filter=". rsync-filter" ~/.emacs.d/ ~/Desktop/my-emacs/site-lisp/ 
cp -v ~/.emacs ~/Desktop/my-emacs/