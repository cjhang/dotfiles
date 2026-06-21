#!/bin/bash

# SwiftBar plugin: screen-share.1h.sh
# One click on menu bar shows computers.
# Second click on a computer connects via macOS Screen Sharing.

# -----------------------------
# Computers
# Format:
# Display Name|vnc://host-or-ip
# -----------------------------

HOSTS=$(cat <<EOF
hacserver|vnc://www.cjhastro.com:5059
hacserver-mpe|vnc://130.183.134.91
hacserver-pi|vnc://192.168.178.87:5059
EOF
)
NOTES_DIR="$HOME/work/documents/notes"
MARKDOWN_OPEN_APP="MarkEdit"

# -----------------------------
# Actions:
# -----------------------------

if [[ "$1" == "connect" ]]; then
    URL="$2"
    open -a "Screen Sharing" "$URL"
    exit 0

elif [[ "$1" == "newmd" ]]; then
    mkdir -p "$NOTES_DIR"

    TITLE=$(osascript -e 'text returned of (display dialog "New Markdown file name:" default answer "Untitled" buttons {"Cancel", "Create"} default button "Create")' 2>/dev/null)
    [[ $? -ne 0 ]] && exit 0

    TITLE=$(echo "$TITLE" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')
    [[ -z "$TITLE" ]] && TITLE="Untitled"

    SAFE_TITLE=$(echo "$TITLE" | tr '/:' '--')
    DATE=$(date +"%Y-%m-%d")
    FILE="$NOTES_DIR/unsorted/$DATE_$SAFE_TITLE.md"

    if [[ -e "$FILE" ]]; then
        FILE="$NOTES_DIR/unsorted/$DATE_$SAFE_TITLE_$(date +"%H%M%S").md"
    fi

    cat > "$FILE" <<EOF
# $TITLE

Created: $(date +"%Y-%m-%d %H:%M")

EOF

    open -a "$MARKDOWN_OPEN_APP" "$FILE"
    exit 0

elif [[ "$1" == "quickmd" ]]; then
    mkdir -p "$NOTES_DIR/unsorted"
    FILE="$NOTES_DIR/unsorted/$(date '+%Y-%m-%d-%H%M%S').md"
    touch $FILE
    open -a "$MARKDOWN_OPEN_APP" "$FILE"
    exit 0
fi

# -----------------------------
# SwiftBar menu
# -----------------------------

# Top menu-bar item.
# No bash action here, so clicking it only opens the menu.
echo " | sfimage=point.forward.to.point.capsulepath.fill"
echo "---"

echo "Connect computers"
while IFS='|' read -r LABEL URL; do
    [[ -z "$LABEL" || -z "$URL" ]] && continue

    echo "$LABEL | sfimage=display bash=\"$0\" param1=connect param2=\"$URL\" terminal=false refresh=false"
done <<< "$HOSTS"
echo "Others"
echo "--ihac | bash=\"$0\" param1=connect param2=\"vnc://office-imac.local\" terminal=false refresh=false"
echo "Open Screen Sharing App | bash=/usr/bin/open param1=-a param2=\"Screen Sharing\" terminal=false"


echo "---"
echo "Open files"
echo "New Quick File | sfimage=doc.badge.plus bash=\"$0\" param1=quickmd terminal=false refresh=false"
echo "New Named File | sfimage=doc.badge.plus bash=\"$0\" param1=newmd terminal=false refresh=false"
echo "Open Notes Folder | bash=/usr/bin/open param1=\"$NOTES_DIR\" terminal=false"
echo "Open MarkEdit | bash=/usr/bin/open param1=-a param2=\"$MARKDOWN_OPEN_APP\" terminal=false"

echo "---"
echo "Refresh | refresh=true"
