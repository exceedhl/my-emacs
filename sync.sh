rsync -vmrc $1 --filter=". rsync-filter" ~/Desktop/my-emacs/site-lisp/ ~/.emacs.d/
rsync -vc $1 ~/Desktop/my-emacs/.emacs ~/.emacs