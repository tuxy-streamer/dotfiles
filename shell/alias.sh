alias lah='ls -lah --group-directories-first --color=always'

os=$(grep '^ID=' /etc/os-release | cut -d'=' -f2 | tr -d '"')
case "$os" in
    arch)
        alias u="sudo pacman -Syu"
        alias i="sudo pacman -Sy"
        alias r="sudo pacman -Rcns"
        alias c="sudo pacman -Scc"
        alias s="sudo pacman -Ss"
        [[ $(command -v paru) ]] && {
            alias auru="paru -Syu"
            alias auri="paru -Sy"
            alias aurre="paru -Rcns"
            alias aurc="paru -Scc"
            alias aurs="paru -Ss"
        }
        [[ $(command -v yay) ]] && {
            alias auru="yay -Syu"
            alias auri="yay -Sy"
            alias aurre="yay -Rcns"
            alias aurc="yay -Scc"
            alias aurs="yay -Ss"
        }
        ;;
	fedora)
		alias u="sudo dnf -y update"
		alias i="sudo dnf -y install"
		alias r="sudo dnf -y remove"
		alias c="sudo dnf -y clean all"
		alias s="sudo dnf search"
		;;
    *)
        echo "Unsupported OS: $os"
        ;;
esac
