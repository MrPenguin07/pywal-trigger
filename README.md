

https://github.com/MrPenguin07/pywall-trigger/assets/127086564/fd91917b-971f-43ac-bd34-9bf44c93cb7b



# ![image](https://github.com/MrPenguin07/pywal-trigger/assets/127086564/d6fcc330-4396-4e71-9f53-c830c835404c) pywall-trigger 
Simple scripts to trigger pywal, designed for SwayWM.
The video above shows the script being executed via my shortcut SwayNC button, you can use a `bindsym` or hotkey etc.

Dependencies;
- Sway (swaybg)
- pywal (https://github.com/dylanaraps/pywal)
- wal-telegram (https://github.com/guillaumeboehm/wal-telegram) (optional)
- inotify2 (optional notifications)

## INSTALL;

- `git clone` or `wget` scripts to your chosen location, perhaps in your $PATH. 

- Place pywal.png in /usr/share/icons/

Make them executable:

- `$ chmod +x pywal*.sh`

## The 2 Scripts:
pywal-trigger.sh
- Finds the currently set background image and passes it to pywal to generate colours, using a random backend.
- Subsequent executions will cycle through the pywal backends.
- Can be used _after_ pywal-wallpaper-trigger.sh to cycle backends if you like the current wallpaper but want new colorschemes generated for it.

pywal-wallpaper-trigger.sh
- Sets a random background image from your collection, then runs pywal over it to set the theme.
- Note: Set `$directory` on line 14 to your main wallpaper repository eg ~/wallpapers

### Notes
Some modifications can allow these to be used with different WM, or triggered by ranger in rifle.conf for example.




