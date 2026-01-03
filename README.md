# rpa-appearance

<div align="center">

![GitHub Release](https://img.shields.io/github/v/release/RP-Alpha/rpa-appearance?style=for-the-badge&logo=github&color=blue)
![GitHub commits](https://img.shields.io/github/commits-since/RP-Alpha/rpa-appearance/latest?style=for-the-badge&logo=git&color=green)
![License](https://img.shields.io/github/license/RP-Alpha/rpa-appearance?style=for-the-badge&color=orange)
![Downloads](https://img.shields.io/github/downloads/RP-Alpha/rpa-appearance/total?style=for-the-badge&logo=github&color=purple)

**Appearance System Bridge**

</div>

---

## ✨ Features

- 🔄 **Provider Agnostic** - Works with illenium-appearance, fivem-appearance, qb-clothing
- 👔 **Target Integration** - Clothing store interactions via rpa-lib
- 💾 **Save/Load** - Automatic skin persistence

---

## 📥 Installation

1. Download the [latest release](https://github.com/RP-Alpha/rpa-appearance/releases/latest)
2. Ensure you have an appearance resource installed
3. Extract to your `resources` folder
4. Add to `server.cfg`:
   ```cfg
   ensure rpa-appearance
   ```

---

## ⚙️ Configuration

Set your appearance provider in `config.lua`:

```lua
Config.Provider = 'illenium-appearance' -- or 'fivem-appearance', 'qb-clothing'
```

---

## 📄 License

MIT License - see [LICENSE](LICENSE) for details.

<div align="center">
  <sub>Built with ❤️ by <a href="https://github.com/RP-Alpha">RP-Alpha</a></sub>
</div>
