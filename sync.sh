rsync -vmrc $1 --filter=". rsync-filter" ~/Desktop/my-emacs/site-lisp/ ~/.emacs.d/
cp -v ~/Desktop/my-emacs/.emacs ~