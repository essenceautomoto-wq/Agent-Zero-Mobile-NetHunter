# Agent Zero Mobile: Fully Autonomous AI on Kali NetHunter

**Fully autonomous, root-access AI agent running natively on Android (Pixel 9a / Kali NetHunter). Features a dual-brain architecture: a 100% offline, air-gapped local LLM for stealth ops, and a free enterprise-tier cloud proxy for heavy recon.**

Most local AI setups are either severely restricted by hardware (slow local models) or locked behind paywalls and rate limits (OpenAI, Google Cloud). This build bypasses both. By bridging **Agent Zero** with a mobile Kali Linux subsystem, we give an AI full root access to your phone—capable of running `nmap`, writing Python scripts, and executing bash commands autonomously.

---

## 🛠️ Phase 1: The Hardware Foundation (Root & NetHunter)

**The What:** We are using a Google Pixel 9a as the host machine.
**The Why:** Agent Zero requires a Linux environment to execute tools. To get a proper Debian-based subsystem (Kali Linux) running natively on Android with full permissions, the device must be rooted.

### 1. Rooting the Pixel 9a
1. **Unlock the Bootloader:** Enable Developer Options > OEM Unlocking. Reboot to fastboot (`fastboot flashing unlock`).
2. **Patch with Magisk:** Download the factory image for your specific Pixel 9a build. Extract the `init_boot.img` (or `boot.img`). Transfer it to the phone and patch it using the Magisk App.
3. **Flash Root:** Transfer the patched image back to your PC and flash it via fastboot:
   `fastboot flash init_boot <magisk_patched_image.img>`
   `fastboot reboot`

### 2. Installing Kali NetHunter & Termux
1. Install **Termux** (via F-Droid, not the Play Store).
2. Install the **Kali NetHunter App** and **NetHunter Terminal** via the NetHunter Store.
3. Open the NetHunter app, grant it root permissions via Magisk, and install the **Kali Chroot** (Full or Minimal).
4. Start the Kali chroot to enter your root Linux subsystem.

---

## 💻 Phase 2: Preparing the Environment

**The What:** Setting up the dependencies inside the Kali chroot.
**The Why:** Agent Zero is built on Python and Node.js. It needs these packages to build its UI and execute its autonomous loops.

From inside your Kali NetHunter terminal (as `root`):
` ` `bash
# Update repositories
apt update && apt upgrade -y

# Install core dependencies
apt install python3 python3-pip git nodejs npm wget curl -y
` ` `

---

## 🤖 Phase 3: Deploying Agent Zero

**The What:** Cloning the Agent Zero repository to the mobile rig.

` ` `bash
# Clone the repository
git clone https://github.com/frdel/agent-zero.git
cd agent-zero

# Install Python requirements
pip install -r requirements.txt
` ` `

---

## 🧠 Phase 4: The Dual-Brain Setup (Stealth & Beast Mode)

This is what makes this rig the holy grail. We are setting up two brains: a local model for true offline hacking, and a cloud model for heavy lifting. You can seamlessly switch between them using the **Brain Icon** in the Agent Zero UI.

### Brain 1: Stealth Mode (Fully Offline / Air-Gapped)
For operations with zero cell service or airplane mode active.
1. Inside your Kali terminal, install Ollama (the local AI runner):
   ` ` `bash
   curl -fsSL https://ollama.com/install.sh | sh
   ` ` `
2. Pull a lightweight, mobile-friendly hacker model (like Llama 3.2 1B or 3B):
   ` ` `bash
   ollama run llama3.2:1b
   ` ` `
3. In Agent Zero's **Configure Models** settings, you can now set your provider to `Ollama` and the model name to `llama3.2:1b`. 

### Brain 2: Beast Mode (Cloud / OpenRouter)
Directly querying Google or Groq triggers credit card walls or extreme token throttling. We bypass this using **OpenRouter** as a proxy shield to access enterprise models for free.
1. Go to [OpenRouter.ai](https://openrouter.ai), create a free account, and generate an API Key.
2. In the Agent Zero UI (`localhost:5000`), click the **Settings Gear** > **Configure API Keys** and paste your OpenRouter key.
3. Go to **Configure Models** and set the provider to `OpenRouter`.
4. **Model Name:** `stepfun/step-3.5-flash:free` *(Massive 128k context, perfect JSON formatting).*
5. **Max Context:** `128000`

**The Switch:** Whenever you want to transition from Air-Gapped Stealth to Cloud Beast Mode, just click the **Brain Icon** right above the chat box in Agent Zero and toggle your preset!

---

## 🎯 Phase 5: The Execution Test

**The What:** Verifying the AI has root access to the Kali subsystem.

In the Agent Zero chat interface, send the following payload:
> *"Run `uname -a` and `whoami` in the terminal, then tell me exactly what OS and user privileges you are running with."*

### Expected Result:
The AI will autonomously open a terminal tool, execute the bash commands, read the output, and report back that it is running on an `aarch64` Android kernel with `root` privileges. 

**You now have a fully autonomous, root-access AI hacker in your pocket.**
