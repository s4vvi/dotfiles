# Custom ZSHRC
# =====================
# ENVIRONMENT VARIABLES
# =====================
export ZSH="$HOME/.config/zsh"
export HISTSIZE=10000
export SAVEHIST=10000
export HISTFILE="$HOME/.zsh_history"
export ZSH_COMPDUMP=$ZSH/cache/.zcompdump-$HOST
export WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'
export MANPAGER='nvim +Man!'

# =========
# KEY BINDS
# =========
# Jump words with `CTRL + ARROW`
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word


# =======
# ALIASES
# =======
# Resource
alias resource='source ~/.zshrc'
# IP command
alias ip='ip --color=auto'
# Diff command
alias diff='diff --color=always'
# Replacement for "ls"
# Using `eza` for tab completion
alias ls="exa -l -g --icons --git -s type"
# Using `eza` fro tab completion
# Replacement for "tree"
alias tree="exa -1 --icons --tree --git-ignore -s type"
# Alias for copy / clipboard
alias xsc="xclip -selection c"
alias xoc="xclip -o -selection c"
alias chepys="chepy \$(xoc)"
# Bat
alias bat="bat --plain -P"
# Clipboard encodings
# Base64 Encode
alias xbe="xclip -o -selection c | base64 -w 0 | xclip -selection c" 
# Base64 Decode
alias xbd="xclip -o -selection c | base64 -d | xclip -selection c" 
# URL Encoding
alias xue="xclip -o -selection c | ~/.cargo/bin/urle | xclip -selection c" 
# URL Decoding 
alias xud="xclip -o -selection c | ~/.cargo/bin/urld | xclip -selection c" 
# Format JSON 
alias xjq="xclip -o -selection c | jq | xclip -selection c" 
# Prune tmux sessions
alias tmuxprune="for id in \$(tmux list-sessions | grep -v 'attached' | cut -d ':' -f 1); do tmux kill-session -t \$id; done"
alias tmuxa="tmux has-session && tmux attach-session || tmux new-session"
# Netstat
alias ports="netstat -tulpn 2>/dev/null"
# Get w/ dir
alias gwd="pwd | tr -d '\n' | xsc"
# VIM
alias vim="nvim"
# Sig kill a single process
alias sigkill="sigterm_kill"
# GPT
alias gptn="gpt -n"
alias gptl="gpt --list-threads"
alias gptt="gpt --set-thread"
alias gpth="gpt --show-history 2>/dev/null"
alias gptc="gpt --clear-history"

function gpt_prune() {
    for thread in $(gpt --list-threads | grep '\- cmd_' | cut -d ' ' -f 2); do
        gpt --delete-thread $thread
    done
}

function sigterm_kill() {
    local slug=$1
    local pid=$(ps aux | grep $slug | grep -v grep | awk '{print $2}')

    if [[ $(echo $pid | wc -l) -gt 1 ]]; then
        echo "Too many processes that match"
    fi

    kill -9 $pid
}

# Threatfox search
threatfox() {
    if [[ $1 == "" ]]; then
        echo "threatfox <query>";
        return
    fi
    curl -sX POST https://threatfox-api.abuse.ch/api/v1/ -d "{\"query\": \"search_ioc\", \"search_term\": \"$1\"}" | jq 
}

# My ip
myip() {
    curl -q https://ipinfo.io 2>/dev/null | jq
}

muris_check() {
    if [[ $1 == "" ]]; then
        echo "muris_check <domain>";
        return
    fi
    curl -s -X POST "https://dnsmuris.lv/api/check" -H "Content-Type: multipart/form-data" -F "domain=$1" -A "EZ" | jq
}

jara() {
    if [[ $1 == "" ]]; then
        echo "jara <target>";
        return
    fi

    for rules in $(find /work/projects/YARA/ -type f -name "*.yar"); do 
        yara -r $rules $1 2>/dev/null;
    done
}

# =======
# PLUGINS
# =======
# Import plugins
source $ZSH/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source $ZSH/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/fzf/completion.zsh
source /usr/share/fzf/key-bindings.zsh

# Clear suggestions on paste
ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(bracketed-paste)

# Better completion
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'


# =============
# MISCELLANEOUS
# =============
# Starship prompt configuration
eval "$(starship init zsh)"

export PATH="$PATH:$HOME/.cargo/bin"
export LIBVIRT_DEFAULT_URI="qemu:///system"

# Android SDK
export ANDROID_HOME=/opt/android-sdk
export PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools

# GO
export PATH=$PATH:~/go/bin

# Ruby
export PATH="$PATH:$HOME/.local/share/gem/ruby/3.3.0/bin"
