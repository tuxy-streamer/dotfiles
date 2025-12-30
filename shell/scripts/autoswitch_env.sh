cd() {
  builtin cd "$@" || return
  [[ -d ".venv" ]] && [[ -z "$VIRTUAL_ENV" ]] && source .venv/bin/activate
  [[ ! -d ".venv" ]] && [[ -n "$VIRTUAL_ENV" ]] && type deactivate >/dev/null 2>&1 && deactivate
}
