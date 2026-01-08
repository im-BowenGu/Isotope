# Isotope

**Isotope** is an opinionated, atomic Arch Linux configuration designed for 100% Wayland stability. Inspired by the logic of Omarchy, it treats the system core as a swappable, immutable ROM while managing user applications via Nix.

## 🏗️ The Architecture

Isotope splits the system into three distinct functional layers to ensure that a software update can never permanently break your workstation.

1. **The Atomic Core ([ArchABRoot](https://www.google.com/search?q=https://github.com/im-BowenGu/ArchABRoot)):** A dual-slot (A/B) root partition system. Updates are performed on the inactive slot. If an update fails, you simply reboot into the previous slot.
2. **The Package Layer ([NixMan](https://www.google.com/search?q=https://github.com/im-BowenGu/NixMan)):** A declarative manifest for user applications. These apps reside within the system root, ensuring they are captured in the A/B snapshots.
3. **The Persistent State:** Personal data and configurations (`/home`) are bind-mounted from a dedicated Data partition, remaining untouched during system swaps.

## 🛠️ Components

* **Compositor:** Hyprland (100% Wayland)
* **Shell/UI:** ML4W (My Linux for Work)
* **System Management:** ArchABRoot
* **Package Management:** NixMan + Paru + Pacman
* **Editor:** Zed / Codium / LazyVim
* **Browser:** Zen Browser

## 🚀 Installation

1. **Partitioning:** Prepare two identical root partitions (Slot A/B) and one Data partition.
2. **Bootstrap:** Install a base Arch system on Slot A, then run the build script:
```bash
curl -sSL https://raw.githubusercontent.com/your-repo/isotope/main/bootstrap.sh | bash

```


3. **Setup:** Run `abroot-setup` to define your partition UUIDs.
4. **Finalize:** Reboot and enjoy an indestructible rolling-release system.

## 🤝 Contributing

Isotope is a personal workflow. If you have optimizations for the A/B sync logic or Wayland performance, feel free to submit issues or pull requests to the respective sub-projects.

---
