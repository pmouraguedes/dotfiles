# (process:249735): Adwaita-WARNING **: 10:48:48.557: Using GtkSettings:gtk-application-prefer-dark-theme with libadwaita is unsupported. Please use AdwStyleManager:color-scheme instead.
export GTK_THEME=Adwaita:dark
export QT_STYLE_OVERRIDE=Adwaita-Dark

# dunst - a customizable and lightweight notification-daemon
dunst &
sh ~/.screenlayout/home3.sh
# feh — image viewer and cataloguer
# set wallpaper
feh --bg-scale ~/Wallpapers/RedFoliageTempleJapaneseArtWallpaper.jpg
picom &
# mouse buttons
xmodmap ~/.Xmodmap
dwmblocks &
# https://commandmasters.com/commands/xset-linux/
# screen saver off
xset s off
# xset s 60 3600
# xscreensaver -no-splash &
# power management timer
# xset -dpms
xset dpms 1800 0 0
# keyboard: delay; repeat rate; 
xset r rate 300 50
# right alt as compose key
setxkbmap -layout us -option '' -option compose:ralt
# workaround for java apps
wmname LG3D
dropbox-cli start &
xrdb -merge ~/.Xresources
systemctl --user import-environment DISPLAY XAUTHORITY
exec ~/dotfiles/scripts/startdwm
