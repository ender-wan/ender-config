#! /bin/bash

# install emacs 24
sudo add-apt-repository ppa:cassou/emacs
sudo apt-get update

# install require software
sudo apt-get install emacs24 tmux

#install leiningen
wget -P ~/bin https://raw.github.com/technomancy/leiningen/stable/bin/lein
chmod a+x ~/bin/lein
~/bin/lein

