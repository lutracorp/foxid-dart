import 'dart:math';

import '../../enum/foxid_data_map.dart';
import '../helper.dart';

/// FOxID generator helper that works everywhere.
class FOxIDHelperUniversal implements FOxIDHelper {
  static final Random _random = Random.secure();

  @override
  int datacenter = FOxIDDataMap.datacenter.meta.random(_random);

  @override
  int worker = FOxIDDataMap.worker.meta.random(_random);
}

FOxIDHelper get helper => FOxIDHelperUniversal();
