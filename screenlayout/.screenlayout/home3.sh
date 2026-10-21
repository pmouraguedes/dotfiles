#!/bin/sh
# Output names depend on which GPU drives which port (with the nvidia driver
# the laptop panel is DP-0, not eDP-1, and the LG's name changes between the
# dock and mini DP), so identify the monitors by the model name in their EDID.

# Print "<output> <edid hex>" for every connected output.
edids() {
  xrandr --verbose | awk '
    $2 == "connected" { out = $1; hex = ""; next }
    $2 == "disconnected" { out = ""; next }
    out && /EDID:/ { inedid = 1; next }
    inedid && /^[ \t]+[0-9a-f]+$/ { gsub(/[ \t]/, ""); hex = hex $0; next }
    inedid { inedid = 0; print out, hex; out = "" }'
}

hex() { printf '%s' "$1" | od -An -tx1 | tr -d ' \n'; }

samsung_id=$(hex 'LS32A70')
lg_id=$(hex 'LG HDR 4K')

samsung="" lg=""
while read -r output edid; do
  case $edid in
    *"$samsung_id"*) samsung=$output ;;
    *"$lg_id"*) lg=$output ;;
  esac
done <<EOF
$(edids)
EOF

# Away from the desk: leave whatever is connected (e.g. the laptop panel) alone.
[ -z "$samsung" ] && [ -z "$lg" ] && exit 0

args=""
for output in $(xrandr --query | awk '$2 == "connected" {print $1}'); do
  [ "$output" = "$samsung" ] || [ "$output" = "$lg" ] || args="$args --output $output --off"
done
[ -n "$samsung" ] && args="$args --output $samsung --mode 3840x2160 --pos 0x0 --rotate normal"
[ -n "$lg" ] && args="$args --output $lg --primary --mode 3840x2160 --pos 3840x0 --rotate normal"

# shellcheck disable=SC2086
xrandr $args
