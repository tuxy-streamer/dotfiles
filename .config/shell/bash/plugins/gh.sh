ghrc() {
	repo=$(gh repo list | fzf | awk '{print $1}')
	gh repo clone $repo
}

ghrd() {
	repo=$(gh repo list | fzf | awk '{print $1}')
	echo "$repo" | xclip -selection clipboard
	gh repo delete $repo
}

ghra() {
	repo=$(gh repo list | fzf | awk '{print $1}')
	gh repo archive $repo
}

ghre() {
	repo=$(gh repo list | fzf | awk '{print $1}')
	gh repo edit $repo
}
