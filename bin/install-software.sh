#!/bin/bash

show_help () {
    cat <<EOF
This script using to install some require softwares.

options:
        -a, --all            install all default software.
EOF
}

while [ $# -gt 0 ] 
do
    case '$1' in
        -h|--help)
            show_help
            exit 0
            ;;

        -a|--all)
            export INSTALL_ALL = "True"
            shift
            ;;

        *)
            echo "wrong options " + $1
            show_help
            exit 1
            ;;
    esac
done

isInstalled () {
    if hash "$1" 2>/dev/null; then
        echo 1;
    else
        echo 0;
    fi
}

# install emacs 24
install_latest_emacs () {
    sudo add-apt-repository ppa:cassou/emacs
    sudo apt-get update

    sudo apt-get install emacs24
}

#install leiningen
install_lein () {
    if [ ! $(isInstalled "lein") ]; then
        echo "installing leiningen"

        wget -P ~/bin https://raw.github.com/technomancy/leiningen/stable/bin/lein
        chmod a+x ~/bin/lein
        ~/bin/lein
    fi
}

# install require software
if [ INSTALL_ALL ]; then

    sudo apt-get install tmux

    install_latest_emacs

    install_lein
fi
