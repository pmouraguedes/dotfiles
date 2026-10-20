#!/usr/bin/env bash
# Narrate a silent video: play it while recording your mic, then mux the audio in.
# Usage: ./narrate.sh input.mp4 [output.mp4]
set -euo pipefail

MIC="alsa_input.usb-EMEET_EMEET_SmartCam_Nova_A250121000804805-02.analog-stereo"

IN="${1:?usage: ./narrate.sh input.mp4 [output.mp4]}"
OUT="${2:-${IN%.*}_narrated.mp4}"
TMP_AUDIO="$(mktemp --suffix=.wav)"
trap 'rm -f "$TMP_AUDIO"' EXIT

echo ">> Recording from: $MIC"
echo ">> When the video window opens, narrate. Press 'q' in the video to stop."
echo

# Start mic recording in the background.
ffmpeg -hide_banner -loglevel error -y \
  -f pulse -i "$MIC" "$TMP_AUDIO" &
REC_PID=$!

# Tiny head start so we don't clip the first word, then play the video.
sleep 0.3
mpv --no-config --keep-open=no "$IN"

# Video closed -> stop recording cleanly.
kill -INT "$REC_PID" 2>/dev/null || true
wait "$REC_PID" 2>/dev/null || true

echo ">> Muxing narration into video..."
ffmpeg -hide_banner -loglevel error -y \
  -i "$IN" -i "$TMP_AUDIO" \
  -map 0:v:0 -map 1:a:0 \
  -c:v copy -c:a aac -b:a 192k \
  -shortest "$OUT"

echo ">> Done: $OUT"
