import 'package:flutter/foundation.dart';

import 'der.dart';

typedef BinaryBlob = Uint8List;

typedef DerEncodedBlob = BinaryBlob;

enum BlobType { binary, der, nonce, requestId }

class P256PublicKey implements PublicKey {
  final BinaryBlob rawKey;

  late final derKey = P256PublicKey.derEncode(rawKey);

  P256PublicKey(this.rawKey) : assert(rawKey.isNotEmpty);

  factory P256PublicKey.from(PublicKey key) {
    return P256PublicKey.fromDer(key.toDer());
  }

  factory P256PublicKey.fromDer(BinaryBlob derKey) {
    return P256PublicKey(P256PublicKey.derDecode(derKey));
  }
  factory P256PublicKey.fromRaw(BinaryBlob rawKey) {
    return P256PublicKey(rawKey);
  }

  @override
  Uint8List toDer() => derKey;

  Uint8List toRaw() => rawKey;

  static Uint8List derDecode(BinaryBlob publicKey) {
    return bytesUnwrapDer(publicKey, oidP256);
  }

  static Uint8List derEncode(BinaryBlob publicKey) {
    return bytesWrapDer(publicKey, oidP256);
  }
}

@immutable
abstract class PublicKey {
  const PublicKey();

  // Get the public key bytes encoded with DER.
  DerEncodedBlob toDer();
}

extension ExtBinaryBlob on BinaryBlob {
  BlobType get blobType => BlobType.binary;

  int get byteLength => lengthInBytes;

  String get name => '__BLOB';

  static Uint8List from(Uint8List other) => Uint8List.fromList(other);
}
