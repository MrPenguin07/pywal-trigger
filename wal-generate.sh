#!/bin/bash

# Define the path to the azotebg file
azotebg_file="$HOME/.azotebg"

# Define an array of possible backend names
backends=("haishoku" "colorz" "colorthief" "wal")

# Select a random backend from the array
selected_backend=${backends[$(shuf -i 0-3 -n 1)]}

# Read the azotebg file and find the first line containing "swaybg"
line=$(grep "swaybg -o" "$azotebg_file" | head -n 1)

if [ -n "$line" ]; then
  # Extract the path
  path=$(echo "$line" | grep -o '"[^"]*"' | sed 's/"//g')

  if [ -n "$path" ]; then
    # Extract the file name from the path
    file_name=$(basename "$path")

    # Run the "wal" command with the extracted path and random backend
    wal -i "$path" --backend "$selected_backend"

    # Send a notification with the selected backend name
    notify-send -i /usr/share/icons/pywal.png "Backend used: $selected_backend"

    # Send a notification with the file name
    notify-send -i /usr/share/icons/pywal.png "Wallpaper set to: $file_name"

  else
    notify-send "No path found in the line containing 'swaybg' in $azotebg_file"
  fi
else
  notify-send "No line containing 'swaybg' found in $azotebg_file"
fi
