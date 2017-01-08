# /etc/profile
typeset -U PATH
PATH=/usr/local/bin:/usr/local/sbin:$PATH

# npm
export PATH="$PATH:/usr/local/share/npm/bin"


# General Settings
# ------------------------------
autoload -U compinit
compinit
export EDITOR=vim        # エディタをvimに設定
export LANG=ja_JP.UTF-8  # 文字コードをUTF-8に設定
export KCODE=u           # KCODEにUTF-8を設定
export AUTOFEATURE=true  # autotestでfeatureを動かす

setopt no_beep           # ビープ音を鳴らさないようにする

# eval "$(rbenv init -)"


# users generic .zshrc file for zsh(1)

## Environment variable configuration
#
# LANG
#
export LANG=ja_JP.UTF-8
case ${UID} in
0)
    LANG=C
    ;;
esac


## Default shell configuration
#
# set prompt
#

function parse-git-branch()
{
    local branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
    if [ -n "${branch}" ]; then
        [ "${branch}" = "HEAD" ] && local branch=$(git rev-parse --short HEAD 2>/dev/null)
        local statusis="$(git status --porcelain 2>/dev/null)"
        echo -n " on %F{6}${branch}%f"
        [ -n "${statusis}" ] && echo -n "%F{3}*%f"
    fi
}

setopt prompt_subst

autoload colors
colors
case ${UID} in
0)
    PROMPT="%{${fg[cyan]}%}$(echo ${HOST%%.*} | tr '[a-z]' '[A-Z]') %B%{${fg[red]}%}%/#%{${reset_color}%}%b "
    PROMPT2="%B%{${fg[red]}%}%_#%{${reset_color}%}%b "
    SPROMPT="%B%{${fg[red]}%}%r is correct? [n,y,a,e]:%{${reset_color}%}%b "
    ;;
*)
    # PROMPT="%{${fg[red]}%}%/%%%{${reset_color}%} "
    PROMPT='%F{6}%n%f at %F{6}%m%f in %F{6}%c%f$(parse-git-branch)
%# '
    PROMPT2="%{${fg[red]}%}%_%%%{${reset_color}%} "
    SPROMPT="%{${fg[red]}%}%r is correct? [n,y,a,e]:%{${reset_color}%} "
    [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] &&
        PROMPT="%{${fg[cyan]}%}$(echo ${HOST%%.*} | tr '[a-z]' '[A-Z]') ${PROMPT}"
    ;;
esac
#
## ----- PROMPT -----
### PROMPT
## PROMPT=$'[%*] → '
#PROMPT='%F{6}%n%f at %F{6}%m%f in %F{6}%c%f $(parse-git-branch)
#%# '
#
### RPROMPT
#RPROMPT=$'`branch-status-check` %~' # %~はpwd
#setopt prompt_subst #表示毎にPROMPTで設定されている文字列を評価する
#
## {{{ methods for RPROMPT
## fg[color]表記と$reset_colorを使いたい
## @see https://wiki.archlinux.org/index.php/zsh
#autoload -U colors; colors
#function branch-status-check {
#    local prefix branchname suffix
#        # .gitの中だから除外
#        if [[ "$PWD" =~ '/\.git(/.*)?$' ]]; then
#            return
#        fi
#        branchname=`get-branch-name`
#        # ブランチ名が無いので除外
#        if [[ -z $branchname ]]; then
#            return
#        fi
#        prefix=`get-branch-status` #色だけ返ってくる
#        suffix='%{'${reset_color}'%}'
#        echo ${prefix}${branchname}${suffix}
#}
#function get-branch-name {
#    # gitディレクトリじゃない場合のエラーは捨てます
#    echo `git rev-parse --abbrev-ref HEAD 2> /dev/null`
#}
#function get-branch-status {
#    local res color
#        output=`git status --short 2> /dev/null`
#        if [ -z "$output" ]; then
#            res=':' # status Clean
#            color='%{'${fg[green]}'%}'
#        elif [[ $output =~ "[\n]?\?\? " ]]; then
#            res='?:' # Untracked
#            color='%{'${fg[yellow]}'%}'
#        elif [[ $output =~ "[\n]? M " ]]; then
#            res='M:' # Modified
#            color='%{'${fg[red]}'%}'
#        else
#            res='A:' # Added to commit
#            color='%{'${fg[cyan]}'%}'
#        fi
#        # echo ${color}${res}'%{'${reset_color}'%}'
#        echo ${color} # 色だけ返す
#}
## }}}

