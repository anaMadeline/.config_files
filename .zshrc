#Ana's amazing ZSH config file
#
#It is in vi mode, but lazy.
#
#You'll also need
#zsh-syntax-highlighting	https://github.com/zsh-users/zsh-syntax-highlighting
#zsh-autosuggestions		https://github.com/zsh-users/zsh-autosuggestions
#zsh-completions		https://github.com/zsh-users/zsh-completions

#My cool prompt
autoload -U colors && colors

#light mode
PS1="%F{69}%n%F{233}@%F{166}%M %F{233}%~/ %F{214}] %F{0}"

#dark mode
##PS1="%F{153}%n%F{15}@%F{216}%M %F{15}%~/ %F{208}:: %{$reset_color%}"



# Lines configured by zsh-newuser-install
HISTFILE=~/.config/zsh/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd beep extendedglob nomatch notify

#========================>>=======================<
# My awesome aliases
# you'll need
# exa
# ranger
# arch linux based distro
# neovim
alias cl="clear"
alias ls="exa -s type"
alias lsl="exa -lah -s type"
alias cls="clear && ls"
alias ran="ranger"

# doas for sudo
alias pac="doas pacman"
alias paci="doas pacman -S"
alias pacu="doas pacman -Syyu"
alias pacs="doas pacman -Ss"

alias naptime="systemctl suspend"

alias vi="nvim"
alias vim="nvim"

# more aliases at
[ -f "$HOME/.config/aliasrc" ] && source "$HOME/.config/aliasrc"

# Change EPisode Counter
# make a file that has a number as it's title
# now you can rename it for a new 
# number every new episode you watch (this is really stupid)
alias cepc="mv [0-9]*"
#========================>>=======================<



#================>>====================
# This onward from Luke Smith's zshrc 
# https://gist.github.com/LukeSmithxyz/e62f26e55ea8b0ed41a65912fbebbe52
# modified to my tastes

# Auto complete options
autoload -Uz compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)

# vim keys and edit in vim
bindkey -v
alias vi="vim"
export KEYTIMEOUT=1

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# change shape based on mode
# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[3 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[3 q"
}
zle -N zle-line-init
echo -ne '\e[3 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[3 q' ;} # Use beam shape cursor for each new prompt.
#================>>====================



#I actually don't remember where I got these things from :/ sorry
typeset -g -A key

key[Home]="${terminfo[khome]}"
key[End]="${terminfo[kend]}"
key[Insert]="${terminfo[kich1]}"
key[Backspace]="${terminfo[kbs]}"
key[Delete]="${terminfo[kdch1]}"
key[Up]="${terminfo[kcuu1]}"
key[Down]="${terminfo[kcud1]}"
key[Left]="${terminfo[kcub1]}"
key[Right]="${terminfo[kcuf1]}"
key[PageUp]="${terminfo[kpp]}"
key[PageDown]="${terminfo[knp]}"
key[Shift-Tab]="${terminfo[kcbt]}"

# setup key accordingly
[[ -n "${key[Home]}"      ]] && bindkey -- "${key[Home]}"       beginning-of-line
[[ -n "${key[End]}"       ]] && bindkey -- "${key[End]}"        end-of-line
[[ -n "${key[Insert]}"    ]] && bindkey -- "${key[Insert]}"     overwrite-mode
[[ -n "${key[Backspace]}" ]] && bindkey -- "${key[Backspace]}"  backward-delete-char
[[ -n "${key[Delete]}"    ]] && bindkey -- "${key[Delete]}"     delete-char
[[ -n "${key[Up]}"        ]] && bindkey -- "${key[Up]}"         up-line-or-history
[[ -n "${key[Down]}"      ]] && bindkey -- "${key[Down]}"       down-line-or-history
[[ -n "${key[Left]}"      ]] && bindkey -- "${key[Left]}"       backward-char
[[ -n "${key[Right]}"     ]] && bindkey -- "${key[Right]}"      forward-char
[[ -n "${key[PageUp]}"    ]] && bindkey -- "${key[PageUp]}"     beginning-of-buffer-or-history
[[ -n "${key[PageDown]}"  ]] && bindkey -- "${key[PageDown]}"   end-of-buffer-or-history
[[ -n "${key[Shift-Tab]}" ]] && bindkey -- "${key[Shift-Tab]}"  reverse-menu-complete

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
	autoload -Uz add-zle-hook-widget
	function zle_application_mode_start { echoti smkx }
	function zle_application_mode_stop { echoti rmkx }
	add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
	add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
fi

autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

[[ -n "${key[Up]}"   ]] && bindkey -- "${key[Up]}"   up-line-or-beginning-search
[[ -n "${key[Down]}" ]] && bindkey -- "${key[Down]}" down-line-or-beginning-search


key[Control-Left]="${terminfo[kLFT5]}"
key[Control-Right]="${terminfo[kRIT5]}"

[[ -n "${key[Control-Left]}"  ]] && bindkey -- "${key[Control-Left]}"  backward-word
[[ -n "${key[Control-Right]}" ]] && bindkey -- "${key[Control-Right]}" forward-word





# load extra scripts for
# zsh-autosuggestions
source ~/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# zsh-syntax-highlighting
# this one needs to come last
source ~/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2 >/dev/null
