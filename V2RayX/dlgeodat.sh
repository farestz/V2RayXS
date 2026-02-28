#!/usr/bin/env bash
# Download latest geoip.dat and geosite.dat from Loyalsoldier/v2ray-rules-dat

SRCROOT="${SRCROOT:-$(cd "$(dirname "$0")/.." && pwd)}"
BASE_URL="https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download"
DEST="$SRCROOT/xray-core-bin"

RED='\033[0;31m'
GREEN='\033[0;32m'
NORMAL='\033[0m'

mkdir -p "$DEST"

for f in geoip.dat geosite.dat; do
    echo "Downloading $f..."
    curl -fsSL -o "$DEST/$f" "$BASE_URL/$f"
    if [[ $? != 0 ]]; then
        echo -e "${RED}Failed to download $f from Loyalsoldier/v2ray-rules-dat${NORMAL}"
        exit 1
    fi
done

echo -e "${GREEN}geoip.dat and geosite.dat updated successfully${NORMAL}"
