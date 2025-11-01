#!/bin/zsh

# -- Customization --
# Colors for the menu
selected_fg_color="\e[38;5;0m"  # Black
selected_bg_color="\e[48;5;220m" # Gold
unselected_fg_color="\e[38;5;255m" # White
unselected_bg_color="\e[0m" # Default background

# Menu options
options=("Option 1" "Option 2" "Option 3" "Exit")
search_query=""
selected=0

# Use 0-based arrays, which is more standard.
setopt ksh_arrays

update_filtered_options() {
  # Zsh's array filtering is powerful. The (#i) flag enables case-insensitivity.
  filtered_options=(${(@)options:#(#i)*${search_query}*})

  # The :i modifier returns 1-based indices, so we convert them to 0-based.
  local one_based_indices=(${(@)options:i(#i)*${search_query}*})
  original_indices=()
  for index in "${one_based_indices[@]}"; do
    original_indices+=((index - 1))
  done
}

display_menu() {
  # Loop from 0 to the number of filtered options minus one.
  for i in {0..$((${#filtered_options[@]} - 1))}; do
    if [[ $i -eq $selected ]]; then
      printf "%b%b%s%b\n" "${selected_fg_color}" "${selected_bg_color}" "${filtered_options[$i]}" "\e[0m"
    else
      printf "%b%b%s%b\n" "${unselected_fg_color}" "${unselected_bg_color}" "${filtered_options[$i]}" "\e[0m"
    fi
  done
  printf "\nSearch: %s" "$search_query"
}

handle_input() {
  local key
  read -k1 key # Read a single character

  case "$key" in
    $'\e') # Escape sequence for arrow keys
      read -k2 key
      case "$key" in
        '[A') # Up arrow
          ((selected--))
          if [[ $selected -lt 0 ]]; then
            selected=$(( ${#filtered_options[@]} - 1 ))
          fi
          ;;
        '[B') # Down arrow
          ((selected++))
          if [[ $selected -ge ${#filtered_options[@]} ]]; then
            selected=0
          fi
          ;;
      esac
      ;;
    $'\n') # Enter key
      return 0
      ;;
    $'\x7f') # Backspace
      if [ ${#search_query} -gt 0 ]; then
        search_query="${search_query%?}"
        selected=0
        update_filtered_options
      fi
      ;;
    *) # Any other character
      if [[ "$key" =~ '[[:print:]]' ]]; then
        search_query+="$key"
        selected=0
        update_filtered_options
      fi
      ;;
  esac
  return 1
}

# Initial setup
update_filtered_options

# Main loop
while true; do
  clear
  display_menu
  handle_input
  if [[ $? -eq 0 ]]; then
    break
  fi
done

# Execute selected option
if [[ ${#filtered_options} -gt 0 ]]; then
  # Use the 0-based selected index directly.
  original_selected=${original_indices[$selected]}
  case $original_selected in
    0)
      echo "Executing Option 1..."
      sleep 1
      ;;
    1)
      echo "Executing Option 2..."
      sleep 1
      ;;
    2)
      echo "Executing Option 3..."
      sleep 1
      ;;
    3)
      echo "Exiting..."
      sleep 1
      exit 0
      ;;
    *)
      echo "Invalid selection."
      exit 1
      ;;
  esac
fi
