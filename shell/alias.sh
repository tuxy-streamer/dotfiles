alias lah='ls -lah --group-directories-first --color=always'
alias gr='cd /storage/projects/repos/$(ls /storage/projects/repos | fzf)'

os=$(grep '^ID=' /etc/os-release | cut -d'=' -f2 | tr -d '"')
case "$os" in
  arch)
    alias update-pkg="sudo pacman -Syu"
    alias install-pkg="sudo pacman -Sy"
    alias remove-pkg="sudo pacman -Rcns"
    alias clean-pkg-cache="sudo pacman -Scc"
    [[ $(command -v paru) ]] && \
      alias aur-update="paru -Syu" && \
      alias aur-install="paru -Sy" && \
      alias aur-remove="paru -Rcns"
      alias aur-clean-cache="paru -Scc"
    ;;
  *)
    command ...
    ;;
esac
