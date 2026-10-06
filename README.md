# AERA Recovery for Xiaomi Mi MIX 2 (chiron)

Experimental **Official Alpha** device tree for AERA Android 16.
Original device-tree history and contributor credits are retained.

The current bring-up boots and decrypts the tested crDroid Android 16 install,
connects to Wi-Fi, and uses the legacy Adreno 540/KGSL display path. This is not
a claim of compatibility with every Chiron ROM. Browser/plugin startup is
still unresolved; packaging the sandbox launcher alone does not fix it.

All local shared-source changes from this bring-up are saved in `patches/`,
including GPU/UI work, legacy decryption support, and the existing browser
runtime delta. See [patch instructions](patches/README.md) for exact source
base commits and application instructions. They are not applied automatically
by `vendorsetup.sh` and have not been pushed to the shared source repositories.

The Xiaomi Mi MIX 2 (codenamed "Chiron") is a high-end smartphone from Xiaomi.

It was announced in October 2017. Release date was December 2017.

Forked From:https://github.com/0ranko0P/twrp_device_xiaomi_sagit

## To compile

Place this tree at `device/xiaomi/chiron` in an AERA Android 16 checkout.
Use the source revisions recorded in `patches/series.tsv`, then run from the
source root:

```sh
bash device/xiaomi/chiron/patches/apply.sh --check
bash device/xiaomi/chiron/patches/apply.sh
source build/envsetup.sh
lunch twrp_chiron-bp2a-eng
mka recoveryimage
```

Expected image: `out/target/product/chiron/AERA-R1.0-Alpha-Official-chiron.img`.
The prebuilt kernel is from the Android 16 crDroid bring-up baseline. Matching
installed vendor/modem firmware is required. Optional NAS transport (`rclone`)
and offline root-provider payloads are omitted to stay within the tested
legacy recovery boot limits. Browser plugins have not been modified here.

## Device specifications

| Basic                   | Spec Sheet                                                          |
| -----------------------:|:------------------------------------------------------------------- |
| CPU                     | Quad-core 2.45 GHz Kryo 280 & Quad-core 1.9 GHz Kryo 280            |
| Chipset                 | Qualcomm MSM8998 Snapdragon 835                                     |
| GPU                     | Adreno 540                                                          |
| Memory                  | 6/8 GB RAM                                                          |
| Shipped Android Version | 7.1.1                                                               |
| Storage                 | 64/128/256 GB (UFS Flash)                                           |
| Battery                 | Non-removable Li-Po 3350 mAh (QC 3.0)                               |
| Display                 | 1080 x 2160 pixels, 5.99 inches (~403 ppi pixel density)            |
| Camera                  | 12 MP, f/2.0, phase detection autofocus, dual-LED (dual tone) flash |

## Device picture

![Xiaomi Mi MIX 2](https://i8.mifile.cn/a1/pms_1505401464.03824312!560x560.jpg "Xiaomi Mi MIX 2 in black")

## Credits

Special thanks to the following people or repo:

- [Nanhumly](https://github.com/Nanhumly)
- [Rom-Builder](https://github.com/Rom-Builder)
- [0ranko0P](https://github.com/0ranko0P)
- [foxlesbiao](https://github.com/foxlesbiao)
- [twrp_device_xiaomi_sagit](https://github.com/0ranko0P/twrp_device_xiaomi_sagit)
