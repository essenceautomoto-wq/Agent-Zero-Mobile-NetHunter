# Agent Zero Mobile: Kali NetHunter Edition

> A fully autonomous agentic framework deployed natively on mobile edge hardware.

**⚠️ Disclaimer & Credits:** *This is an unofficial mobile deployment architecture guide. All core Agent Zero code, concepts, and intellectual property belong to [frdel / agent0ai](https://github.com/agent0ai/agent-zero). This repository simply documents the environment bypasses required to run the framework natively on rooted Android devices.*

**Agent Zero Mobile** is an extreme edge-case deployment. It bypasses the need for a desktop Docker host and runs natively on a rooted Google Pixel 9a using a Kali NetHunter (ARM64) subsystem. 

This build features a **Dual-Brain Architecture**: seamlessly switch between a 100% offline, air-gapped local LLM for stealth operations, and a free enterprise-tier cloud proxy for heavy reconnaissance and complex coding tasks.

---

## 🔗 The Toolchain (Credits & Resources)
This build relies on several open-source projects. Please refer to their official repositories for source code:
* **Core Framework:** [Agent Zero](https://github.com/agent0ai/agent-zero)
* **Linux Subsystem:** [Kali NetHunter](https://www.kali.org/docs/nethunter/)
* **Root Access:** [Magisk](https://github.com/topjohnwu/Magisk)
* **Terminal Emulator:** [Termux (F-Droid)](https://f-droid.org/en/packages/com.termux/)
* **Patched NH Terminal:** [NH-Term Magisk Fix (Dylanmurzello)](https://github.com/Dylanmurzello/kali-nethunter-nhterm-magisk-fix)
* **Cloud API Proxy:** [OpenRouter](https://openrouter.ai/)
* **Local Offline AI:** [Ollama](https://ollama.com/)

---

## 🚀 Phase 1: The Hardware Foundation

### 1. Rooting the Host Device
Agent Zero requires a Debian-based Linux environment to execute terminal tools. To achieve native execution with full hardware permissions, the host Android device must be rooted.
1. Enable Developer Options > OEM Unlocking. Reboot to fastboot (`fastboot flashing unlock`).
2. Download the factory image for your device. Extract `init_boot.img` (or `boot.img`), transfer it to the phone, and patch it via the Magisk App.
3. Flash the patched image back to your PC via fastboot:
   ```bash
   fastboot flash init_boot <magisk_patched_image.img>
   fastboot reboot
