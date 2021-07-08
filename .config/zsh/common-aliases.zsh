# Exa 
alias ls="exa --across"
alias la="exa -lah"
alias ll="exa -lh -s=extension"
alias l="exa -lah -s=extension"
alias lt="exa -Th -s=extension"
alias lg="exa -lh --git -s=extension"


# Docker
alias dk='docker'
alias dkc='docker container'
alias dkls='docker container ls'
alias dkl='docker container logs'
alias dks='docker service'
alias dki='docker image'
alias dm='docker-machine'
alias dkco='docker-compose'
alias startdocker='systemctl start docker'
alias dkstart='systemctl start docker'
alias dkcstop='docker stop $(docker ps -a -q)'
alias dkrmall='docker rm $(docker ps -aq)'
alias dkx='docker buildx'

#podman
alias pod='podman'
alias podls='podman container ls'
alias podc='podman container'
alias podl='podman container logs'


alias sudo='sudo '
alias nnn='nnn -doa'
alias k9s='k9s --readonly'
alias geoip='curl ipinfo.io | jq'
alias vim='nvim'
