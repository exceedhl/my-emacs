rsync -vmrc $1 --filter=". rsync-filter" ~/.emacs.d/ ~/code/my-emacs/site-lisp/ 
rsync -vc $1 ~/.emacs ~/code/my-emacs/.emacs
