rsync -vmrc $1 --filter=". rsync-filter" ~/code/my-emacs/site-lisp/ ~/.emacs.d/
rsync -vc $1 ~/code/my-emacs/.emacs ~/.emacs
