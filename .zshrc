# Start tmux on initialization.
if [[ -z "$TMUX" && "$TERM_PROGRAM" != "vscode" ]]
then
  tmux -u attach -t TMUX || tmux -u new -s TMUX
fi

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ========================== PERFORMANCE OPTIMIZATIONS ==========================
# Skip global compinit for faster startup
skip_global_compinit=1

# Optimize history settings
HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000
SAVEHIST=50000
setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_BEEP
setopt SHARE_HISTORY
setopt INC_APPEND_HISTORY

# ========================== `ZINIT` SETUP ==========================
# Install Zinit if not already installed
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [[ ! -d "$ZINIT_HOME" ]]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
source "${ZINIT_HOME}/zinit.zsh"

# Install Bin-Gem-Node annex for additional ice modifiers (sbin, etc.)
zinit light-mode for zdharma-continuum/zinit-annex-bin-gem-node

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
    OMZP::sudo \
    OMZP::tmux

# Load productivity plugins
zinit wait lucid for \
    Aloxaf/fzf-tab \
    hlissner/zsh-autopair \
    MichaelAquilina/zsh-you-should-use \
    mafredri/zsh-async \
    ajeetdsouza/zoxide

# Load history-substring-search with key bindings
zinit wait lucid atload'
    bindkey "^[[A" history-substring-search-up
    bindkey "^[[B" history-substring-search-down
' for zsh-users/zsh-history-substring-search

# Load fnm completions and zoxide after completion system is ready
zinit wait lucid atload'eval "$(fnm completions --shell zsh)"; eval "$(zoxide init zsh)"' for \
    zdharma-continuum/null

# ========================== GIT EXTENSIONS ==========================
# Load git extensions with Bin-Gem-Node annex in turbo mode
zinit as'null' lucid sbin wait'1' for \
  Fakerr/git-recall \
  davidosomething/git-my \
  iwata/git-now \
  paulirish/git-open \
  paulirish/git-recent \
  atload'export _MENU_THEME=legacy' arzzen/git-quick-stats \
  make'install' tj/git-extras \
  make'GITURL_NO_CGITURL=1' sbin'git-url;git-guclone' zdharma-continuum/git-url

# ========================== ENVIRONMENT VARIABLES ==========================
export EDITOR="lvim"

# ========================== PATH EXPORTS ==========================
typeset -U path
path=(
    "$HOME/.local/bin"
    "/opt/homebrew/bin"
    "/opt/homebrew/sbin"
    "$HOME/.lmstudio/bin"
    $path
)
export PATH

# ========================== NODE VERSION MANAGER ==========================
# fnm (Fast Node Manager) initialization
eval "$(fnm env --use-on-cd)"

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
alias all-up="mas-up; brew-up; brew-cl; brew-dc; zsh-up; fnm-up; npm-up; npm-cv; gh-up; code-cl; clr; zsh-rr;"

# MacOS
alias mac-up="sudo softwareupdate -i -a --restart"
alias mas-up="mas upgrade"

# brew
alias brew-up="brew update; brew upgrade; brew upgrade --cask"
alias brew-cl="brew cleanup -s; brew autoremove"
alias brew-dc="brew doctor; brew missing"

# zsh
alias zsh-cfg="code ~/.zshrc"
alias zsh-rr="exec zsh"
alias zsh-up="zinit self-update; zinit update --all --parallel"

# fnm (Fast Node Manager)
alias fnm-up="fnm install --lts && fnm use lts-latest"

# npm
alias npm-ls="npm list -g --depth=0"
alias npm-up="npm update -g"
alias npm-cv="npm cache verify"

# GitHub CLI
alias gh-up="gh extension upgrade --all"

# Enhanced file operations
alias l="eza -la --git --icons"
alias la="eza -la --git --icons"
alias ll="eza -la --git --icons"
alias lt="eza --tree --git --icons"
alias ls="eza --icons"

# Modern CLI tool replacements (install with: brew install bat ripgrep fd-find dust)
alias cat="bat"
alias grep="rg"
alias find="fd"
alias du="dust"
alias cd="z"  # zoxide smart cd

# Basic bash aliases
alias q="exit"
alias clr="clear"
alias cd..="cd .."
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

alias c="code"
alias h="history"
alias j="jobs -l"
alias path='echo -e ${PATH//:/\\n}'

# Dotfiles management
alias df='/opt/homebrew/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
alias dfcam='df commit -am "Update dotfiles"'

# Quick navigation
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

# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/petr/.lmstudio/bin"
# End of LM Studio CLI section

