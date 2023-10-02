#!/bin/bash

# Check dependencies are in $PATH
commands=("swaybg" "wal")

for cmd in "${commands[@]}"; do
    if ! command -v "$cmd" &> /dev/null; then
        echo "Error: $cmd not found in PATH. Exiting."
        exit 1
    fi
done

# Get the image path being used by swaybg
get_swaybg_path() {
local command_line=$(pgrep -o -a swaybg | awk '{print substr($0, index($0,$3))}')

    if [ -z "$command_line" ]; then
        notify-send "Error: swaybg process not found."
        exit 1
    fi


    local path=$(echo "$command_line" | awk '{for(i=4;i<=NF;++i) printf "%s ", $i}' | sed 's/ $//')

    if [ -z "$path" ]; then
        notify-send "Error: Unable to fetch image path from swaybg."
        exit 1
    fi

    echo "$path"
}

# Setting the wallpaper
set_wallpaper() {
    local path="$1"
    local backend="$2"

    wal -i "$path" --backend "$backend"
    if command -v wal-telegram &> /dev/null; then
        wal-telegram --wal --tiled
    fi

    local message=$(echo -e "Wallpaper: $(basename "$path")\nBackend: $backend")
    notify-send -i /usr/share/icons/pywal.png "$message"
}


# Define backends
backends=("haishoku" "colorz" "colorthief" "wal")
selected_backend=${backends[$(shuf -i 0-3 -n 1)]}

path=$(get_swaybg_path)
if [ -n "$path" ]; then
    set_wallpaper "$path" "$selected_backend"
else
    notify-send "No path found from the command line of swaybg."
fi
