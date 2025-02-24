
#!/bin/bash

# Function to display the menu
display_menu() {
  local i
  for i in "${!options[@]}"; do
    if [[ $i -eq $selected ]]; then
      # Use printf for reliable escape sequence handling in debug output
      printf "%b\n" "\e[7m${options[$i]}\e[0m"
    else
      echo "${options[$i]}"
    fi
  done
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
        selected=$(( ${#options[@]} - 1 ))
      fi
    elif [[ "$key" == "[B" ]]; then # Down arrow
      ((selected++))
      if [[ $selected -ge ${#options[@]} ]]; then
        selected=0
      fi
    elif [[ "$key" == "[C" ]]; then #right arrow
      #do nothing
      true
    elif [[ "$key" == "[D" ]]; then #left arrow
      #do nothing
      true
    fi
  elif [[ "$key" == $'\n' ]]; then # Enter key
    return 0 # Indicate selection
  else
    return 1 # Indicate no selection
  fi
}

# Menu options
options=("Option 1" "Option 2" "Option 3" "Exit")

# Initial selection
selected=0

# Main loop
while true; do
  clear
  display_menu
  if handle_input; then
    continue
  else
    break
  fi
done

# Execute selected option
case $selected in
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