# auto change directory
#
setopt auto_cd

# auto directory pushd that you can get dirs list by cd -[tab]
#
setopt auto_pushd

# command correct edition before each completion attempt
#
setopt correct

# compacked complete list display
#
setopt list_packed

# no remove postfix slash of command line
#
setopt noautoremoveslash

# no beep sound when complete list displayed
#
setopt nolistbeep


## Keybind configuration
#
# emacs like keybind (e.x. Ctrl-a gets to line head and Ctrl-e gets
#   to end) and something additions
#
# bindkey -e
bindkey -v
bindkey "^[[1~" beginning-of-line # Home gets to line head
bindkey "^[[4~" end-of-line # End gets to line end
bindkey "^[[3~" delete-char # Del

# historical backward/forward search with linehead string binded to ^P/^N
#
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^p" history-beginning-search-backward-end
bindkey "^n" history-beginning-search-forward-end
bindkey "\\ep" history-beginning-search-backward-end
bindkey "\\en" history-beginning-search-forward-end

# reverse menu completion binded to Shift-Tab
#
bindkey "\e[Z" reverse-menu-complete


## Command history configuration
#
HISTFILE=${HOME}/.zsh_history
HISTSIZE=50000
SAVEHIST=50000
setopt hist_ignore_dups     # ignore duplication command history list
setopt share_history        # share command history data


## Completion configuration
#
fpath=(${HOME}/.zsh/functions/Completion ${fpath})
autoload -U compinit
compinit


## zsh editor
#
autoload zed


## Prediction configuration
#
#autoload predict-on
#predict-off


## Alias configuration
#
# expand aliases before completing
#
setopt complete_aliases     # aliased ls needs if file/dir completions work

alias where="command -v"
alias j="jobs -l"

case "${OSTYPE}" in
freebsd*|darwin*)
    alias ls="ls -G -w"
    ;;
linux*)
    alias ls="ls --color"
    ;;
esac

alias la="ls -a"
alias lf="ls -F"
alias ll="ls -l"

alias du="du -h"
alias df="df -h"

alias su="su -l"

## Alias configuration
#
# mine
#
alias defchek="defaults read >before; echo 'set and then enter...'; read; defaults read >after; diff before after"

alias brewups="brew update && brew upgrade brew-cask && brew cleanup && brew cask cleanup"

## terminal configuration
#
case "${TERM}" in
screen)
    TERM=xterm
    ;;
esac

case "${TERM}" in
xterm*)
    export LSCOLORS=Exfxcxdxbxegedabagacad
    export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
    zstyle ':completion:*' list-colors 'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'
    ;;
kterm-color)
    stty erase '^H'
    export LSCOLORS=Exfxcxdxbxegedabagacad
    export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
    zstyle ':completion:*' list-colors 'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'
    ;;
kterm)
    stty erase '^H'
    ;;
cons25)
    unset LANG
    export LSCOLORS=ExFxCxdxBxegedabagacad
    export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
    zstyle ':completion:*' list-colors 'di=;34;1' 'ln=;35;1' 'so=;32;1' 'ex=31;1' 'bd=46;34' 'cd=43;34'
    ;;
jfbterm-color)
    export LSCOLORS=gxFxCxdxBxegedabagacad
    export LS_COLORS='di=01;36:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
    zstyle ':completion:*' list-colors 'di=;36;1' 'ln=;35;1' 'so=;32;1' 'ex=31;1' 'bd=46;34' 'cd=43;34'
    ;;
esac

# set terminal title including current directory
#
case "${TERM}" in
xterm|xterm-color|kterm|kterm-color)
    precmd() {
        echo -ne "\033]0;${USER}@${HOST%%.*}:${PWD}\007"
    }
    ;;
esac


alias su="su -l"

## load user .zshrc configuration file
#
[ -f ${HOME}/.zshrc.mine ] && source ${HOME}/.zshrc.mine

#
# for Neovim
#
export XDG_CONFIG_HOME="$HOME/.config"
