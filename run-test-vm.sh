#!/bin/bash
# Script para probar el tema Plymouth en una VM QEMU ultraligera.
# Ejecuta este script desde la raíz del proyecto o desde la carpeta del tema.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
ROOTFS="$PROJECT_ROOT/build/rootfs"

# Si estamos en la raíz del proyecto
if [ -d "build/rootfs" ]; then
    ROOTFS="$(pwd)/build/rootfs"
fi

if [ ! -d "$ROOTFS" ]; then
    echo "❌ Error: No se encontró el rootfs en $ROOTFS. Ejecuta ./build.sh primero."
    exit 1
fi

# Buscar Kernel e Initrd
KERNEL=$(ls "$ROOTFS"/boot/vmlinuz-* 2>/dev/null | head -n 1)
INITRD=$(ls "$ROOTFS"/boot/initrd.img-* 2>/dev/null | head -n 1)

if [ -z "$KERNEL" ] || [ -z "$INITRD" ]; then
    echo "❌ Error: No se encontró kernel/initrd en $ROOTFS/boot/"
    exit 1
fi

echo "🚀 Iniciando VM ultraligera para probar Plymouth..."
echo "📂 Usando Rootfs: $ROOTFS"

# Parámetros optimizados para velocidad:
# -m 512M: Suficiente para Plymouth
# -smp 2: Un par de cores
# quiet splash: Necesario para ver Plymouth
# plymouth.ignore-serial-consoles: Evita que Plymouth se desactive al detectar puerto serie

pkexec qemu-system-x86_64 \
    -m 512M \
    -smp 2 \
    -enable-kvm \
    -cpu host \
    -kernel "$KERNEL" \
    -initrd "$INITRD" \
    -append "root=rootfs rw rootfstype=9p rootflags=trans=virtio,version=9p2000.L,msize=262144 quiet splash plymouth.ignore-serial-consoles console=tty0 loglevel=0 rd.systemd.show_status=false rd.udev.log_level=0 vt.global_cursor_default=0" \
    -fsdev local,id=rootfs,path="$ROOTFS",security_model=passthrough \
    -device virtio-9p-pci,fsdev=rootfs,mount_tag=rootfs \
    -device virtio-vga-gl \
    -display sdl,gl=on \
    -serial mon:stdio

