#!/bin/bash

# Define file extensions to check
FILE_EXTENSIONS=("*.cpp" "*.c" "*.h" "*.hpp")

# Define directories to check
DIRECTORIES=("src") # Adjust as needed

# Initialize counters
TOTAL_FILES=0
FORMAT_ISSUES_FOUND=0

# Color codes
COLOR_BLUE="\033[34m"
COLOR_RED="\033[31m"
COLOR_GREEN="\033[32m"
COLOR_RESET="\033[0m"

echo -e "Checking file formatting..."

# Iterate through files and check formatting
for dir in "${DIRECTORIES[@]}"; do
    for ext in "${FILE_EXTENSIONS[@]}"; do
        # Find files and run clang-format in dry-run mode
        for file in $(find "$dir" -name "$ext"); do
            TOTAL_FILES=$((TOTAL_FILES + 1))
            if ! clang-format --dry-run --Werror "$file" >/dev/null 2>&1; then
                FORMAT_ISSUES_FOUND=1
                echo -e "${COLOR_RED}[Needs Formatting]${COLOR_RESET} $file"
            fi
        done
    done
done

# Report results
echo -e "Scanned $TOTAL_FILES files."
if [ $FORMAT_ISSUES_FOUND -eq 1 ]; then
    echo -e "You can fix unformatted files with:"
    echo -e "  clang-format -i \$(find ${DIRECTORIES[*]} -name '*.cpp' -o -name '*.c' -o -name '*.h' -o -name '*.hpp')\n"
    exit 1
else
    echo -e "All files are properly formatted!"
    exit 0
fi
