# Bash Menu with Arrow Key Navigation

This script provides a simple interactive menu in Bash that allows you to navigate options using the up and down arrow keys.

## Usage

1.  **Save the script:** Save the code as `bash-menu-arrow.sh` (or your preferred name).
2.  **Make it executable:** `chmod +x bash-menu-arrow.sh`
3.  **Run the script:** `./bash-menu-arrow.sh`

## Features

* **Arrow Key Navigation:** Use the up and down arrow keys to move between menu options.
* **Enter to Select:** Press Enter to execute the selected option.
* **Clear Screen:** The screen is cleared before each menu display.
* **Exit Option:** An "Exit" option is included for graceful termination.
* **Customizable:** Easily modify the menu options and the actions performed for each option.

## Customization

* **Menu Options:**
    * Edit the `options` array in the script to change the menu items.
    * Example: `options=("Option 1" "Option 2" "Option 3" "Exit")`
* **Option Actions:**
    * Replace the placeholder `echo "Executing Option..."` and `sleep 1` lines within the `case` statement with your desired commands.


## Notes
* This script requires Bash.
* Ensure your terminal supports ANSI escape codes for the highlighting to work correctly.

## Contributing
Feel free to fork this repository and submit pull requests for any improvements or bug fixes.