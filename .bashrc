# ~/.bashrc: executed by bash(1) for non-login shells.

# set -x

# DEBUG
#PS4='+ $(date "+%s.%N")\011 '
#exec 3>&2 2>/tmp/bashstart.$$.log
#set -x

setxkbmap -layout gb

export BASH_ENV="$HOME/.bashrc"

# Bin/ in $PATH
export PATH="$PATH:$HOME/Bin/"

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

export TERM=screen-256color

source $HOME/.alacritty.bash
#alias alacritty='WAYLAND_DISPLAY= alacritty'
alias alacritty='env WINIT_UNIX_BACKEND=x11 alacritty'

# LOCALE
export LC_CTYPE=en_GB.UTF-8
export LC_ALL=en_GB.UTF-8

# pwd in prompt
export MYPWD='$(echo -n "${PWD/#$HOME/~}" | awk -F "/" '"'"'{if (length($0) > 14) { if (NF>4) print $1 "/" $2 "/.../" $(NF-1) "/" $NF; else if (NF>3) print $1 "/" $2 "/.../" $NF; else print $1 "/.../" $NF; } else print $0;}'"'"')'

# git info
source $HOME/.git-completion.bash
source $HOME/.git-prompt.sh
GIT_PS1_SHOWDIRTYSTATE=1

# bash PROMPT
PS1='\[\e]0;$(eval "echo ${MYPWD}")\a\]\[\e[0;32m\]\u\[\e[92m@\h\]\[\e[m\]\[\e[1;32m\]$(__git_ps1 " (%s)") R$(eval "echo ${R_VERSION}") \n \[\e[1;34m\]$(eval "echo ${MYPWD}") \$ \[\e[m\]'

# PROMPT IF in ssh session
if [ -n "$SSH_CLIENT" ]; then

PS1='\[\e]0;$(eval "echo ${MYPWD}")\a\]\[\e[0;32m\]\u\[\e[91m@\h\]\[\e[m\]\[\e[1;32m\]$(__git_ps1 " (%s)") R$(eval "echo ${R_VERSION}") \n \[\e[1;34m\]$(eval "echo ${MYPWD}") \$ \[\e[m\]'

fi

# bash-completion
[[ $PS1 && -f /usr/share/bash-completion/bash_completion ]] && \
    . /usr/share/bash-completion/bash_completion

# enable color support of ls
export LS_OPTIONS='--color=auto --sort=extension --time-style=locale --group-directories-first'
eval `dircolors`
alias ls='ls $LS_OPTIONS'

# some aliases
alias l='ls -Glh'
alias la='ls -Ag'

# bash history
export HISTIGNORE="&:ls:[bf]g:exit"
if [[ $- == *i* ]]
then
	bind '"\e[A": history-search-backward'
	bind '"\e[B": history-search-forward'
fi

export HISTTIMEFORMAT=' %d.%m-%Y %H:%M:%S '
export HISTSIZE=1000000
export HISTFILESIZE=1000000000
export HISTCONTROL=erasedups
export PROMPT_COMMAND='history -a'

# default editor
export EDITOR=neovim
export CVSEDITOR='neovim -f'
alias n='neovim'

# exit
alias x='exit'

# RHIST
export R_HISTFILE=~/.Rhistory

# KEEP PKG SOURCE in check
export R_KEEP_PKG_SOURCE=yes

# R
alias R='$HOME/R/R$R_VERSION/bin/R --no-save'
alias Rscript='$HOME/R/R$R_VERSION/bin/Rscript'

# R 4.5
function R45 {
  export R_LIBS_USER="$HOME/R/x86_64-pc-linux-gnu-library/4.5/"
  export R_VERSION="450"
  ln -f -s $HOME/R/R$R_VERSION/bin/R $HOME/Bin/R
  ln -f -s $HOME/R/R$R_VERSION/bin/Rscript $HOME/Bin/Rscript
  }

# R 4.4
function R44 {
  export R_LIBS_USER="$HOME/R/x86_64-pc-linux-gnu-library/4.4/"
  export R_VERSION="443"
  ln -f -s $HOME/R/R$R_VERSION/bin/R $HOME/Bin/R
  ln -f -s $HOME/R/R$R_VERSION/bin/Rscript $HOME/Bin/Rscript
  }

# R 4.3
function R43 {
  export R_LIBS_USER="$HOME/R/x86_64-pc-linux-gnu-library/4.3/"
  export R_VERSION="433"
  ln -f -s $HOME/R/R$R_VERSION/bin/R $HOME/Bin/R
  ln -f -s $HOME/R/R$R_VERSION/bin/Rscript $HOME/Bin/Rscript
  }

# R 4.2
function R42 {
  export R_LIBS_USER="$HOME/R/x86_64-pc-linux-gnu-library/4.2/"
  export R_VERSION="423"
  ln -f -s $HOME/R/R$R_VERSION/bin/R $HOME/Bin/R
  ln -f -s $HOME/R/R$R_VERSION/bin/Rscript $HOME/Bin/Rscript
  }

# R 4.1
function R41 {
  export R_LIBS_USER="$HOME/R/x86_64-pc-linux-gnu-library/4.1/"
  export R_VERSION="412"
  ln -f -s $HOME/R/R$R_VERSION/bin/R $HOME/Bin/R
  ln -f -s $HOME/R/R$R_VERSION/bin/Rscript $HOME/Bin/Rscript
  }

# CURRENT R
R45

