mmpv() {
	while true; do
		read -r profile link

		[[ -z "$profile" || -z "$link" ]] && echo "Provide both profile and link." && continue

		mpv --profile="$profile" "$link"

		echo "Finished playing video. Please enter new profile and link."
	done
}
