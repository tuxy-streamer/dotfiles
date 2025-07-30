gitb() {
	branch=$(git branch -l | sed '/*/d' | fzf)
	git checkout "$branch"
}

gitr() {
	basebranch=$(git branch -l | sed 's/*/ /g' | fzf | sed 's/ //g')
	rebasingbranch=$(git branch -l | sed "/$basebranch/d" | sed 's/*/ /g' | fzf | sed 's/ //g')
	echo "Choose your base branch: $basebranch "
	echo "Choose your rebasing branch: $rebasingbranch"
	echo -n "Do you want to continue rebasing ? (y/n) "
	read -r rebase_input
	[[ "$rebase_input" == 'Y' || "$rebase_input" == 'y' ]] && git checkout "$rebasingbranch" && git rebase "$basebranch" && echo "$rebasingbranch is rebased on $basebranch"
}
