## Dotfiles
This is a simple documentation of my current setup

##### Main Components
* Debian
* Gnome GTK 3 Dark Theme
* i3 (window manager)
* i3 gaps (space between windows)
* i3-lock-color (custom lock screen)
* dunst (notifications)
* FontAwesome


##### Components referenced by i3
* xbacklight (screen brightness manager)
* amixer (sound manager)
* nm-applet (network manager)
* firefox

##### Dependencies
i3-lock-color:
https://github.com/chrjguill/i3lock-color
i3gaps for debian:
https://github.com/maestrogerardo/i3-gaps-deb 

##### i3 config files
The config files of i3 are located in ~/.config/i3
* config: This is the main i3 configuration file. This file might produce errors when the programs referenced by the file are not installed.
* i3status.conf: contains the format of the i3bar. It depends on icons of AwesomeFont. 
