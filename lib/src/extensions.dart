import 'dart:typed_data';

import 'package:collection/collection.dart';

import 'utils.dart' as utils;

bool u8aEq(Uint8List a, Uint8List b) {
  return const ListEquality().equals(a, b);
}

extension AgentStringExtension on String {
  String hexStripPrefix() => utils.strip0xHex(this);

  BigInt hexToBn({Endian endian = Endian.big, bool isNegative = false}) =>
      utils.hexToBn(this, endian: endian, isNegative: isNegative);

  bool isHex({int bits = -1, bool ignoreLength = false}) =>
      utils.isHex(this, bits: bits, ignoreLength: ignoreLength);

  Uint8List toU8a({int bitLength = -1}) => utils.hexToU8a(this, bitLength);
}

extension AgentU8aExtension on Uint8List {
  bool eq(Uint8List other) => u8aEq(this, other);
}
