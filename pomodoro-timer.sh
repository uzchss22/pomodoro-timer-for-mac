#!/bin/bash

# Default timer settings:
default_study=25          # Study duration in minutes
default_short_break=5     # Short break duration in minutes
default_long_interval=2   # Number of sessions before a long break (0 = skip long breaks)
default_long_break=20     # Long break duration in minutes

# Sound settings:
sound="/System/Library/Sounds/Glass.aiff" # Default macOS alert sound


study_minutes=${1:-$default_study}
short_break=${2:-$default_short_break}
long_break_interval=${3:-$default_long_interval}
long_break=${4:-$default_long_break}

session=1

echo "🍅 Starting Pomodoro Timer!"
echo "Study Time: $study_minutes min"
echo "Short Break: $short_break min"

if (( long_break_interval > 0 )); then
  echo "Long Break: $long_break min every $long_break_interval sessions"
else
  echo "Long breaks disabled (interval = 0)"
fi

while true; do
  echo ""
  echo "🧠 Session $session: Study for $study_minutes minutes"
  say "Session $session. Time to study!"
  sleep $((study_minutes * 60))

  afplay "$sound"
  say "Study session $session complete."

  # Decide which break to take
  if (( long_break_interval > 0 && session % long_break_interval == 0 )); then
    echo "😌 Time for a long break: $long_break minutes"
    say "Take a long break."
    sleep $((long_break * 60))
  else
    echo "🍵 Time for a short break: $short_break minutes"
    say "Take a short break."
    sleep $((short_break * 60))
  fi

  afplay "$sound"
  session=$((session + 1))
done
