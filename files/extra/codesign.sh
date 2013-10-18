#!/bin/bash

CODESIGN_IDENTITY="Developer ID Application: Fumihiko Takayama (G43BCU2T37)"

# ------------------------------------------------------------
PATH=/bin:/sbin:/usr/bin:/usr/sbin; export PATH

if [ ! -e "$1" ]; then
    echo "[ERROR] Invalid argument: '$1'"
    exit 1
fi

# ------------------------------------------------------------
echo -ne '\033[33;40m'
echo "code sign $1"
echo -ne '\033[0m'

echo -ne '\033[31;40m'
codesign --force --sign "$CODESIGN_IDENTITY" "$1"
echo -ne '\033[0m'
