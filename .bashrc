# bashrc
# Mostly inspired by Gentoo's global bashrc.
# Has a custom prompt and a few useful aliases.

# Don't do anything if this shell isn't interactive.
if [[ $- != *i* ]]; then
    return
fi


# History

HISTSIZE=5000
HISTFILESIZE=5000
export HISTCONTROL=ignoreboth:erasedups

# Shell configurations

shopt -s cdspell # I suck at typing
shopt -s checkhash
shopt -s checkjobs
shopt -s checkwinsize
shopt -s extglob
shopt -s globstar
shopt -s histappend
shopt -s interactive_comments
shopt -s no_empty_cmd_completion
shopt -s promptvars

# Aliases

alias ls="ls --color=auto"
alias grep="grep --color=auto"
alias egrep="egrep --color=auto"

type -P nvim >/dev/null && alias vim="nvim"
type -P doas >/dev/null && alias sudo="doas"

alias d="sudo"
alias k="kubectl"
alias l="ls -lah"
alias m="make"
alias s="sudo"
alias v="vim"

alias g="git"
alias ga="git add"
alias gc="git commit" # /usr/bin/gc isn't too useful

# Completion

if [[ -r "$HOME/.bash_sources/kubectl-completion.sh" ]]; then 
	. "$HOME/.bash_sources/kubectl-completion.sh"
	complete -F __start_kubectl k
fi

# Prompt

prompt_user_host='\u'
prompt_second_line=' λ» '
if [[ -n "$SSH_CLIENT" ]] || [[ -n "$SSH_TTY" ]]; then
	prompt_user_host='\u@\h'
	prompt_second_line=' λ› '
fi

if [[ $(id -u) -eq 0 ]]; then
	prompt_second_line="\e[31m$prompt_second_line\e[0m"
else
	prompt_second_line="\e[32m$prompt_second_line\e[0m"
fi

if [[ -r "$HOME/.bash_sources/git-prompt.sh" ]]; then
	. "$HOME/.bash_sources/git-prompt.sh"
	prompt_git='\[\e[48;5;246m\]$(__git_ps1 " (%s) ")'
else
	prompt_git=''
fi


prompt_time='\[\e[38;5;233m\e[48;5;255m\] \t '
prompt_user_host="\[\e[48;5;252m\] ${prompt_user_host} "
prompt_path='\[\e[48;5;249m\] \w '
prompt_status='$(declare -a x=(${PIPESTATUS[*]}); if [[ x[-1] -ne 0 ]]; then echo -ne "\e[41m ${x[@]} "; else echo -ne "\e[42m ${x[@]} "; fi)'

PS1="${prompt_time}${prompt_user_host}${prompt_path}${prompt_git}${prompt_status}\e[0m\n${prompt_second_line}"

unset prompt_user_host
unset prompt_second_line
unset prompt_git
unset prompt_time
unset prompt_path
unset prompt_status

