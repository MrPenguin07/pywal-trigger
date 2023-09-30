#!/bin/bash

# Define an array of possible backend names
backends=("haishoku" "colorz" "colorthief" "wal")

selected_backend=${backends[$(shuf -i 0-3 -n 1)]}
process_id=$(pgrep -o swaybg)

if [ -n "$process_id" ]; then
    command_line=$(ps -o cmd= -p "$process_id")

    if echo "$command_line" | grep -q "swaybg"; then
        path=$(echo "$command_line" | awk '{for(i=5;i<=NF;++i) printf "%s ", $i}' | sed 's/ $//')

        if [ -n "$path" ]; then
            wal -i "${path[@]}" --backend "$selected_backend"
            notify-send -i /usr/share/icons/pywal.png "Backend: $selected_backend"
            notify-send -i /usr/share/icons/pywal.png "Wallpaper: $(basename "${path[@]}")"
        else
            notify-send "No path found in the command line of swaybg."
        fi
    else
        notify-send "Error: Unable to find 'swaybg' in the command line of swaybg."
    fi
else
    notify-send "Error: swaybg process not found."
fi
