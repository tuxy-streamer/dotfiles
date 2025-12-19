book_list=$(fd . -t file "$BOOK_LIBRARY")

get_books() {
  local -a book_names=()
  local book

  while IFS= read -r book; do
    book="${book##*/}"
    book="${book%.pdf}"
    book_names+=("$book")
  done <<<"$book_list"
  printf "%s\n" "${book_names[@]}"
}

open_book() {
  local selected
  local book_path

  selected=$(get_books | rofi -dmenu)

  [[ -n "$selected" ]] && book_path=$(echo "$book_list" | rg "${selected}\.pdf$") && zathura "$book_path"
}
