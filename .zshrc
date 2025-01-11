# Custom ZSHRC
# =====================
# ENVIRONMENT VARIABLES
# =====================
export ZSH="$HOME/.config/zsh"
export HISTSIZE=1000
export SAVEHIST=1000
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
# IP command
alias ip='ip --color=auto'
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
export ANDROID_SDK_ROOT=/opt/android-sdk
export PATH=$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin
export PATH=$PATH:$ANDROID_SDK_ROOT/emulator
export PATH=$PATH:$ANDROID_SDK_ROOT/platform-tools

# GO
export PATH=$PATH:~/go/bin

# Ruby
export PATH="$PATH:$HOME/.local/share/gem/ruby/3.3.0/bin"
