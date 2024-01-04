import 'platform/universal.dart' if (dart.library.io) 'platform/io.dart';

/// FOxID generator helper.
abstract class FOxIDHelper {
  /// Default datacenter id.
  int get datacenter;

  /// Default worker id.
  int get worker;

  /// Create helper for current platform.
  factory FOxIDHelper() => helper;
}
