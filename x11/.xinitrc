export GTK_THEME=Adwaita-dark
export QT_STYLE_OVERRIDE=Adwaita-Dark

#xrandr --dpi 160
feh --bg-scale Wallpapers/samarkand.png
picom &
#rbd -load ~/.Xresources
xrdb -merge ~/.Xresources
xrandr --output DP-2 --dpi 144
exec dwm
