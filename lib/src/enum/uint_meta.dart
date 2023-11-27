import 'dart:math';

/// Uint metadata
enum UintMeta {
  uint8,
  uint16,
  uint24,
  uint32,
  uint40,
  uint48,
  uint56,
  uint64;

  /// Size of uint in bytes.
  int get byteSize => index + 1;

  /// Max int value in field.
  int get maxValue => pow(2, byteSize * 8).toInt() - 1;

  /// Get random value in range.
  int random(Random generator) => generator.nextInt(maxValue);
}
