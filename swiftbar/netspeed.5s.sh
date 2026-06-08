#!/bin/zsh
# <swiftbar.refreshEvery>2</swiftbar.refreshEvery>

STATE=/tmp/swiftbar-netspeed
IFACE=$(route get default 2>/dev/null | awk '/interface:/{print $2}')

read RX TX < <(
    netstat -ibn | awk -v iface="$IFACE" '
        $1 == iface { rx += $7; tx += $10 }
        END         { print rx, tx }
    '
)

NOW=$(date +%s)

hr() {
    awk -v b="$1" 'BEGIN {
        if      (b >= 1048576) printf "%.1fM", b/1048576
        else if (b >= 1024)    printf "%.0fK", b/1024
        else                   printf "%dB",   b
    }'
}

if [[ -f "$STATE" ]]; then
    read OLD_RX OLD_TX OLD_TIME OLD_MODE < "$STATE"
    DT=$(( NOW - OLD_TIME ))
    (( DT < 1 )) && DT=1

    RXPS=$(( (RX - OLD_RX) / DT ))
    TXPS=$(( (TX - OLD_TX) / DT ))
    (( RXPS < 0 )) && RXPS=0
    (( TXPS < 0 )) && TXPS=0

    if [[ "$OLD_MODE" == "down" ]]; then
        echo "↓ $(hr $RXPS)"
        MODE="up"
    else
        echo "↑ $(hr $TXPS)"
        MODE="down"
    fi
else
    echo "↓…"
    MODE="down"
fi

echo "$RX $TX $NOW $MODE" > "$STATE"
