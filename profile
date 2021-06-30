# Recommended packages:
# ripgrep rlwrap

#
# General settings
#

if [ "$(uname -s)" = "Linux" ] || [ "$(uname -s)" = "Darwin" ]; then
    ###
    ### Linux/macOS-specific settings
    ###

    export PATH="$HOME/Git/scripts:$HOME/bin:$PATH"
    export PYENV_ROOT="$HOME/.pyenv"
    export PYENV_VERSION="3.9.1"
    export REPO="$HOME/Git/plex-media-server"
    export XML_CATALOG_FILES="/usr/local/etc/xml/catalog"
    export ZSH_THEME="dst"

    export LOG_PMS="$HOME/Library/Logs/Plex Media Server/Plex Media Server.log"
    export LOG_PMS_TEST="$HOME/Library/Logs/Plex Media Server/Plex Media Server Tests.log"

    if [ "$(uname -s)" = "Linux" ]; then
        ###
        ### Linux-specific settings
        ###
        function sqlite_pms() {
            rlwrap ~/Git/plex-media-server/build/build/Plex\ Media\ Server --sqlite ~/Library/Application\ Support/Plex\ Media\ Server/Plug-in\ Support/Databases/com.plexapp.plugins.library.db
        }
    else
        ###
        ### macOS-specific settings
        ###
        export PATH="/Applications/kdiff3.app/Contents/MacOS:$PATH"
        export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
        function sqlite_pms() {
            rlwrap ~/Git/plex-media-server/build/Plex\ Media\ Server.app/Contents/MacOS/Plex\ Media\ Server sqlite ~/Library/Application\ Support/Plex\ Media\ Server/Plug-in\ Support/Databases/com.plexapp.plugins.library.db
        }
    fi
else
    ###
    ###  Win-specific settings
    ###
    #
    # Open the directory passed to open
    #
    unalias open 2>/dev/null
    function open {
        for i in $@; do
            if [ ! -d $i ]; then
                i=$(dirname $i)
            fi
            DIR=$(echo "$i" | sed 's,/,\\,g')
            echo "Opening $DIR..."
            explorer $DIR
        done
    }
fi

#
# Create source code for sqlite tables
#
function sql_format() {
    sed s/\"/\'/g | tr '\n' ' ' | sed -E "s/[[:space:]]+/ /g"
}

#
# Find in the files except under .git
#
unalias gall 2>/dev/null
function gall {
    find . -not -path "*/.git/*" -type f -exec grep --color=auto "$@" {} +
}

#
# Find in the source files
#
unalias gcl 2>/dev/null
function gcl {
    find . -not -path "*/.git/*" -type f \( -name '*.c' -o -name '*.cpp' -o -name '*.m' -o -name '*.mm' \) -exec grep --color=auto "$@" {} +
}

#
# Find in the header files
#
unalias ghl 2>/dev/null
function ghl {
    find . -not -path "*/.git/*" -type f \( -name '*.h' -o -name '*.hh' -o -name '*.hpp' \) -exec grep --color=auto "$@" {} +
}

#
# Find in the scripts
#
unalias gcmd 2>/dev/null
function gcmd {
    find . -not -path "*/.git/*" -type f \( -name '*.cmd' \) -exec grep --color=auto "$@" {} +
}

#
# Find in the logs
#
unalis glog 2>/dev/null
function glog {
    find "$HOME/Library/Logs/Plex Media Server" -type f -exec grep --color=auto "$@" {} +
}

#
# Update the branch with recent origin/develop commits
#
unalias rb 2>/dev/null
function rb {
    git fetch && git rebase origin/master
}

#
# Remove the current local and remote branch
#
unalias close-branch 2>/dev/null
function close-branch {
    echo "The following local branches will be deleted:"
    git branch --merged | egrep -v "(^\*|master|develop)"
    echo
    echo "Do you really want to delete them? [y/N]"
    read a
    if [ "$a" = "y" ] || [ "$a" = "Y" ]; then
        git branch --merged | egrep -v "(^\*|master|develop)" | xargs git branch -d
    fi
}

export LESS="--RAW-CONTROL-CHARS --long-prompt --line-numbers --ignore-case --status-column"
export LESS_TERMCAP_mb=$(printf '\e[01;31m') # begin bold - red
export LESS_TERMCAP_md=$(printf '\e[01;32m') # begin blink - green
export LESS_TERMCAP_me=$(printf '\e[0m')     # leave bold / blink
export LESS_TERMCAP_se=$(printf '\e[0m')     # leave standout
export LESS_TERMCAP_so=$(printf '\e[01;31m') # enter standout - red
export LESS_TERMCAP_ue=$(printf '\e[0m')     # leave underline
export LESS_TERMCAP_us=$(printf '\e[01;37m') # enter underline - white
