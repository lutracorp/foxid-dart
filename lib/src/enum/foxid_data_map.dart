import 'package:foxid/src/enum/uint_meta.dart';

/// Data mapping of FOxID.
enum FOxIDDataMap {
  timestamp(offset: 1, meta: UintMeta.uint48),
  datacenter(offset: 6, meta: UintMeta.uint16),
  worker(offset: 8, meta: UintMeta.uint16),
  counter(offset: 10, meta: UintMeta.uint24),
  random(offset: 13, meta: UintMeta.uint24);

  const FOxIDDataMap({
    required this.offset,
    required this.meta,
  });

  /// Value offset in bytes.
  final int offset;

  /// Metadata of uint used to store component.
  final UintMeta meta;
}
