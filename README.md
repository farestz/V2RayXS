# V2RayXS: A simple GUI for Xray on macOS

[![GitHub release (latest SemVer)](https://img.shields.io/github/v/release/farestz/V2RayXS)](https://github.com/farestz/V2RayXS/releases)
![GitHub release (latest by date)](https://img.shields.io/github/downloads/farestz/V2RayXS/latest/total)
[![GitHub Workflow Status](https://img.shields.io/github/actions/workflow/status/farestz/V2RayXS/build-actions.yml)](https://github.com/farestz/V2RayXS/actions/workflows/build-actions.yml)

**Attention**: If you want to use v2ray-core version please install the original project. <https://github.com/Cenmrev/V2RayX>

> This repo is an active fork of [tzmax/V2RayXS](https://github.com/tzmax/V2RayXS),
> which is based on [Cenmrev/V2RayX](https://github.com/Cenmrev/V2RayX). It uses
> [Xray-core](https://github.com/XTLS/Xray-core) to support VLESS and XTLS protocols.
> Copyright of the original application belongs to [@Cenmrev](https://github.com/Cenmrev).
> Tribute to [@Cenmrev](https://github.com/Cenmrev), [@tzmax](https://github.com/tzmax),
> and the [@XTLS](https://github.com/XTLS) community.

## What is XTLS? Xray?

**READ THIS**: [XTLS? Xray? V2Ray?](https://xtls.github.io).

**YOU SHOULD READ XTLS'S OFFICIAL INSTRUCTION BEFORE USING V2RAYXS!**

## Download V2RayXS

Download from [Releases](https://github.com/farestz/V2RayXS/releases).

## How to build

V2RayXS.app is built by running one of the following commands in your terminal. You can install this via the command-line with curl.

`sh -c "$(curl -fsSL https://raw.githubusercontent.com/farestz/V2RayXS/master/compilefromsource.sh)"`

or step by step:

`git clone --recursive https://github.com/farestz/V2RayXS.git`

open V2RayXS.xcodeproj and use Xcode to build V2RayXS.

## How does V2RayXS work

V2RayXS provides a GUI to generate the config file for V2Ray. It includes Xray's binary executable in the app bundle. V2RayXS starts and stops V2Ray with `launchd` of macOS.

V2RayXS also allows users to change system proxy settings and switch proxy servers on the macOS menu bar.

As default, V2RayXS will open a socks5 proxy at port `1081` as the main inbound, as well as a http proxy at port `8001` as an inboundDetour.

V2RayXS provide three modes:

-   Global Mode: V2RayXS asks macOS to route all internet traffic to xray core if the network traffic obeys operating system's network rules.
-   PAC Mode: macOS will determine the routing based on a pac file and some traffic may be routed to xray core.
-   Manual Mode: V2RayXS will not modify any macOS network settings, but only start or stop xray core.


Options in menu list `Routing Rule` determine how xray core deals with incoming traffic. Core routing rules apply to all three modes above.

### auto-run on login

Open macOS System Preferences -> Users & Group -> Login Items, add V2RayXS.app to
the list.

### manually update xray-core

replace `V2RayXS.app/Contents/Resources/v2ray` with the newest xray
version from [xray-core
repo](https://github.com/XTLS/Xray-core/releases). However, compatibility is not guaranteed.

> If you want to use v2ray-core version please install the original project. <https://github.com/Cenmrev/V2RayX>

### Uninstall

V2RayXS will create the following files and folders:

-   `/Library/Application Support/V2RayXS`
-   `~/Library/Application Support/V2RayXS`
-   `~/Library/Preferences/cenmrev.V2RayXS.plist`

So, to totally uninstall V2RayXS, just delete V2RayXS.app and the files above. :)

## Other protocols supported

Thanks to the excellent implementation of [Xray core](https://github.com/XTLS/Xray-core), the client supports multiple protocols such as Shadowsocks, Socks, Trojan, Wireguard as outbounds protocols.

First of all, I would like to explain here why the current GUI configuration only supports `VMess` and `VLESS` configuration for the time being, because the workload of adapting all outbounds is not small, and each protocol is constantly updated. Due to the current layout of hard-coding implementation, the GUI configuration page requires the cost of updating and maintaining the software for each protocol update is very high (if anyone is willing to adapt, I am willing to review it). The benefits of this is not as good as having a setting function that can directly configure the json configuration of outbounds, so I think that's what [@Cenmrev](https://github.com/Cenmrev) thought when he designed the `Advanced / Outbounds` function.

Because more people have asked before issues [#18](https://github.com/tzmax/V2RayXS/issues/18) [#34](https://github.com/tzmax/V2RayXS/issues/34) [#52](https://github.com/tzmax/V2RayXS/issues/52) (including recent friends also asking how to use `Trojan` with V2RayXS?), so I took time to write this explanation.

Next, I will try to introduce how to import `Trojan` outbounds in V2RayXS and make them work (I will use the oral method. If anyone is willing to write a GUI screenshot operation blog or related documents, I would be happy to merge or link here).

1. You need to know what the **subscription address is**, what the **URL sharing link** is, and what the **JSON configuration** file is. If it is a subscription address or URL sharing link, you need to convert it to a **JSON configuration** file first (if you don't know how to convert, please use the client of other platforms to import and then select the specified node before exporting the JSON configuration file).

2. After obtaining the complete JSON configuration file, the general configuration file content is as follows (the following configuration example comes from [Xray-examples/Trojan-TCP-XTLS](https://github.com/XTLS/Xray-examples/blob/main/Trojan-TCP-XTLS/config_client.json), and the content of the configuration files of different protocols may vary greatly)

```json
{
    "log": {
        "loglevel": "debug"
    },
    "inbounds": [
        {
            "port": 1080,
            "listen": "127.0.0.1",
            "protocol": "socks",
            "settings": {
                "udp": true
            }
        },
        {
            "port": 1081,
            "protocol": "http",
            "sniffing": {
              "enabled": true,
              "destOverride": ["http", "tls"]
            },
            "settings": {
              "auth": "noauth"
            }
        }
    ],
    "outbounds": [
        {
            "protocol": "trojan",
            "settings": {
                "servers": [
                    {
                        "address": "example.com",  // your domain name or server IP
                        "flow": "xtls-rprx-direct",  // Linux or android can be changed to "xtls-rprx-splice"
                        "port": 443,
                        "password": "your_password"  // your password
                    }
                ]
            },
            "streamSettings": {
                "network": "tcp",
                "security": "xtls",
                "xtlsSettings": {
                    "serverName": "example.com"  // your domain name
                }
            }
        }
    ]
}
```

3. Take out the `outbounds` part of the field. If there are more than one, please choose the most suitable one (I will delete the comment information in the example, because this is an irregular JSON format), and finally get the following JSON configuration information.

```json
{
    "protocol": "trojan",
    "settings": {
        "servers": [
            {
                "address": "example.com",
                "flow": "xtls-rprx-direct",
                "port": 443,
                "password": "your_password"
            }
        ]
    },
    "streamSettings": {
        "network": "tcp",
        "security": "xtls",
        "xtlsSettings": {
            "serverName": "example.com"
        }
    }
}
```

4. Add the `tag` field to the configuration data. **TAG** is used to identify the server configuration, which can help you find it in the server list.

```json
{
    "tag" : "⭐️ MyTrojanNode",
    "protocol": "trojan",
    "settings": {
        "servers": [
            {
                "address": "example.com",
                "flow": "xtls-rprx-direct",
                "port": 443,
                "password": "your_password"
            }
        ]
    },
    "streamSettings": {
        "network": "tcp",
        "security": "xtls",
        "xtlsSettings": {
            "serverName": "example.com"
        }
    }
}
```

5. Open `Configure` -> `Advanced` -> `Outbounds`, click Add to replace the input box with the **JSON configuration data** above, then click `Finish` to complete the addition, and click 'OK` on the configuration page to save the data.

6. Open the V2RayXS menu bar and select `Server`. Now you should be able to see the `⭐️ MyTrojanNode` server. Select it and use it to take you where you want to go.

Of course, you can also use it to control your `VMess` and `VLESS` configuration in more detail (**note: the configuration here will not appear in the Config configuration panel, but will only appear in the Server list**). For more protocol configurations, please refer to the following link.

- [Shadowsocks](https://xtls.github.io/en/config/outbounds/shadowsocks.html) 
- [Socks](https://xtls.github.io/en/config/outbounds/socks.html)
- [Trojan](https://xtls.github.io/en/config/outbounds/trojan.html)
- [VLESS](https://xtls.github.io/en/config/outbounds/vless.html)
- [VMess](https://xtls.github.io/en/config/outbounds/vmess.html)
- [Wireguard](https://xtls.github.io/en/config/outbounds/wireguard.html)
- And others that are supported by `Xray core`

## Acknowledge

This repo is based on the [Cenmrev/V2RayX](https://github.com/Cenmrev/V2RayX) project for maintenance and update.

V2RayXS uses [GCDWebServer](https://github.com/swisspol/GCDWebServer) to provide a local pac server. V2RayXS also uses many ideas and codes from [ShadowsocksX](https://github.com/shadowsocks/shadowsocks-iOS/tree/master), especially, the codes of [v2rays_sysconfig](https://github.com/farestz/V2RayXS/blob/master/v2rayx_sysconf/main.m) are simply copied from [shadowsocks_sysconf](https://github.com/shadowsocks/shadowsocks-iOS/blob/master/shadowsocks_sysconf/main.m) with some modifications.

## Donation

If Project V2Ray or V2RayX (V2RayXS) helped you, you can also help us by donation **in your will**. 

To donate to Project V2Ray, you may refer to [this page](https://www.v2ray.com/chapter_00/02_donate.html).

To donate to Project Xray, you may refer to [this page](https://xtls.github.io/#%E5%B8%AE%E5%8A%A9-xray-%E5%8F%98%E5%BE%97%E6%9B%B4%E5%BC%BA).

