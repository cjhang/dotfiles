#!/bin/zsh

STATE=/tmp/swiftbar-cpu

NOW=$(date +%s)

# ---- Get total CPU usage snapshot ----
# user + system CPU from ps
CPU=$(ps -A -o %cpu | awk '{s+=$1} END {print s}')

if [[ -f "$STATE" ]]; then
    read OLD_CPU OLD_TIME < "$STATE"

    DT=$((NOW - OLD_TIME))
    [[ $DT -lt 1 ]] && DT=1

    # CPU delta per second (normalized-ish)
    CPU_DELTA=$(echo "$CPU - $OLD_CPU" | bc -l)
    CPU_PER_SEC=$(echo "$CPU_DELTA / $DT" | bc -l)

    # format to integer %
    CPU_INT=$(printf "%.0f" "$CPU_PER_SEC")

    # clamp (can exceed on multicore systems)
    if (( CPU_INT < 1 )); then CPU_INT=0; fi

    echo "${CPU_INT}% | refresh=5"
else
    echo "... | refresh=5"
fi

echo "$CPU $NOW" > "$STATE"
