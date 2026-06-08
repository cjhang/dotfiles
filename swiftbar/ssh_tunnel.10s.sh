#!/bin/zsh

# SwiftBar SSH Tunnel Manager
# Metadata:
# <swiftbar.hideAbout>true</swiftbar.hideAbout>
# <swiftbar.hideRunInTerminal>true</swiftbar.hideRunInTerminal>
# <swiftbar.hideLastUpdated>true</swiftbar.hideLastUpdated>
# <swiftbar.hideDisablePlugin>false</swiftbar.hideDisablePlugin>
# <swiftbar.hideSwiftBar>false</swiftbar.hideSwiftBar>
# <swiftbar.refreshOnOpen>true</swiftbar.refreshOnOpen>

SCRIPT="$0"

TUNNELS=(
  "DB Dev|5432|ssh -N -L 5432:localhost:5432 ovh"
  "Hacserver|5900|ssh -N -L 5900:localhost:5900 hacserver"
)

is_running() {
    lsof -nP -iTCP:"$1" -sTCP:LISTEN >/dev/null 2>&1
}

stop_tunnel() {
    local port="$1"
    # Kill any process listening on this port (robust: works for all SSH tunnel variants)
    lsof -ti TCP:"$port" -sTCP:LISTEN | xargs -r kill -9 2>/dev/null
}

start_tunnel() {
    local port="$1"
    local cmd="$2"
    # Detach fully from SwiftBar's process group
    nohup bash -c "$cmd" > "/tmp/ssh-tunnel-${port}.log" 2>&1 </dev/null &
    disown
}

# ── Handle actions triggered by menu clicks ──────────────────────────────────
if [[ "$1" == "connect" ]]; then
    port="$2"
    for tunnel in "${TUNNELS[@]}"; do
        name="${tunnel%%|*}"
        rest="${tunnel#*|}"
        p="${rest%%|*}"
        cmd="${rest#*|}"
        if [[ "$p" == "$port" ]]; then
            start_tunnel "$port" "$cmd"
            exit 0
        fi
    done
    exit 1
fi

if [[ "$1" == "stop" ]]; then
    stop_tunnel "$2"
    exit 0
fi

# ── Build menu ────────────────────────────────────────────────────────────────

# Count running tunnels first so we can show it in the title
running_count=0
for tunnel in "${TUNNELS[@]}"; do
    rest="${tunnel#*|}"
    port="${rest%%|*}"
    is_running "$port" && ((running_count++))
done

total="${#TUNNELS[@]}"

# Menu bar title line
if (( running_count == 0 )); then
    echo "🔗"
else
    echo "🔗 ${running_count}/${total}"
fi

echo "---"

for tunnel in "${TUNNELS[@]}"; do
    name="${tunnel%%|*}"
    rest="${tunnel#*|}"
    port="${rest%%|*}"
    cmd="${rest#*|}"

    if is_running "$port"; then
        echo "🟢 ${name} (:${port})"
        echo "-- ⏹ Stop | bash='${SCRIPT}' param1=stop param2=${port} terminal=false refresh=true"
    else
        echo "⚪ ${name} (:${port})"
        echo "-- ▶️ Connect | bash='${SCRIPT}' param1=connect param2=${port} terminal=false refresh=true"
    fi
done

echo "---"
echo "${running_count}/${total} tunnels active | color=#888888"
echo "Refresh | refresh=true"
