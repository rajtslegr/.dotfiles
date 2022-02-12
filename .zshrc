
# Start tmux on initialization.
if [[ -z "$TMUX" && "$TERM_PROGRAM" != "vscode" ]]
then
    tmux attach -t TMUX || tmux new -s TMUX
fi

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
export PATH="$HOME/.local/bin:$PATH"

# Path to your oh-my-zsh installation.
export ZSH="/Users/petr/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"
ZSH_DISABLE_COMPFIX=true
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Path to hombrew binary
export PATH="/opt/homebrew/bin:$PATH"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  autojump
  docker
  docker-compose
  git
  git-extras
  git-auto-fetch
  history
  nvm
  sudo
  tmux
  fzf-tab
)

source $ZSH/oh-my-zsh.sh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
[ -f /opt/homebrew/etc/profile.d/autojump.sh ] && . /opt/homebrew/etc/profile.d/autojump.sh

export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && . "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && . "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# --------------------------- Custom aliases ----------------------------------
# UPGRADE ALL!
alias all-up="mas-up; brew-up; brew-cl; brew-dc; zsh-up; ;lvim-up; nvm-up; npm-up; pip-up; nvm-cl; npm-cv; pip-cl; code-cl; clr; zsh-rr;"

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
alias zsh-up="omz update --unattended; p10k-up; fzf-tab-up"
alias zsh-hs="mv ~/.zsh_history ~/.zsh_history_bad && strings ~/.zsh_history_bad > ~/.zsh_history && fc -R ~/.zsh_history && rm ~/.zsh_history_bad"

alias p10k-up="git -C ~/.oh-my-zsh/custom/themes/powerlevel10k pull --rebase"
alias fzf-tab-up="git -C ~/.oh-my-zsh/custom/plugins/fzf-tab pull --rebase"

# nvm
alias nvm-up="nvm install 'lts/*' --reinstall-packages-from=current"
alias nvm-cl="nvm cache clear"
alias npm-ls="npm list -g --depth=0"
alias npm-up="npm update -g"
alias npm-cv="npm cache verify"

# pip
alias pip-up="python3 -m pip install --upgrade pip; pip3 list --outdated --format=freeze | grep -v '^\-e' | cut -d = -f 1 | xargs -n1 pip3 install -U"
alias pip-cl="pip3 cache purge"

# lvim
alias lvim-up="lvim +LvimUpdate +q"

# Basic bash aliases
alias clr="clear"
alias cd..="cd .."

alias df='/opt/homebrew/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME'

alias dev="cd ~/dev"
alias work="cd ~/dev/economia"

alias vpn="sudo openfortivpn"

# Scripts
alias code-cl="sh ~/dev/scripts/vscode-unused-workspace-storage-cleanup.sh"
alias slc="cd ~; python3 ~/dev/scripts/calc.py"

# Funny time! (cmatrix, hollywood, sl, aafire, toilet)
alias weather="curl http://wttr.in"
alias tron="ssh sshtron.zachlatta.com"
alias fcow="fortune | cowsay | lolcat"
alias ftux="fortune | cowsay -f tux | lolcat"
alias dragon="git log -1 | cowsay -f dragon-and-cow | lolcat"
alias clock="watch -t -n1 'date +%A%n%x%n%X | figlet -t -c'"

# git
alias uncommit="git reset HEAD~1"
alias gddb="git branch --v | grep '\[gone\]' | awk '{print $1}' | xargs git branch -D"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /home/petr/go/bin/bit bit

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Initialize fzf-tab/tmux popup
zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup
# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# preview directory's content with exa when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath'
# switch group using `,` and `.`
zstyle ':fzf-tab:*' switch-group ',' '.'
# set popup-pad values
zstyle ':fzf-tab:complete:cd:*' popup-pad 50 0

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[[ -f /Users/petr/dev/economia/aktu-volby/node_modules/tabtab/.completions/serverless.zsh ]] && . /Users/petr/dev/economia/aktu-volby/node_modules/tabtab/.completions/serverless.zsh
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[[ -f /Users/petr/dev/economia/aktu-volby/node_modules/tabtab/.completions/sls.zsh ]] && . /Users/petr/dev/economia/aktu-volby/node_modules/tabtab/.completions/sls.zsh
