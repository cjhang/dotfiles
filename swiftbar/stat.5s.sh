#!/bin/zsh
# <swiftbar.refreshEvery>5</swiftbar.refreshEvery>

CPU_STATE=/tmp/swiftbar-cpu
NET_STATE=/tmp/swiftbar-netspeed

CPU_THRESHOLD=20       # hide CPU if below this %
NET_THRESHOLD=404800   # hide network if below this bytes/s (100K)

NOW=$(date +%s)

# ---- CPU (via kernel CPU ticks using /usr/bin/top) ----
CPU_IDLE=$(/usr/bin/top -l 2 -s 1 -n 0 2>/dev/null \
    | awk '/CPU usage/{line=$0} END{
        gsub(/.*,[ ]*/, "", line)
        gsub(/% idle.*/, "", line)
        print line
    }')

CPU_INT=0
if [[ -n "$CPU_IDLE" ]]; then
    CPU_INT=$(printf "%.0f" "$(echo "100 - $CPU_IDLE" | bc -l)")
    (( CPU_INT < 0 )) && CPU_INT=0
fi

# ---- Net ----
IFACE=$(route get default 2>/dev/null | awk '/interface:/{print $2}')

read RX TX < <(
    netstat -ibn | awk -v iface="$IFACE" '
        $1 == iface { rx += $7; tx += $10 }
        END         { print rx, tx }
    '
)

hr() {
    awk -v b="$1" 'BEGIN {
        if      (b >= 1048576) printf "%.1fM", b/1048576
        else if (b >= 1024)    printf "%.0fK", b/1024
        else                   printf "%dB",   b
    }'
}

RXPS=0
TXPS=0
if [[ -f "$NET_STATE" ]]; then
    read OLD_RX OLD_TX OLD_NET_TIME < "$NET_STATE"
    DT=$(( NOW - OLD_NET_TIME ))
    (( DT < 1 )) && DT=1

    RXPS=$(( (RX - OLD_RX) / DT ))
    TXPS=$(( (TX - OLD_TX) / DT ))
    (( RXPS < 0 )) && RXPS=0
    (( TXPS < 0 )) && TXPS=0
fi
echo "$RX $TX $NOW" > "$NET_STATE"

# ---- Apply thresholds for menu bar label ----
CPU_LABEL="o_"
(( CPU_INT >= CPU_THRESHOLD )) && CPU_LABEL="${CPU_INT}%"

NET_LABEL="_o"
MAXPS=$(( RXPS >= TXPS ? RXPS : TXPS ))
if (( MAXPS >= NET_THRESHOLD )); then
    if (( RXPS >= TXPS )); then
        NET_LABEL="↓ $(hr $RXPS)"
    else
        NET_LABEL="↑ $(hr $TXPS)"
    fi
fi

# Build title — show dash if both are below threshold
#TITLE="${CPU_LABEL}${CPU_LABEL:+ }${NET_LABEL}"
TITLE="${CPU_LABEL}${CPU_LABEL:+ }${NET_LABEL}"
echo "${TITLE:--}"

# ---- Dropdown ----
echo "---"
echo "CPU: ${CPU_INT}%"
echo "---"
echo "↓ Download: $(hr $RXPS)/s"
echo "↑ Upload:   $(hr $TXPS)/s"
echo "Interface:  ${IFACE}"
