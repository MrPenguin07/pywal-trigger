#!/bin/bash

# Check if deps are in $PATH
commands=("swaybg" "wal")

for cmd in "${commands[@]}"; do
    if ! command -v "$cmd" &> /dev/null; then
        echo "Error: $cmd not found in PATH. Exiting."
        exit 1
    fi
done

# Directory to search for image files
directory="~/wallpapers"

# Function to get a random image from the specified directory
get_random_image() {
    # Find a random image file in the specified directory and its subdirectories
    local random_image=$(find "$directory" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \) 2>/dev/null | sort -R | head -n 1)

    # Check if an image file was found
    if [ -z "$random_image" ]; then
        notify-send "No image files found in $directory or its subdirectories."
        exit 1
    fi

    echo "$random_image"
}

# Function to set the wallpaper
set_wallpaper() {
    local image_path="$1"

    # Kill running swaybg instances
    pkill swaybg

    # Check if swaybg was successfully killed
    if pgrep -x "swaybg" > /dev/null; then
        notify-send "Error: Failed to kill existing swaybg process."
        exit 1
    fi

    # Set the wallpaper using swaybg
    swaybg -m fill -i "$image_path" &
}

random_image=$(get_random_image)
absolute_path=$(realpath "$random_image")

set_wallpaper "$absolute_path"

# Define an array of possible backend names
backends=("haishoku" "colorz" "colorthief" "wal")
selected_backend=${backends[$(shuf -i 0-3 -n 1)]}

# Run the "wal" command with the extracted path and random backend
wal -i "$absolute_path" --backend "$selected_backend"

# Only run wal-telegram if it is present in $PATH
if command -v wal-telegram &> /dev/null; then
    wal-telegram --wal --tiled
fi

# Send a notification
file_name=$(basename "$absolute_path")
message=$(echo -e "Wallpaper: $file_name\nBackend: $selected_backend")
notify-send -i /usr/share/icons/pywal.png "$message"
