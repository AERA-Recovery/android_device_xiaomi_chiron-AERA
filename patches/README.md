# Chiron source patch snapshot

This directory preserves all uncommitted changes in the six shared source
repositories used by the Chiron bring-up at the time of this snapshot. New
source files and binary changes are included. The patches were reapplied to
their recorded bases and the resulting Git tree IDs matched the local source
snapshots exactly. Existing repository history, authorship and license
headers are not rewritten.

`series.tsv` contains tab-separated source path, base commit, and patch file.
`SHA256SUMS` verifies the patch files and revision list.

| Source repository | Changes captured |
| --- | --- |
| `bootable/recovery` | Legacy KGSL/MDSS GPU rendering, display/capture support, native-resolution rendering, gesture rasterization, short-screen layouts, build flags, and existing browser runtime/metadata delta |
| `external/lvgl` | Legacy OpenGL rendering/performance changes and button behavior |
| `system/core` | Legacy fscrypt session-keyring initialization |
| `system/vold` | fscrypt v1 policy/key support and build configuration |
| `device/qcom/twrp-common` | Create the session keyring before recovery starts |
| `vendor/recovery` | Export legacy GPU and fscrypt policy build flags |

The runtime binary delta is a gzip-compressed Git binary patch because it
contains both forward and reverse data for an already-compressed payload.
It is an existing local change, not a fix for Chiron's unresolved browser
startup. No installed plugin package is altered by this patch export.

## Apply

Use a clean checkout of each source repository at the base revision listed
in `series.tsv`. From the Android source root, run:

```sh
bash device/xiaomi/chiron/patches/apply.sh --check
bash device/xiaomi/chiron/patches/apply.sh
```

The script checks every repository and patch before applying anything. It
does not fetch, switch branches, reset files, commit, or run during lunch.
It refuses changed repositories or different base revisions. Use a separate
checkout if you need to keep unrelated local work. Once applied, do not run
it again on that same modified checkout.

These patches reproduce the experimental Alpha source state, including
known limitations. Browser/plugin launch compatibility and audio support
are not complete. The launcher is packaged by Chiron's `device.mk`, but
additional old-kernel compatibility work is still needed.
