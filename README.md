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
* **Primary Terminal:** [NH-Term Magisk Fix (Dylanmurzello)](https://github.com/Dylanmurzello/kali-nethunter-nhterm-magisk-fix)
* **Cloud API Proxy:** [OpenRouter](https://openrouter.ai/)
* **Local Offline AI:** [Ollama](https://ollama.com/)
* *(Optional Terminal Alternative: [Termux via F-Droid](https://f-droid.org/en/packages/com.termux/))*

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
   ```

### 2. Installing Kali NetHunter & The Patched Terminal
**CRITICAL NOTE FOR ANDROID 10+ USERS:** Modern Android and Magisk versions break the stock NetHunter Terminal app (resulting in immediate crashes or `line 35` errors). You must use a patched version.
1. Install the **Kali NetHunter App** via the NetHunter Store and install the **Kali Chroot** (Full or Minimal).
2. **DO NOT** use the stock NetHunter Terminal from the store. Instead, download and install the [Patched NH Terminal APK from GitHub](https://github.com/Dylanmurzello/kali-nethunter-nhterm-magisk-fix/releases).
3. Open the Patched Terminal, grant it root/SU access via Magisk, and launch Kali.
*(Note: Termux can optionally be used as your emulator, but this build utilizes the patched NH terminal for direct integration).*

---

## 💻 Phase 2: Installation & Environment Setup

### 1. Preparing the Chroot
Agent Zero requires Python and Node.js. From inside your Kali NetHunter terminal (as `root`):
```bash
# Update repositories
apt update && apt upgrade -y

# Install core dependencies
apt install python3 python3-pip git nodejs npm wget curl -y
```

### 2. Deploying Agent Zero
Clone the core framework directly into your mobile rig:
```bash
# Clone the repository
git clone [https://github.com/frdel/agent-zero.git](https://github.com/frdel/agent-zero.git)
cd agent-zero

# Install Python requirements
pip install -r requirements.txt
```

---

## 🧠 Phase 3: Dual-Brain Configuration

Start Agent Zero's UI by running `python main.py` and navigating to `http://localhost:5000` in your mobile browser. Click the **Settings Gear** > **Configure Models**.

### Brain 1: Beast Mode (Cloud / OpenRouter)
Directly querying major providers triggers credit card walls or token limits. We bypass this using OpenRouter.
1. Create a free account at [OpenRouter.ai](https://openrouter.ai) and generate an API Key.
2. In Agent Zero, go to **Configure API Keys** and paste your OpenRouter key.
3. In **Configure Models**, set the provider to `OpenRouter`.
4. **Model Name:** `stepfun/step-3.5-flash:free` *(Massive 128k context, excellent JSON compliance).*
5. **Max Context:** `128000`

### Brain 2: Stealth Mode (Fully Offline / Air-Gapped)
For operations with zero cell service or active airplane mode.
1. Inside your Kali terminal, install Ollama:
   ```bash
   curl -fsSL [https://ollama.com/install.sh](https://ollama.com/install.sh) | sh
   ```
2. Pull a lightweight, mobile-friendly model:
   ```bash
   ollama run llama3.2:1b
   ```
3. In Agent Zero's **Configure Models**, set your provider to `Ollama` and the model name to `llama3.2:1b`.

**Switching Brains:** Seamlessly hot-swap between Air-Gapped Stealth and Cloud Beast Mode by clicking the **Brain Icon** right above the chat box in the UI.

---

## ⚠️ Troubleshooting & Known Errors

If you are running this edge-deployment on mobile, you will likely hit these architecture-specific errors. Here is how to fix them:

**1. Error: NetHunter Terminal Closes Instantly / `code 127/126`**
* **Cause:** Android 10+ and Magisk v26+ broke the stock `su` wrapper used by the official NetHunter app.
* **Fix:** Uninstall the stock terminal. Install the [Patched Magisk NH Terminal](https://github.com/Dylanmurzello/kali-nethunter-nhterm-magisk-fix). 

**2. Error: `ValueError: Tool request must be a dictionary` in Agent Zero**
* **Cause:** The free-tier LLM you are using got overwhelmed by a complex prompt and broke its JSON formatting output. 
* **Fix:** Free models have smaller cognitive limits. Hit "New Chat" and break your command into smaller, single-step tactical requests (e.g., Run step 1. Wait for output. Run step 2).

**3. Error: `400 Bad Request: Developer instruction is not enabled`**
* **Cause:** The OpenRouter model you selected (such as Gemma 3) does not allow "System Prompts," which Agent Zero requires to read its internal instructions.
* **Fix:** Change your Model Name in settings to one that allows system instructions, such as `stepfun/step-3.5-flash:free` or `google/gemini-2.0-flash-exp:free`.

**4. Error: `Permission Denied` when running nmap or tcpdump**
* **Cause:** You are running the terminal as a standard Android user instead of root.
* **Fix:** Ensure you start your NetHunter terminal as `root`. You can verify this by asking Agent Zero to run `whoami`.
