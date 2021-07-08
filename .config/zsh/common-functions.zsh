# Docker

# execute bash in docker container
dex() {
	docker container exec -it `docker container ls | grep $1 | awk '{print $1}'` bash
};

# show docker logs by grep search
dklogs() {
	docker container logs `docker container ls | grep $1 | awk '{print $1}'`
}

# show all alias docker related
dalias() { alias | grep 'docker' | sed "s/^\([^=]*\)=\(.*\)/\1 => \2/"| sed "s/['|\']//g" | sort; }

#vi-mode prompt

# Use nnn to switch directories and bind it to ctrl-g
n()
{
    export NNN_TMPFILE=$HOME/.config/nnn/.lastd

    nnn "$@"

    if [ -f $NNN_TMPFILE ]; then
            . $NNN_TMPFILE
            rm $NNN_TMPFILE
    fi
	}

bindkey -s '^g' 'n\n'


#vi-mode prompt
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.


#code () { VSCODE_CWD="$PWD" open -n -b com.microsoft.VSCodeInsiders --args $* ;}

function gi() {
	curl -sLw "\n" https://www.toptal.com/developers/gitignore/api/$@ ;
}

