#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

# Check for mandatory argument
if [ -z "$1" ]; then
  echo "Usage: $0 <game-file.prg>"
  exit 1
fi

PRG_FILE="$1"

# Check if the .prg file exists
if [ ! -f "$PRG_FILE" ]; then
  echo "Error: $PRG_FILE not found!"
  exit 1
fi

# Derive game name and DCB
GAME_NAME=$(basename "$PRG_FILE" .prg)
DCB_FILE="${GAME_NAME}.dcb"
BDGI_FILE=${BGD2DEV}/build/linux-gnu/bin/bgdi
ROMFS_DIR="romfs"
OUTPUT_DIR="$(pwd)"
OPK_NAME="${GAME_NAME}.opk"

# Compile .prg to .dcb (if not exists)
if [ ! -f "$DCB_FILE" ]; then
  echo "Compiling $PRG_FILE -> $DCB_FILE"
  if [ -d "$ROMFS_DIR" ]; then
    bgdc "$PRG_FILE" -o "$DCB_FILE" -romfs "$ROMFS_DIR"
  else
    bgdc "$PRG_FILE" -o "$DCB_FILE"
  fi
fi

# Create temporary directory
TMP_DIR=$(mktemp -d)
mkdir -p "$TMP_DIR/romfs"

# Copy DCB and assets
cp "$DCB_FILE" "$TMP_DIR/romfs/"
cp "$BDGI_FILE" "$TMP_DIR/romfs/"
if [ -d "$ROMFS_DIR" ]; then
  cp -r "$ROMFS_DIR"/* "$TMP_DIR/romfs/"
fi

# Create control file (OPK metadata)
cat > "$TMP_DIR/default.gcw0.desktop" <<EOL
[Desktop Entry]
Title=$GAME_NAME
Comment=BennuGD2 Game
Exec=./bgdi ./$DCB_FILE
Icon=icon.png
Type=Application
EOL

# Optional: copy icon if exists
if [ -f "icon.png" ]; then
  cp icon.png "$TMP_DIR/"
fi

# Create OPK file
cd "$TMP_DIR"
mksquashfs . "$OUTPUT_DIR/$OPK_NAME" -all-root -noappend -no-exports -no-xattrs
cd - > /dev/null

# Clean temporary folder
rm -rf "$TMP_DIR"

echo "✅ OPK created in $OUTPUT_DIR/$OPK_NAME"