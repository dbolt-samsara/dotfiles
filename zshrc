function setup_zsh {
    export CLICOLOR=1
    export KEYTIMEOUT=1 # shorten key timeout, increase if key commands are not responding.

    autoload -U compinit && compinit
    autoload -U colors && colors
    setopt prompt_subst
    setopt no_case_glob # case insensitive globbing
    HISTFILE=~/.histfile
    HISTSIZE=1000
    SAVEHIST=1000

    # don't clobber history files
    setopt appendhistory 
    bindkey '^R' history-incremental-search-backward

    # Set up asdf for Python package management
    . $HOME/.asdf/asdf.sh
    fpath=(${ASDF_DIR}/completions $fpath)
    autoload -Uz compinit && compinit

    if which virtualenv &> /dev/null; then
        PYTHON_CMD=$(which "python")
        export VIRTUALENV_PYTHON=$PYTHON_CMD
    fi

    #if [ -e ~/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock ]; then
    #    export SSH_AUTH_SOCK=~/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock
    #fi
}

function setup_autocomplete {
    if [ -e /opt/homebrew/bin/aws_zsh_completer.sh ]; then
        source /opt/homebrew/bin/aws_zsh_completer.sh
    fi
}

function setup_antigen {
    source /opt/homebrew/share/antigen/antigen.zsh
    # Load the oh-my-zsh's library.
    antigen use oh-my-zsh
    antigen bundle git
    antigen bundle vi-mode
    antigen bundle vundle

    # Syntax highlighting bundle.
    antigen bundle zsh-users/zsh-syntax-highlighting

    # Theme
    #antigen theme agnoster

    # Tell antigen that you're done.
    antigen apply

    source ~/.zsh/themes/basic.zsh-theme
}

function setup_path {
    PATH="$PATH:/users/$USER/bin"

    # Resolve realpath vs grealpath in OSX Ventura
    # https://itbit.slack.com/archives/CDTDR1SAG/p1673300613368459
    PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH"

    export PATH
}

function setup_aliases {
    if [ -f ~/.zsh_aliases ]; then
        source ~/.zsh_aliases
    fi

    if [ -f ~/go/src/github.com/paxosglobal/tools/dotfiles/.vars ]; then
        source ~/go/src/github.com/paxosglobal/tools/dotfiles/.vars
    fi
}

setup_zsh
setup_antigen
setup_path
setup_aliases
setup_autocomplete