# pandoc completion
source $HOME/.pandoc-completion.bash

# less options
export LESS="-R"

# git alias
alias g="git"
alias ga="git add"
alias ungit='find . -name ".git" -exec rm -rf {} \;'

# autojump
. /usr/share/autojump/autojump.bash
export AUTOJUMP_IGNORE_CASE=1
export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND ;} history -a"

# zoxide
# eval "$(zoxide init bash)"

# TEXMFHOME
export TEXMFHOME=$HOME/Library/texmf/

# make
alias makej="make -j 4"

# pubs
PUBSDIR=$HOME/Library/Pubs
BIBINPUTS=$HOME/Library/Pubs
export BIBINPUTS

eval "$(register-python-argcomplete pubs)"
eval "$(register-python-argcomplete pipx)"


# cheat
export CHEATCOLORS=true

# vpnwur
function vpnwur {
  sudo openfortivpn mol02.wur.nl:443 -u mosqu003 -p 'Y9h]>4jam"WRQza' --trusted-cert=c715f6a354a31a9d3ce44f0dbc81bc88ff6d61c04b1e61fc3a421fbcf40945b8
}

function vpnpedro {
  sudo openfortivpn fombitars-vpn.asuscomm.com:443 -u iago -p "LbnK-sGWFGT*qZg.jwW2" --trusted-cert=*4_vhZ.tyf6cyFiedXDNUKcB!ZK4TA
}

# syncbruce 
function syncbruce {
  rsync -tvrhP --update --exclude '.git' $1 brucef:$1
}

# BACKUP

folders=('Active' 'Backlog' 'Bin' 'Desktop' 'Learn' 'Library' 'Projects' 'Work')

# polbo - backup to local NAS
function polbo {
for folder in ${folders[@]};
  do
    echo "$folder"
    rsync -ravz --progress --delete --cvs-exclude -e 'ssh -p 4156' $HOME/$folder/  mosqu003@192.168.1.90:$folder
  done

  rsync -ravz -e 'ssh -p 4156' --delete .config/alacritty/  mosqu003@192.168.1.90:.config/alacritty
  rsync -ravz -e 'ssh -p 4156' --delete .config/nvim/  mosqu003@192.168.1.90:.config/nvim
  rsync -ravz -e 'ssh -p 4156' --delete .bashrc mosqu003@192.168.1.90:bash/.bashrc
  rsync -ravz -e 'ssh -p 4156' --delete .Rprofile mosqu003@192.168.1.90:bash/.Rprofile

}

# polboi - backup to NAS from away
function polboi {
for folder in ${folders[@]};
  do
    echo "$folder"
    rsync -ravz --progress --delete -e 'ssh -p 49153' $folder/ mosqueira.synology.me:$folder
  done
}

# choco
function choco {
for folder in ${folders[@]};
  do
    echo "$folder"
    rsync -ravz --delete --progress $folder/ /media/mosqu003/Choco/mosqu003/$folder
  done
}

# vieira
function vieira {
for folder in ${folders[@]};
  do
    echo "$folder"
    rsync -ravz --delete --progress $folder/ /media/mosqu003/Vieira/$folder
  done
}

# onedrive
function onedrive {
for folder in ${folders[@]};
  do
    echo "$folder"
    rclone sync $HOME/$folder "WUR":Home/$folder --progress
    echo"\n"
  done
}

# function borgmosqu003
function borgmosqu003 {
borg create --exclude-from /home/mosqu003/.borg.exclude --list /media/mosqu003/Pota/mosqu003/Borg/mosqu003::archive-{user}-{now} ~/.
}

# function today
function today {
n  ~/Notes/Journal/$(date '+%Y/%m/%d-%m-%Y').md
}

function conf {
  rsync -avz -R ~/./.config/nvim ~/Library/Code/conf/
  rsync -avz -R ~/./.bashrc ~/Library/Code/conf/
  rsync -avz -R ~/./.Rprofile ~/Library/Code/conf/
  rsync -avz -R ~/./.config/alacritty ~/Library/Code/conf/
  rsync -avz -R ~/./.pandoc-completion.bash ~/Library/Code/conf/
  rsync -avz -R ~/./.gitconfig ~/Library/Code/conf/
  rsync -avz -R ~/./.ssh ~/Library/Code/conf/
  rsync -avz -R ~/./.config/nemo ~/Library/Code/conf/
  rsync -avz -R ~/./.pubsrc ~/Library/Code/conf/

  cd ~/Library/Code/conf
  git pull
  git add .
  git cm "`date`"
  git push
}

# DEBUG
#set +x
#exec 2>&3 3>&-
#

# LO
export LD_LIBRARY_PATH=:/usr/lib/libreoffice/program:/usr/lib:/usr/lib/x86_64-linux-gnu

# Set up fzf key bindings and fuzzy completion
# eval "$(fzf --bash)"
alias fvim='vim $(fzf)'

# findgrep
function findgrep {
find . -name $1 -exec grep -H  $2 {} \;
}

# getpdfs
function getpdfs {
  wget --recursive --level=1 --accept pdf --no-directories $1
}

# Created by `pipx` on 2024-12-23 12:08:31
export PATH="$PATH:/home/mosqu003/.local/bin"

# world time
function tz() {
  for tz in Europe/Amsterdam Europe/London Australia/Hobart Asia/Tokyo US/Pacific; do
    echo -e "$tz:\t\t$(TZ=$tz date -R)"
  done
}

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
