# Enjin Wallet Daemon UI

[![License: LGPL 3.0](https://img.shields.io/badge/license-LGPL_3.0-purple)](https://opensource.org/license/lgpl-3-0/)
[![GitHub Release](https://img.shields.io/github/release/enjin/wallet-daemon-ui.svg?style=flat)]()
[![Discord](https://img.shields.io/discord/783393889548501023)](https://discord.gg/EUKexwF5RM)
[![Medium](https://img.shields.io/badge/Medium-gray?logo=medium)](https://medium.com/@enjin)

This repository contains a flutter desktop application for macOS / Linux / Windows. It makes it easier to run the [Enjin Wallet Daemon](https://github.com/enjin/wallet-daemon) for people that want to try out [Enjin Platform Cloud](https://platform.canary.enjin.io). For a production environment, we recommend that you run the Enjin Wallet Daemon on [an isolated server](https://docs.enjin.io/enjin-platform/getting-started/wallet-daemon#running-the-daemon-in-isolation).

## Build from source

To build from source you need the following requirements:

- [Flutter](https://docs.flutter.dev/get-started/install)
- Desktop (macOS / Linux / Windows)

You can then clone the repository and run the application through flutter with:

`flutter run <platform>` (macos, windows, linux)

## Binaries

Or you can download the [latest binaries](https://github.com/enjin/wallet-daemon-ui/releases/latest) directly, extract and run.

## Security

The Enjin Wallet Daemon UI is just a wrapper around the [Enjin Wallet Daemon](https://github.com/enjin/wallet-daemon). When you first start the application, it will download the latest release of the daemon and ask you for a password.

> [!WARNING] 
> We generate an encryption key with the password. This key will be used to encrypt the database that contains your **seed phrase**.
> It is important that you **DO NOT LOSE** this password. There is absolutely no way to recover your information if you lose it.
> Also, make sure you use a safe password and do not share with anyone.

After you start the daemon for the first time, a new random seed phrase will be generated for you. You can find your generated seed under `Configs >> Seed Phrase`.
The seed phrase together with the password `Configs >> Password` is all of the information needed to import your daemon wallet anywhere.

> [!NOTE]
> Just the seed phrase is not enough to import or have access to your daemon wallet.
> You **DO** need both the seed phrase and the wallet password, **not the UI password**, please make sure you save those in a secure place. 
> Anyone that may have access to those will have full control over your daemon wallet.

## Enjin Platform Cloud

For your daemon to work with Enjin Platform Cloud you need to set up your Platform API keys into `Configs`. You may set one key for each of the environment: [Enjin Blockchain](https://platform.enjin.io) and [Canary Blockchain (testnet)](https://platform.canary.enjin.io).

The Canary Matrixchain can be used for making tests without spending real money. There is also a faucet that you can use to get funds available here [Canary Faucet](https://faucet.canary.enjin.io/).

## Self-hosted Platform

If you are self-hosting your Enjin Platform, you can input its URL and credentials at `Custom Endpoint`.

- **Platform Endpoint**: You need to input the `graphql` endpoint of your platform.
- **Authentication Token**: The token that you use to access it. If you are using our [starter repository](https://github.com/enjin/platform) this token can be found [here](https://github.com/enjin/platform/blob/16586cc39888f39a900b2d90f0b0d9d20028cb67/configs/core/.env#L9), it will be auto generated after you first start the platform.
- **Blockchain Node**: That's the RPC url to a node, it needs to be a websocket url and you need to include the port. Example: wss://rpc.matrix.blockchain.enjin.io:443

## Locking

It is possible to keep running the daemon while the interface is locked. You only need to click in the lock button. This lock screen will also appear everytime you start the application after the first time.

The password used here is what you have input in the onboard. **Remember** if you lose it, you will need to reset the platform UI and you will lose access to your daemon wallet.

## Background service

Since the UI is only a wrapper around our rust service, both application are run in separated processes. If you close the UI normally through the close button it will stop the service automatically. **BUT** if you force close it through the task manager or if it crashes for any reason, the daemon service may still keep running in the background.

If you want to check if the service is still running you can search for the `wallet` process in the task manager.

## Changelog

Please see [CHANGELOG](CHANGELOG.md) for more information on what has changed recently.

## Contributing

Please see [CONTRIBUTING](.github/CONTRIBUTING.md) for details.

## Security Vulnerabilities

Please review [our security policy](../../security/policy) on how to report security vulnerabilities.

## Credits

- [Enjin](https://github.com/enjin)
- [All Contributors](../../contributors)

## License

The LGPL 3.0 License. Please see [License File](LICENSE.md) for more information.