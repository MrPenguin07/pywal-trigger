

https://github.com/MrPenguin07/pywall-trigger/assets/127086564/fd91917b-971f-43ac-bd34-9bf44c93cb7b



# pywall-trigger
Simple scripts to trigger pywal while for SwayWM.
The video above shows it being executed via my SwayNC button.

Dependencies;
- Sway (swaybg)
- pywal (https://github.com/dylanaraps/pywal)
- inotify2

## The 2 Scripts:
pywal-trigger.sh
- Finds the currently set background image and passes it to pywal to generate colours, using a random backend.
- Subsequent executions will cycle through the pywal backends.
- Can be used _after_ pywal-wallpaper-trigger.sh to cycle backends.

pywal-wallpaper-trigger.sh
- Sets a random background image from your collection, then runs pywal over it to set the theme.
- Note: Set `$directory` on line 4 to your main wallpaper repository eg ~/wallpapers

### Notes
Small modifications can allow it to be used with different WM, or triggered by ranger in rifle.conf for example.
![image](https://github.com/MrPenguin07/pywall-trigger/assets/127086564/36aeebba-e6ea-4d10-93ae-1932b603b7af)

