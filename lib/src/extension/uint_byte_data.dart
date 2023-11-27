import 'dart:typed_data';

import '../enum/foxid_data_map.dart';
import '../enum/uint_meta.dart';

/// Extension that adds missing uint data types.
extension UintByteData on ByteData {
  /// Returns the bit shift needed to represent different uint's as a set of consecutive uint8.
  static int getShift(int byte, UintMeta meta, [Endian endian = Endian.big]) =>
      (endian == Endian.little ? byte : meta.byteSize - 1 - byte) * 8;

  /// Sets the [numBytes] bytes starting at the specified [byteOffset] in this object
  /// to the unsigned binary representation of the specified [value],
  /// which must fit in [numBytes] bytes.
  ///
  /// In other words, [value] must be between
  /// 0 and 2<sup>([numBytes] * 8)</sup> - 1, inclusive.
  ///
  /// The [byteOffset] must be non-negative, and
  /// `byteOffset + numBytes` must be less than or equal to the length of this object.
  void setUint(FOxIDDataMap mapping, int value, [Endian endian = Endian.big]) {
    for (int byte = 0; byte < mapping.meta.byteSize; byte++) {
      int shift = getShift(byte, mapping.meta, endian);
      int byteValue = (value >> shift) & 0xFF;
      setUint8(mapping.offset + byte, byteValue);
    }
  }

  /// Returns the positive integer represented by the [numBytes] bytes starting
  /// at the specified [byteOffset] in this object, in unsigned binary
  /// form.
  ///
  /// The return value will be between 0 and  2<sup>([numBytes] * 8)</sup> - 1, inclusive.
  ///
  /// The [byteOffset] must be non-negative, and
  /// `byteOffset + numBytes` must be less than or equal to the length of this object.
  int getUint(FOxIDDataMap mapping, [Endian endian = Endian.big]) {
    int result = 0;
    for (int byte = 0; byte < mapping.meta.byteSize; byte++) {
      int shift = getShift(byte, mapping.meta, endian);
      int byteValue = getUint8(mapping.offset + byte);
      result |= (byteValue << shift);
    }
    return result;
  }
}
