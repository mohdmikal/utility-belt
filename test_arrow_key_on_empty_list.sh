#!/bin/bash
set -u # This will cause an error if we try to use an unbound variable.

filtered_options=()
selected=0

# Simulate pressing the up arrow key
if [[ ${#filtered_options[@]} -gt 0 ]]; then
  ((selected--))
  if [[ $selected -lt 0 ]]; then
    selected=$(( ${#filtered_options[@]} - 1 ))
  fi
fi

# If the script reaches this point, the bug is fixed
exit 0
