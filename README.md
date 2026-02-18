# ʕ•ᴥ•ʔ My Comfy Gentoo Dotfiles

Welcome to my personal digital garden! This is a collection of my configuration files for a minimal, fast, and cozy Gentoo Linux environment. I use these files to keep my workflow consistent and my desktop looking sharp.

> **Note:** Built for my specific hardware (Intel Skylake / HP), but feel free to scavenge anything you find useful!

---

## 🖥️ What's Inside?

* **OS:** [Gentoo Linux](https://www.gentoo.org/) (The only way to feel alive)
* **WM:** * `bspwm` - My daily driver (fast & precise)
* **Shell:** `zsh` + `omz`
* **Bar:** `polybar` (highly customized)
---

## 📸 Screenshots
<img width="1366" height="768" alt="image" src="https://github.com/user-attachments/assets/71e0fb71-1648-440c-8dd4-2377bed7e3fb" />
---

## 🛠️ Special Features

### 🔀 The WM Selector
I wrote a custom script in `.zprofile` that lets me choose my environment right at login. No Display Manager needed! Just pure TTY bliss.

### 🎧 Audio Fixes
If you have an **HP laptop with ALC3227**, check out my `modprobe` tweaks. It took me a while, but the headphones finally work! ʕ-ᴥ-ʔ

---

## 🚀 Installation (For Me)

```bash
git clone [https://github.com/your-username/Dotfiles-Gentoo.git](https://github.com/your-username/Dotfiles-Gentoo.git)
cd Dotfiles-Gentoo
# Be careful with the symlinks!
