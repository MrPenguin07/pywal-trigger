#!/bin/bash

# Directory to search for image files
directory="~/wallpapers"

# Find all image files in the specified directory and its subdirectories
readarray -d '' image_files < <(find "$directory" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \) -print0 2>/dev/null)

# Check if any image files were found
if [ ${#image_files[@]} -eq 0 ]; then
    notify-send "No image files found in $directory or its subdirectories."
    exit 1
fi

# Kill running swaybg instances
pkill swaybg

# Get a random image file
random_image=$(shuf -n 1 -e "${image_files[@]}")

# Get the absolute path of the random image
absolute_path=$(realpath "$random_image")

# Set the wallpaper using swaybg
swaybg -m fill -i "$absolute_path" &

# Define an array of possible backend names
backends=("haishoku" "colorz" "colorthief" "wal")

# Select a random backend from the array
selected_backend=${backends[$(shuf -i 0-3 -n 1)]}

# Run the "wal" command with the extracted path and random backend
wal -i "$absolute_path" --backend "$selected_backend"

# Send a notification with the selected backend name
notify-send -i /usr/share/icons/pywal.png "Backend: $selected_backend"

# Send a notification with the file name
file_name=$(basename "$absolute_path")
notify-send -i /usr/share/icons/pywal.png "Wallpaper: $file_name"
