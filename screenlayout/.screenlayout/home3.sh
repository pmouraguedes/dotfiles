#!/bin/sh
# Output names depend on which GPU drives which port (they changed with the
# nvidia driver and will change again when the LG moves from the dock to
# mini DP), so look them up instead of hard-coding them.
connected() { xrandr --query | awk -v re="$1" '$2 == "connected" && $1 ~ re {print $1; exit}'; }

samsung=$(connected '^HDMI-')
lg=$(connected '^DP-')

args=""
for panel in $(xrandr --query | awk '$1 ~ /^eDP-/ {print $1}'); do
  args="$args --output $panel --off"
done
[ -n "$samsung" ] && args="$args --output $samsung --mode 3840x2160 --pos 0x0 --rotate normal"
[ -n "$lg" ] && args="$args --output $lg --primary --mode 3840x2160 --pos 3840x0 --rotate normal"

# shellcheck disable=SC2086
xrandr $args
