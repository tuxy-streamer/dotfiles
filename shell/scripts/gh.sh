#!/usr/bin/env bash

ghrd(){
  local selected
  selected=$(gh repo list | awk '{print $1}' | fzf)
  gh repo delete "$selected" --yes
}
