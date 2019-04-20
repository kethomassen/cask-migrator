#!/bin/bash

# store list of installed casks for fast access
installed=$(brew cask list)

for filename in /Applications/*.app; do
    # extract appname from filename
    appname="$(basename "$filename" .app | tr '[:upper:]' '[:lower:]' | tr ' ' '-')"

    # check if already installed by cask
    echo $installed | grep $appname &> /dev/null
    if [ $? == 0 ]; then
        echo "$appname already installed by cask"
        continue
    fi

    # check if cask is available to install
    brew cask info $appname &> /dev/null
    if [ $? != 0 ]; then
        continue
    fi

    # ask if they want to use it
    read -p "Able to re-install $filename as $appname via cask. Proceed? (Y/N) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        echo "installing $appname ..."
    
        mv $filename ~/.Trash
        brew cask install $appname
    fi



done
