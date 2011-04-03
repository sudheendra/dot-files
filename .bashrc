export LESS_TERMCAP_mb=$(printf '\e[01;31m') # enter blinking mode - red
export LESS_TERMCAP_md=$(printf '\e[01;35m') # enter double-bright mode - bold, magenta
export LESS_TERMCAP_me=$(printf '\e[0m') # turn off all appearance modes (mb, md, so, us)
export LESS_TERMCAP_se=$(printf '\e[0m') # leave standout mode
export LESS_TERMCAP_so=$(printf '\e[01;33m') # enter standout mode - yellow
export LESS_TERMCAP_ue=$(printf '\e[0m') # leave underline mode
export LESS_TERMCAP_us=$(printf '\e[04;36m') # enter underline mode - cyan

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias ls='ls --color=tty'
alias ll='ls -lrt --color=tty'

if [ -f ~/.alias ]; then
    . ~/.alias
fi

PS1='\[\e[1;30m\]\t\[\e[m\] \[\e[1;31m\]\w\[\e[m\]'

# For git
# export PS1="${PS1}"'\[\e[1;32m\]$(__git_ps1)\[\e[m\]\n\[\e[1;35m\]\$\[\e[m\] '

# For hg
export PS1="${PS1}"'\[\e[1;32m\]\[\e[m\]\n\[\e[1;35m\]\$\[\e[m\] '
export PS2='\[\e[1;32m\]\t\[\e[m\] \[\e[1;34m\]\w\[\e[m\]\[\e[0;32m\]>\[\e[m\] '

export SQLPATH=~/bin/sql
export QTDIR=/usr/local/Trolltech/Qt-4.7.4
export QMAKESPEC=$QTDIR/mkspecs/linux-g++-64
export BOOST_ROOT=/usr/local/boost/1.49.0/
export NETLIB_HOME=/usr/local/cpp-netlib/0.9.4
export jboss=/home/AIM/jboss-5.1.0.GA/bin

# User specific environment and startup programs
export JAVA_HOME=/usr/java/default

export ORACLE_HOME=/usr/lib/oracle/11.2/client64

export PATH=/sbin:/usr/sbin/:$PATH:$QTDIR/bin:$ORACLE_HOME/bin:$JAVA_HOME/bin:$PATH:$HOME/bin

# Internal setup
export PID_HOME=~/MySpace
export MU_ADDRESS=192.168.1.56
export MU_PORT=15000

export TERM=xterm-256color

# AIM debug mode also
export LD_LIBRARY_PATH=/usr/local/lib:$ORACLE_HOME/lib:$QTDIR/lib:$ORACLE_HOME/lib:$QTDIR/lib:$LD_LIBRARY_PATH
# Back it up
export ORIG_LD_LIBRARY_PATH=$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:${PID_HOME}/CommonLib:${PID_HOME}/Common:${PID_HOME}/NFIQLib
unset LANG

# paths
export CORE_LIB_PATH=/mnt/Corelibs
export NBEC_LIB_PATH=/mnt/NBECLibs
export TEST_DATA_PATH=/mnt/TestData
export PATH=$PATH:$GOROOT/bin
export FACE_INIT_DIR=/mnt/face/training-db/

get-bt()
{
    if [ $# -lt 2 ]; then
        echo "Usage: get-bt <exe-with-path> <core-file> [<0><1><2><3>]"
        return 0
    fi

    local exe=$1
    local core=$2
    if [ "$3" == "0" ]; then
        local var="bt"
    elif [ "$3" == "1" ]; then
        local var="bt full"
    elif [ "$3" == "2" ]; then
        local var="thread apply all bt"
    else
        local var="thread apply all bt full"
    fi

    if [ -z $3 ]; then
        var="bt full"
    fi

    gdb ${exe} \
        --core ${core} \
        --batch \
        -ex "set pagination off" \
        -ex ${var} \
        -ex "quit"
}

se()
{
    local path=$1
    local search_string="$2"

    find $path -name "*.cc" -o -name "*.c" -o -name "*.cpp" -o -name "*.h" -o -name "*.hpp" | xargs grep -nH --color=tty "$search_string"
}

# Diff a git repo
gd()
{
    for file in $(git diff --name-only)
    do
        echo "$file"
        git difftool --no-prompt $file
        echo -n "Quit? (y/n) "
        read -N1 ans
        if [ "$ans" == "y" -o "$ans" == "Y" ]; then
            echo
            return
        fi
    done
}

# Diff a hg repo
hd()
{
    for file in $(hg st -mard $1 | awk '{print $2}')
    do
        echo "$file"
        hg vimdiff $file
        echo -n "Quit? (y/n) "
        read -N1 ans
        if [ "$ans" == "y" -o "$ans" == "Y" ]; then
            echo
            return
        fi
    done
}

diffrev()
{
    if [ "$1" == "" -o "$2" == "" ]; then
        echo "Usage: diffrev rev1 rev2"
        return
    fi
    echo "Total files: " $(hg stat --rev $1:$2 | awk -F" "  '{if($1=="M") {print $2}}' | wc -l)
    for file in $(hg stat --rev $1:$2 | awk -F" "  '{if($1=="M") {print $2}}')
    do
        echo "$file"
        hg vimdiff $file -r $1 -r $2
        echo -n "Quit? (y/n) "
        read -N1 ans
        if [ "$ans" == "y" -o "$ans" == "Y" ]; then
            echo
            return
        fi
    done
}

cover()
{
    lcov --no-external -c -d .obj -b . -o SDK.info
    genhtml -s --legend SDK.info -o out
    rm -f SDK.info

:<<COMM
    local opt=$1
    local arg=$2
    if [ "$opt" = "-h" -o $# -eq 0 ]; then
        echo "Usage: cover <[-h] [-l test-no] [-o out-dir]>"
    fi

    if [ "$opt" = "-l" ]; then
        lcov -c -d src -b . -o SDK${arg}.info
        lcov -c -d sample -b sample -o SAMPLE${arg}.info
    elif [ "$opt" = "-o" ]; then
        genhtml -s --legend -o $arg
    elif [ "$opt" = "-c" ]; then
        rm -f SDK*.info SAMPLE*.info
    fi
    return 0
COMM
}

# Git me harder!
__git_ps1()
{
    local g="$(git rev-parse --git-dir 2>/dev/null)"
    if [ -n "$g" ]; then
        local r
        local b
        if [ -d "$g/../.dotest" ]
        then
            local b="$(git symbolic-ref HEAD 2>/dev/null)"
            r="|REBASING"
        elif [ -d "$g/.dotest-merge" ]
        then
            r="|REBASING"
            b="$(cat $g/.dotest-merge/head-name)"
        elif [ -f "$g/MERGE_HEAD" ]
        then
            r="|MERGING"
            b="$(git symbolic-ref HEAD 2>/dev/null)"
        else
            if [ -f $g/BISECT_LOG ]
            then
                r="|BISECTING"
            fi
            if ! b="$(git symbolic-ref HEAD 2>/dev/null)"
            then
                b="$(cut -c1-7 $g/HEAD)..."
            fi
        fi
        if [ -n "$1" ]; then
            printf "$1" "${b##refs/heads/}$r"
        else
            printf " (%s)" "${b##refs/heads/}$r"
        fi
    fi
}
