# GNU Grub

GNU GRUB (short for GNU GRand Unified Bootloader, commonly referred to as GRUB) is a boot loader package from the GNU Project. GRUB is the reference implementation of the Free Software Foundation's Multiboot Specification, which provides a user the choice to boot one of multiple operating systems installed on a computer if (dual booted) or select a specific kernel configuration available on a particular operating system's partitions. It loads up before the operating system. [Wikipedia](https://en.wikipedia.org/wiki/GNU_GRUB)

- [Repository](https://git.savannah.gnu.org/cgit/grub.git)
- [Manual](https://www.gnu.org/software/grub/manual/grub/grub.html)
- [Arch wiki](https://wiki.archlinux.org/title/GRUB)


## Config

Grub config is stored in following locations

- `/etc/default/grub` (file)
- `/etc/grub.d/`      (folder)


## Showing/hiding boot menu

Configure `GRUB_TIMEOUT_STYLE` in `/etc/default/grub`

Possible options:
   - **menu**: Always show the selection menu and wait for timeout (`GRUB_TIMEOUT`) to continue with default option.
   - **countdown**: Grub will show a countdown during the timeout (`GRUB_TIMEOUT`) before continueing with the default option. If `ESC`, `F4` or `SHIFT` is pressed during the counttime the menu is shown.
   - **hidden**: Grub will show a blank during the timeout (`GRUB_TIMEOUT`) before continueing with the default option. If `ESC`, `F4` or `SHIFT` is pressed during the counttime the menu is shown.

Related settings:
   - `GRUB_TIMEOUT`: Time to wait before starting the default option.


## Adding operating system to boot menu

1. **Check UEFI/BIOS**
```sh
[ -d /sys/firmware/efi ] && echo "UEFI" || echo "Legacy BIOS"
```
This manual is onlu valid for UEFI.

2. **Get the boot partition UUID**
```sh
lsblk -f
```

3. **Add extra menu items to `/etc/grub.d/40_custom`**

The default content is. New menu items are added at the end.
```sh
#!/bin/sh
exec tail -n +3 $0
# This file provides an easy way to add custom menu entries.  Simply type the
# menu entries you want to add after this comment.  Be careful not to change
# the 'exec tail' line above.
```

Menu item format
```sh
menuentry "Windows Boot Manager (UEFI)" --class windows --class os {
    insmod part_gpt
    insmod fat
    insmod search_fs_uuid
    insmod chain
    search --fs-uuid --no-floppy --set=root 1234-ABCD
    chainloader /EFI/Microsoft/Boot/bootmgfw.efi
}
```
Replace `1234-ABCD` with the actual UUID of your EFI System Partition.
Replace `/EFI/Microsoft/Boot/bootmgfw.efi` with the path to the correct efi file. This is the default for Windows.

4. Update grub
```sh
sudo grub-mkconfig -o /boot/grub/grub.cfg
```

