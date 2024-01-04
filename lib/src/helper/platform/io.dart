import 'dart:io';

import '../helper.dart';

/// FOxID generator helper that depends on dart:io.
class FOxIDHelperIO implements FOxIDHelper {
  @override
  int datacenter = int.fromEnvironment('FOXID_DATACENTER',
      defaultValue: Platform.localHostname.hashCode);

  @override
  int worker = int.fromEnvironment('FOXID_WORKER', defaultValue: pid);
}

FOxIDHelper get helper => FOxIDHelperIO();
