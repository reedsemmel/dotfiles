# bashrc
# Mostly inspired by Gentoo's global bashrc.
# Has a custom prompt and a few useful aliases.

# Don't do anything if this shell isn't interactive.
if [[ $- != *i* ]]; then
    return
fi

# Shell configurations

shopt -s cdspell # I suck at typing
shopt -s checkhash
shopt -s checkjobs
shopt -s checkwinsize
shopt -s extglob
shopt -s globstar
shopt -s dotglob
shopt -s nullglob
shopt -s histappend
shopt -s interactive_comments
shopt -s no_empty_cmd_completion
shopt -s promptvars

# Aliases

alias ls="ls --color=auto"
alias grep="grep --color=auto"
alias ip="ip --color=auto"

alias l="ls -lah"
alias m="make -j$(nproc)"
alias v="vim"

alias g="git"
alias ga="git add"
alias gc="git commit" # /usr/bin/gc isn't too useful

# Prompt

prompt_user_host='\u'
prompt_second_line=' λ» '
if [[ -n "$SSH_CLIENT" ]] || [[ -n "$SSH_TTY" ]]; then
    prompt_user_host='\u@\h'
    prompt_second_line=' λ› '
fi

if [[ $(id -u) -eq 0 ]]; then
    prompt_second_line="\[\e[31m\]$prompt_second_line\[\e[0m\]"
else
    prompt_second_line="\[\e[32m\]$prompt_second_line\[\e[0m\]"
fi

prompt_time='\[\e[38;5;233m\e[48;5;255m\] \t '
prompt_user_host="\[\e[48;5;252m\] ${prompt_user_host} "
prompt_path='\[\e[48;5;249m\] \w '
prompt_status='$(declare -a x=(${PIPESTATUS[*]}); if [[ x[-1] -ne 0 ]]; then echo -ne "\[\e[41m\] ${x[@]} "; else echo -ne "\[\e[42m\] ${x[@]} "; fi)'

PS1="${prompt_time}${prompt_user_host}${prompt_path}${prompt_status}\[\e[0m\]\n${prompt_second_line}"

unset prompt_user_host
unset prompt_second_line
unset prompt_time
unset prompt_path
unset prompt_status

# enable bash completion in interactive shells
# Taken from Debian's /etc/bash.bashrc
# Might need to add another case if distros don't put it in these spots
if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
fi

if [[ ! -d "$HOME/.bash.d" ]]; then
    mkdir "$HOME/.bash.d"
fi

# Source local configurations
for f in $HOME/.bash.d/[0-9][0-9]*.bash; do
    if [[ -r $f ]]; then
        . $f
    fi
done

# Make sure our exit code on the first prompt will be 0
true
