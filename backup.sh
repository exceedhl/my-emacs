rsync -vmrc $1 --filter=". rsync-filter" ~/.emacs.d/ ~/Desktop/my-emacs/site-lisp/ 
rsync -vc $1 ~/.emacs ~/Desktop/my-emacs/.emacs