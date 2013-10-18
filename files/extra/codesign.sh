#!/bin/bash

CODESIGN_IDENTITY="Developer ID Application: Fumihiko Takayama (G43BCU2T37)"

# ------------------------------------------------------------
PATH=/bin:/sbin:/usr/bin:/usr/sbin; export PATH

if [ ! -e "$1" ]; then
    echo "[ERROR] Invalid argument: '$1'"
    exit 1
fi

# ------------------------------------------------------------
for f in \
    `find "$1" -name '*.app'` \
    `find "$1" -name '*.framework'` \
    ; do

    echo -ne '\033[33;40m'
    echo "code sign $f"
    echo -ne '\033[0m'

    echo -ne '\033[31;40m'
    codesign \
        --force \
        --ignore-resources \
        --sign "$CODESIGN_IDENTITY" \
        "$f"
    echo -ne '\033[0m'
done
