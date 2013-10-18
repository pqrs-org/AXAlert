#!/bin/sh

CODESIGN_IDENTITY="Developer ID Application: Fumihiko Takayama (G43BCU2T37)"

# ------------------------------------------------------------
PATH=/bin:/sbin:/usr/bin:/usr/sbin; export PATH

if [ ! -e "$1" ]; then
    echo "[ERROR] Invalid argument: '$1'"
    exit 1
fi

# ------------------------------------------------------------
output_progress() {
    echo "\033[33;40m""$1""\033[0m"
}

# ------------------------------------------------------------
# sign app
output_progress "codesign $1"
codesign --force --sign "$CODESIGN_IDENTITY" "$1"

# sign Framework
for f in `find "$1" -name '*.framework'`; do
    output_progress "codesign $f"
    codesign --force --sign "$CODESIGN_IDENTITY" "$f"
done
