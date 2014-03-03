#! /bin/bash

# install emacs 24
sudo add-apt-repository ppa:cassou/emacs
sudo apt-get update
sudo apt-get install emacs24

#install leiningen
wget -P ~/bin https://raw.github.com/technomancy/leiningen/stable/bin/lein
chmod a+x ~/bin/lein
