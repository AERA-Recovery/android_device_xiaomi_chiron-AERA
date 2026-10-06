#!/bin/bash
set -euo pipefail

if [ "$#" -gt 1 ] || { [ "$#" -eq 1 ] && [ "$1" != --check ]; }; then
    printf 'Usage: bash device/xiaomi/chiron/patches/apply.sh [--check]\n' >&2
    exit 2
fi
patch_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)
source_root=$PWD
if [ ! -f "$source_root/build/envsetup.sh" ]; then
    printf 'Run this script from the Android source root.\n' >&2
    exit 1
fi
(cd "$patch_dir" && sha256sum -c SHA256SUMS)

patch_data() {
    case "$1" in
        *.gz) gzip -dc -- "$patch_dir/$1" ;;
        *) cat -- "$patch_dir/$1" ;;
    esac
}

# Validate every target first; never silently rebase, discard work, or fetch.
while IFS=$'\t' read -r project base patch; do
    target="$source_root/$project"
    if [ "$(git -C "$target" rev-parse HEAD)" != "$base" ]; then
        printf 'Wrong base for %s; expected %s. No patches applied.\n' "$project" "$base" >&2
        exit 1
    fi
    if [ -n "$(git -C "$target" status --porcelain --untracked-files=normal)" ]; then
        printf '%s contains local changes. No patches applied.\n' "$project" >&2
        exit 1
    fi
    patch_data "$patch" | git -C "$target" apply --check -
done < "$patch_dir/series.tsv"

if [ "${1:-}" = --check ]; then
    printf 'All source bases, checksums and patch checks passed.\n'
    exit 0
fi
while IFS=$'\t' read -r project base patch; do
    patch_data "$patch" | git -C "$source_root/$project" apply -
    printf 'Applied %s to %s\n' "$patch" "$project"
done < "$patch_dir/series.tsv"
