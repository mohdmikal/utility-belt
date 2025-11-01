
#!/bin/bash

# -- Customization --
# Colors for the menu
selected_fg_color="\e[38;5;0m"  # Black
selected_bg_color="\e[48;5;220m" # Gold
unselected_fg_color="\e[38;5;255m" # White
unselected_bg_color="\e[0m" # Default background

# Function to update filtered options
update_filtered_options() {
  filtered_options=()
  original_indices=()
  for i in "${!options[@]}"; do
    # Case-insensitive search
    if [[ "${options[$i],,}" == *"${search_query,,}"* ]]; then
      filtered_options+=("${options[$i]}")
      original_indices+=($i)
    fi
  done
}

# Function to display the menu
display_menu() {
  local i
  for i in "${!filtered_options[@]}"; do
    if [[ $i -eq $selected ]]; then
      # Use printf for reliable escape sequence handling in debug output
      printf "%b%b%s%b\n" "${selected_fg_color}" "${selected_bg_color}" "${filtered_options[$i]}" "\e[0m"
    else
      printf "%b%b%s%b\n" "${unselected_fg_color}" "${unselected_bg_color}" "${filtered_options[$i]}" "\e[0m"
    fi
  done
  printf "\nSearch: %s" "$search_query"
}

# Function to handle arrow key input
handle_input() {
  local key
  read -rsn1 key
  if [[ "$key" == $'\e' ]]; then
    read -rsn2 key
    if [[ "$key" == "[A" ]]; then # Up arrow
      ((selected--))
      if [[ $selected -lt 0 ]]; then
        selected=$(( ${#filtered_options[@]} - 1 ))
      fi
    elif [[ "$key" == "[B" ]]; then # Down arrow
      ((selected++))
      if [[ $selected -ge ${#filtered_options[@]} ]]; then
        selected=0
      fi
    fi
  elif [[ "$key" == $'\n' ]]; then # Enter key
    return 0 # Indicate selection
  elif [[ "$key" == $'\x7f' ]]; then # Backspace
    # Remove the last character from the search query
    if [ ${#search_query} -gt 0 ]; then
      search_query="${search_query%?}"
      selected=0 # Reset selection
      update_filtered_options
    fi
  else
    # Append the character to the search query, handle spaces
    case "$key" in
      ' ') search_query+=' ' ;;
      *[[:print:]]*) search_query+="$key" ;;
    esac
    selected=0 # Reset selection
    update_filtered_options
  fi
  return 1 # Indicate no selection
}

# Menu options
options=("Option 1" "Option 2" "Option 3" "Exit")
search_query=""
filtered_options=()
original_indices=()
update_filtered_options

# Initial selection
selected=0

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
# Get the original index of the selected option
original_selected=${original_indices[$selected]}
case $original_selected in
  0)
    echo "Executing Option 1..."
    # Add your code for Option 1 here
    sleep 1
    ;;
  1)
    echo "Executing Option 2..."
    # Add your code for Option 2 here
    sleep 1
    ;;
  2)
    echo "Executing Option 3..."
    # Add your code for Option 3 here
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