import 'dart:math' as math;
import 'dart:typed_data';

import 'extensions.dart';
import 'utils.dart';

const _defaultLength = 32;

final bn53 = BigInt.parse(
  '11111111111111111111111111111111111111111111111111111',
  radix: 2,
);

Uint8List getRandomValues([int length = _defaultLength]) {
  final DartRandom rn = DartRandom(math.Random.secure());
  String entropy = rn.nextBigInteger(length * 8).toRadixString(16);

  if (entropy.length > length * 2) {
    entropy = entropy.substring(0, length * 2);
  }

  String randomPers = rn.nextBigInteger(length * 8).toRadixString(16);

  if (randomPers.length > length * 2) {
    randomPers = randomPers.substring(0, length * 2);
  }
  return randomPers.toU8a();
}

String randomAsHex([int length = 32]) {
  return u8aToHex(randomAsU8a(length));
}

int randomAsNumber() {
  return (hexToBn(randomAsHex(8)) & bn53).toInt();
}

Uint8List randomAsU8a([int length = _defaultLength]) {
  return getRandomValues(length);
}

class DartRandom {
  final math.Random dartRandom;

  const DartRandom(this.dartRandom);

  String get algorithmName => 'DartRandom';

  BigInt nextBigInteger(int bitLength) {
    final int fullBytes = bitLength ~/ 8;
    // Generate a number from the full bytes.
    // Then, prepend a smaller number covering the remaining bits.
    final BigInt main = bytesToInt(nextBytes(fullBytes));
    // Forcing remaining bits to be calculate with bits length.
    final int remainingBits = bitLength - main.bitLength;
    final int additional = remainingBits < 4
        ? dartRandom.nextInt(math.pow(2, remainingBits).toInt())
        : remainingBits;
    final BigInt additionalBit = BigInt.from(additional) << (fullBytes * 8);
    final BigInt result = main + additionalBit;
    return result;
  }

  Uint8List nextBytes(int count) {
    return Uint8List.fromList(List.generate(count, (_) => nextUint8()));
  }

  int nextUint16() => dartRandom.nextInt(math.pow(2, 32).toInt());

  int nextUint32() => dartRandom.nextInt(math.pow(2, 32).toInt());

  int nextUint8() => dartRandom.nextInt(math.pow(2, 8).toInt());
}
