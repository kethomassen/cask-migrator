#!/bin/bash

forcing=false
remove=false

searchdir="/Applications"
installdir="/Applications"

while getopts ":d:id:fhr" opt; do
    case ${opt} in
        h|:|\? )
            echo "Options"
            echo "  -f          Don't ask for confirmation for each application (Probably a bad idea)."
            echo "  -r          Permanently remove old applications. By default just moves to trash"
            echo "  -d [dir]    Search directory for .app files. Default: /Applications" 
            echo "  -id [dir]   Install directory for cask. Default: /Applications"
            echo "  -h          Print this help message and exit."
            exit 0
            ;;
        f )
            forcing=true
            ;;
        r )
            remove=true
            ;;
        d )
            dir=$OPTARG
            ;;
        id )
            installdir=$OPTARG
            ;;
    esac
done
shift $(( OPTIND - 1))

# store list of installed casks for fast access
installed=$(brew cask list)

for filename in $searchdir/*.app; do
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

    # ask for confirmation if not in force mode
    if ! $forcing; then
        read -p "Able to re-install $filename as $appname via cask. Proceed? (Y/N) " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            continue
        fi
    fi

    echo "Installing $appname..."
    if $remove; then
        rm $filename
    else
        mv $filename ~/.Trash
    fi

    brew cask install $appname --appdir=$installdir

done
