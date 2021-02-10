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
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/petr/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"
ZSH_DISABLE_COMPFIX=true
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(tmux git git-auto-fetch history nvm npm ng docker docker-compose autojump fzf-tab)

source $ZSH/oh-my-zsh.sh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
[ -f /opt/homebrew/etc/profile.d/autojump.sh ] && . /opt/homebrew/etc/profile.d/autojump.sh

export PATH="/opt/homebrew/opt/php@7.4/bin:$PATH"
export PATH="/opt/homebrew/opt/php@7.4/sbin:$PATH"

export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && . "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && . "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# --------------------------- Custom aliases ----------------------------------
# UPGRADE ALL!
alias all-up="brew-up; brew-cl; brew-dc; zsh-up; npm-up; pip-up; nvim-cfg-up; clr; zsh-rr;"

# MacOS

alias mac-up="sudo softwareupdate -i -a --restart"

# brew
alias brew-up="brew update; brew upgrade; brew upgrade --cask"
alias brew-cl="brew cleanup -s"
alias brew-dc="brew doctor; brew missing"

# zsh
alias zsh-cfg="code ~/.zshrc"
alias zsh-rr="exec zsh"
alias zsh-up="omz update --unattended; p10k-up; fzf-tab-up"
alias zsh-hs="mv ~/.zsh_history ~/.zsh_history_bad && strings ~/.zsh_history_bad > ~/.zsh_history && fc -R ~/.zsh_history && rm ~/.zsh_history_bad"

alias p10k-up="git -C ~/.oh-my-zsh/custom/themes/powerlevel10k pull --rebase"
alias fzf-tab-up="git -C ~/.oh-my-zsh/custom/plugins/fzf-tab pull --rebase"

# nvm
alias nvm-up="nvm install node --reinstall-packages-from=node"
alias npm-ls="npm list -g --depth=0"
alias npm-up="npm update -g"
alias npm-cv="npm cache verify"
# alias func="npm update"

# npm() {
#     if [[ $1 == "update" ]]
#     then
#         command npm update --legacy-peer-deps "$@"
#     else
#         command npm "$@"
#     fi
# }

# nvim
alias nvim-cfg-up="git -C ~/.config/nvim pull --rebase --autostash"

# pip
alias pip-up="python3 -m pip install --upgrade pip"

# Basic bash aliases
alias code="code-insiders"
alias clr="clear"
alias cd..="cd .."

alias df='/opt/homebrew/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME'

alias dev="cd ~/Developer"
alias sm="cd ~/Developer/SM"

# Funny time! (cmatrix, hollywood, sl, aafire, toilet)
alias weather="curl http://wttr.in"
alias tron="ssh sshtron.zachlatta.com"
alias map="telnet mapscii.me"
alias fish="asciiquarium"
alias fcow="fortune | cowsay | lolcat"
alias ftux="fortune | cowsay -f tux | lolcat"
alias dragon="git log -1 | cowsay -f dragon-and-cow | lolcat"
alias clock="watch -t -n1 'date +%A%n%x%n%X | figlet -t -c'"
alias starwars="telnet towel.blinkenlights.nl"

# GIT
alias uncommit="git reset HEAD~1"

# Dev-env aliases
alias mklnsf="ln -s -f ~/Developer/SM/Php/* ~/Developer/Php"

alias start-lamp="brew services start httpd; brew services start php@7.4; brew services start redis; brew services start mysql"
alias stop-lamp="brew services stop httpd; brew services stop php@7.4; brew services stop redis; brew services stop mysql"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /home/petr/go/bin/bit bit

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

