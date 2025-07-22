# Start tmux on initialization.
if [[ -z "$TMUX" && "$TERM_PROGRAM" != "vscode" ]]
then
  tmux -u attach -t TMUX || tmux -u new -s TMUX
fi

# ========================== BONSAI ==========================
# Display bonsai tree on terminal startup
cbonsai -p

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ========================== ZINIT SETUP ==========================
# Install Zinit if not already installed
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [[ ! -d "$ZINIT_HOME" ]]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
source "${ZINIT_HOME}/zinit.zsh"

# Load Powerlevel10k theme
zinit ice depth=1; zinit light romkatv/powerlevel10k

# ========================== ZINIT PLUGINS ==========================
# Load essential plugins first
zinit wait lucid for \
    atinit"zicompinit; zicdreplay" \
        zdharma-continuum/fast-syntax-highlighting \
    atload"_zsh_autosuggest_start" \
        zsh-users/zsh-autosuggestions \
    blockf atpull'zinit creinstall -q .' \
        zsh-users/zsh-completions

# Load Oh My Zsh plugins with turbo mode
zinit wait lucid for \
    OMZP::dotenv \
    OMZP::docker \
    OMZP::docker-compose \
    OMZP::git \
    OMZP::git-extras \
    OMZP::git-auto-fetch \
    OMZP::gh \
    OMZP::history \
    OMZP::nvm \
    OMZP::sudo \
    OMZP::tmux

# Load productivity plugins
zinit wait lucid for \
    Aloxaf/fzf-tab \
    hlissner/zsh-autopair \
    MichaelAquilina/zsh-you-should-use \
    mafredri/zsh-async \
    agkozak/zsh-z

# Load history-substring-search with key bindings
zinit wait lucid atload'
    bindkey "^[[A" history-substring-search-up
    bindkey "^[[B" history-substring-search-down
' for zsh-users/zsh-history-substring-search

# ========================== PATH EXPORTS ==========================
export PATH="$HOME/.local/bin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"
export PATH="$PATH:/Users/petr/.lmstudio/bin"

# ========================== ZSH CONFIGURATION ==========================
ZSH_DISABLE_COMPFIX="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"

# fzf-tab configuration
zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup
zstyle ':completion:*:git-checkout:*' sort false
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
zstyle ':fzf-tab:*' switch-group ',' '.'
zstyle ':fzf-tab:complete:cd:*' popup-pad 50 0

# ========================== CUSTOM ALIASES ==========================
# UPGRADE ALL!
alias all-up="mas-up; brew-up; brew-cl; brew-dc; zsh-up; nvm-up; npm-up; nvm-cl; npm-cv; gh-up; code-cl; clr; zsh-rr;"

# MacOS
alias mac-up="sudo softwareupdate -i -a --restart"
alias mas-up="mas upgrade"

# brew
alias brew-up="brew update; brew upgrade; brew upgrade --cask; brew cu -a -y"
alias brew-cl="brew cleanup -s; brew autoremove"
alias brew-dc="brew doctor; brew missing"

# zsh
alias zsh-cfg="code ~/.zshrc"
alias zsh-rr="exec zsh"
alias zsh-up="zinit self-update; zinit update --all"

# nvm
alias nvm-up="nvm install 'lts/*' --reinstall-packages-from=current"
alias nvm-cl="nvm cache clear"

# npm
alias npm-ls="npm list -g --depth=0"
alias npm-up="npm update -g"
alias npm-cv="npm cache verify"

# GitHub CLI
alias gh-up="gh extension upgrade --all"

# Basic bash aliases
alias clr="clear"
alias cd..="cd .."

alias c="code"

alias df='/opt/homebrew/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
alias dfcam='df commit -am "Update dotfiles"'

alias dev="cd ~/Developer"
alias work="cd ~/Developer/prusa"

# Scripts
alias code-cl="sh ~/Developer/scripts/vscode-unused-workspace-storage-cleanup.sh"

# git
alias uncommit="git reset HEAD~1"

# ========================== ADDITIONAL CONFIGURATIONS ==========================
# Docker completions
fpath=(/Users/petr/.docker/completions $fpath)

# Load Powerlevel10k configuration
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
