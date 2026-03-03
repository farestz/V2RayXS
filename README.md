# V2RayXL

A simple macOS menu-bar GUI client for [Xray-core](https://github.com/XTLS/Xray-core).

[![GitHub release](https://img.shields.io/github/v/release/farestz/V2RayXL)](https://github.com/farestz/V2RayXL/releases)
![Downloads](https://img.shields.io/github/downloads/farestz/V2RayXL/latest/total)

## About

V2RayXL is an active fork of [tzmax/V2RayXS](https://github.com/tzmax/V2RayXS), which is based on [Cenmrev/V2RayX](https://github.com/Cenmrev/V2RayX). It uses [Xray-core](https://github.com/XTLS/Xray-core) to support VLESS and XTLS protocols.

Copyright of the original application belongs to [@Cenmrev](https://github.com/Cenmrev). Tribute to [@Cenmrev](https://github.com/Cenmrev), [@tzmax](https://github.com/tzmax), and the [@XTLS](https://github.com/XTLS) community.

## Install

Download the latest release from [GitHub Releases](https://github.com/farestz/V2RayXL/releases).

## Build from source

```bash
git clone --recursive https://github.com/farestz/V2RayXL.git
cd V2RayXL
bash V2RayX/dlcorex.sh
```

Open `V2RayXL.xcodeproj` in Xcode and build, or run:

```bash
bash build.sh
```

## How it works

V2RayXL generates config files for Xray-core and manages the xray process via `launchd`. It also controls macOS system proxy settings through a privileged helper.

**Default ports:** SOCKS5 on `1081`, HTTP on `8001`.

**Three proxy modes:**

- **Global** — all traffic is routed through xray (if the app respects system proxy settings)
- **PAC** — routing is determined by a PAC file; some traffic goes through xray, the rest goes direct
- **Manual** — xray runs but system proxy is not modified; configure your apps manually

The **Routing Rule** menu controls how xray-core handles incoming traffic internally. These rules apply in all three modes.

## Supported protocols

GUI configuration supports **VMess** and **VLESS**. Other protocols can be configured via **Advanced → Outbounds** using raw JSON:

- [Shadowsocks](https://xtls.github.io/en/config/outbounds/shadowsocks.html)
- [Socks](https://xtls.github.io/en/config/outbounds/socks.html)
- [Trojan](https://xtls.github.io/en/config/outbounds/trojan.html)
- [VLESS](https://xtls.github.io/en/config/outbounds/vless.html)
- [VMess](https://xtls.github.io/en/config/outbounds/vmess.html)
- [Wireguard](https://xtls.github.io/en/config/outbounds/wireguard.html)

See [Xray-core documentation](https://xtls.github.io/en/config/outbounds/) for details.

## Uninstall

Delete `V2RayXL.app` and remove these files:

- `/Library/Application Support/V2RayXL/`
- `~/Library/Application Support/V2RayXL/`
- `~/Library/Preferences/cenmrev.V2RayXL.plist`

## Acknowledgements

- [Cenmrev/V2RayX](https://github.com/Cenmrev/V2RayX) — original project
- [tzmax/V2RayXS](https://github.com/tzmax/V2RayXS) — xray-core fork this project is based on
- [XTLS/Xray-core](https://github.com/XTLS/Xray-core) — proxy engine
- [GCDWebServer](https://github.com/swisspol/GCDWebServer) — local PAC server
- [ShadowsocksX](https://github.com/shadowsocks/shadowsocks-iOS) — system proxy helper code

## License

[GPL-3.0](LICENSE)

---

## 🇷🇺 Русская версия

V2RayXL — macOS-клиент для [Xray-core](https://github.com/XTLS/Xray-core) с управлением из строки меню.

### Установка

Скачайте последний релиз со страницы [GitHub Releases](https://github.com/farestz/V2RayXL/releases).

### Сборка из исходников

```bash
git clone --recursive https://github.com/farestz/V2RayXL.git
cd V2RayXL
bash V2RayX/dlcorex.sh
```

Откройте `V2RayXL.xcodeproj` в Xcode или выполните `bash build.sh`.

### Как это работает

Приложение генерирует конфигурацию для xray-core и управляет процессом через `launchd`. Порты по умолчанию: SOCKS5 — `1081`, HTTP — `8001`.

**Три режима прокси:**

- **Global** — весь трафик идёт через xray
- **PAC** — маршрутизация по PAC-файлу
- **Manual** — xray работает, но системный прокси не настраивается

### Протоколы

GUI поддерживает **VMess** и **VLESS**. Остальные протоколы (Shadowsocks, Trojan, Wireguard и др.) настраиваются через **Advanced → Outbounds** в формате JSON.

### Удаление

Удалите `V2RayXL.app` и следующие файлы:

- `/Library/Application Support/V2RayXL/`
- `~/Library/Application Support/V2RayXL/`
- `~/Library/Preferences/cenmrev.V2RayXL.plist`
