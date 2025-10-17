#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

# -----------------------------
# Check required argument
# -----------------------------
if [[ $# -lt 1 || -z "$1" ]]; then
    echo "Usage: $0 <file.prg>"
    exit 1
fi

# Input PRG file
prg_file="$1"
if [[ ! -f "$prg_file" ]]; then
    echo "Error: File '$prg_file' does not exist."
    exit 1
fi

# -----------------------------
# Directories
# -----------------------------
prg_file_dir=$(dirname "$(realpath "$prg_file")")
dir_output=$(mktemp -d)
new_prg_file="${dir_output}/$(basename "$prg_file").new.prg"

# Regular expression to match quoted strings
regex='"[^"]+"'

# Create necessary directories
mkdir -p "$dir_output/romfs"

# Copy original PRG file
cp "$prg_file" "$new_prg_file"

# -----------------------------
# Copy resources from resources.txt
# -----------------------------
if [[ -f "resources.txt" ]]; then
    while IFS= read -r line || [[ -n "$line" ]]; do
        if [[ -e "$line" ]]; then
            mkdir -p "$dir_output/romfs/$(dirname "$line")"
            cp -r "$line" "$dir_output/romfs/$line"
        fi
    done < "resources.txt"
fi

# -----------------------------
# Copy files referenced in PRG
# -----------------------------
while IFS= read -r quoted_string; do
    file="${quoted_string%\"}"
    file="${file#\"}"

    # Skip source files and special directories
    if [[ "$file" =~ \.(prg|h|inc|c|def)$ ]] || [[ "$file" == "." || "$file" == ".." ]]; then
        continue
    fi

    if [[ -e "$file" ]]; then
        mkdir -p "$dir_output/romfs/$(dirname "$file")"
        cp -r "$file" "$dir_output/romfs/$file"
    fi
done < <(grep -oE "$regex" "$new_prg_file")

# -----------------------------
# Build PRG to DCB
# -----------------------------
bgdc "$new_prg_file" -o "${dir_output}/romfs/game.dcb"
NAME=$(basename "$prg_file" .prg)

# -----------------------------
# Build ROMFS, NACP, and NRO
# -----------------------------
$DEVKITPRO/tools/bin/build_romfs "${dir_output}/romfs" "${dir_output}/romfs.bin"
$DEVKITPRO/tools/bin/nacptool --create "$NAME" "SplinterGU" 1.0 "${dir_output}/$NAME.nacp"

elf2nro_cmd=(
    "$DEVKITPRO/tools/bin/elf2nro"
    "$BGD2DEV/build/aarch64-none-elf/bin/bgdi.elf"
    "${dir_output}/$NAME.nro"
    "--romfs=${dir_output}/romfs.bin"
    "--nacp=${dir_output}/$NAME.nacp"
)
[[ -f icon.png ]] && elf2nro_cmd+=(--icon=icon.png)

"${elf2nro_cmd[@]}"

# Copy final NRO
cp "${dir_output}/$NAME.nro" "$prg_file_dir"

# Cleanup
rm -rf "$dir_output"

echo "Build complete: ${prg_file_dir}/$NAME.nro"