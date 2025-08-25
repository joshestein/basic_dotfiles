HISTSIZE="10000"
SAVEHIST="10000"

HISTFILE="$HOME/.zsh_history"
mkdir -p "$(dirname "$HISTFILE")"

setopt HIST_FCNTL_LOCK
unsetopt APPEND_HISTORY
setopt HIST_IGNORE_DUPS
unsetopt HIST_IGNORE_ALL_DUPS
unsetopt HIST_SAVE_NO_DUPS
unsetopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_SPACE
unsetopt HIST_EXPIRE_DUPS_FIRST
setopt SHARE_HISTORY
unsetopt EXTENDED_HISTORY

setopt correct                                                  # Auto correct mistakes
setopt extendedglob                                             # Extended globbing. Allows using regular expressions with *
setopt nocaseglob                                               # Case insensitive globbing
setopt rcexpandparam                                            # Array expension with parameters
setopt nocheckjobs                                              # Don't warn about running processes when exiting
setopt numericglobsort                                          # Sort filenames numerically when it makes sense
setopt nobeep                                                   # No beep
setopt appendhistory                                            # Immediately append history instead of overwriting
setopt histignorealldups                                        # If a new command is a duplicate, remove the older one
setopt autocd                                                   # if only directory path is entered, cd there.
setopt nohup
unsetopt nomatch
setopt prompt_subst                                             # Enable substitution for prompt

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'       # Case insensitive tab completion
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"         # Colored completion (different colors for dirs/files/etc)
zstyle ':completion:*' rehash true                              # automatically find new executables in path 
# Speed up completions
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache
WORDCHARS=${WORDCHARS//\/[&.;]}                                 # Don't consider certain characters part of the word

bindkey -v
export KEYTIMEOUT=1
bindkey '^H' backward-kill-word

# Theming section  
autoload -Uz compinit colors zcalc
# https://github.com/sorin-ionescu/prezto/blob/e149367445d2bcb9faa6ada365dfd56efec39de8/modules/completion/init.zsh#L34=
_comp_files=(${ZDOTDIR:-$HOME}/.zcompdump(Nm-20))
if (( $#_comp_files )); then
  compinit -i -C
else
  compinit -i
fi
unset _comp_files
colors

[ -f $XDG_CONFIG_HOME/shell/functions.zsh ] && source $XDG_CONFIG_HOME/shell/functions.zsh
[ -f $XDG_CONFIG_HOME/shell/git.zsh ] && source $XDG_CONFIG_HOME/shell/git.zsh
[ -f $XDG_CONFIG_HOME/shell/tmux.zsh ] && source $XDG_CONFIG_HOME/shell/tmux.zsh
[ -f $XDG_CONFIG_HOME/shell/venv.zsh ] && source $XDG_CONFIG_HOME/shell/venv.zsh

export FZF_CTRL_T_COMMAND="fd --hidden --follow"

bindkey '^P' fzf-cd-widget
bindkey '^F' fzf-file-widget

alias -- ...=../..
alias -- ....=../../..
alias -- .....=../../../..
alias -- activate='source .venv/bin/activate'
alias -- bc='bc -ql'
alias -- cat=lscat
alias -- cp='cp -iv'
alias -- df='df -h'
alias -- free='free -h'
alias -- g=git
alias -- ga='git add'
alias -- gaa='git add all'
alias -- gca='git commit --amend'
alias -- gcm='git commit -m'
alias -- gcmsg='git commit -m'
alias -- gco='git checkout'
alias -- gf='git fetch'
alias -- glog='git log --oneline --decorate --graph'
alias -- gloga='git log --oneline --decorate --graph --all'
alias -- gp='git push'
alias -- gpu='git pull'
alias -- grep='grep --color=auto'
alias -- gst='git status'
alias -- hg='history | grep'
alias -- l=lscat
alias -- la='eza -a'
alias -- ll='eza --long --git --hyperlink'
alias -- lla='eza -la'
alias -- ls=eza
alias -- lt='eza --tree --hyperlink'
alias -- md=mkcdir
alias -- mv='mv -iv'
alias -- nb='npm run build'
alias -- ni='npm install'
alias -- ns='npm start'
alias -- p=python
alias -- pip='uv pip'
alias -- rm='rm -iv'
alias -- sv=sudoedit
alias -- v=nvim
alias -- venv='uv venv && source .venv/bin/activate'
