# Secure P256 Flutter plugin

[![Pub](https://img.shields.io/pub/v/variance_flutter_secp256r1?color=42a012&include_prereleases&logo=dart&style=flat-square)](https://pub.dev/packages/variance_flutter_secp256r1)
[![License](https://img.shields.io/github/license/vaariance/flutter_secp256r1?style=flat-square)](https://github.com/vaariance/flutter_secp256r1/blob/main/LICENSE)

A Flutter plugin that support secp256r1 by *Keystore on Android* and *Secure Enclave on iOS*.

This is rewrite of `flutter_secp256r1` without dependence on `agent_dart` for our use case.
uses `flutter_cryptography` built in aes256gcm for encrypt/decrypt.

## Methods

- `SecureP256.getPublicKey`
- `SecureP256.sign`
- `SecureP256.verify`
