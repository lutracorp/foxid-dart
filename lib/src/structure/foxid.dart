import 'dart:math';
import 'dart:typed_data';

import 'package:base32/base32.dart';
import 'package:base32/encodings.dart';

import '../enum/foxid_data_map.dart';
import '../extension/uint_byte_data.dart';

/// A class for manipulating FoxCord FOxID's.
class FOxID {
  /// The encoding in which FOxID is represented as a string.
  static const Encoding _stringEncoding = Encoding.crockford;

  /// The byte order used in FOxID.
  static const Endian _endian = Endian.big;

  /// Length of FOxID in bytes.
  static const int _byteLength = 16;

  /// Secure randomness generator.
  static final Random _random = Random.secure();

  /// Default generator id.
  static final int _generator = FOxIDDataMap.generator.meta.random(_random);

  /// Counter that increments every time when new id created.
  static int _increment = 0;

  /// Payload of this FOxID.
  late final Uint8List payload;

  /// Creates FOxID with empty payload.
  FOxID.empty() : payload = Uint8List(_byteLength);

  /// Creates FOxID with predefined payload.
  FOxID.fromUint8List(this.payload) {
    if (payload.lengthInBytes != _byteLength) {
      throw FormatException("Invalid FOxID byte length.");
    }
  }

  /// Extracts FOxID from its string representation.
  factory FOxID.fromJson(String json) => FOxID.fromUint8List(
        base32.decode(json, encoding: _stringEncoding),
      );

  /// Generates FOxID with predefined parameters.
  factory FOxID.generate({
    DateTime? time,
    int? generator,
    int? datacenter,
    int? worker,
    int? counter,
    int? random,
  }) {
    final FOxID result = FOxID.empty()
      ..time = time ?? DateTime.now()
      ..counter = counter ?? _increment++
      ..random = random ?? FOxIDDataMap.random.meta.random(_random);

    if (datacenter != null || worker != null) {
      result
        ..datacenter = datacenter ?? 0
        ..worker = worker ?? 0;
    } else {
      result.generator = generator ?? _generator;
    }

    return result;
  }

  /// Reader/Writer of internal FOxID byte-buffer.
  ByteData get _view => ByteData.view(payload.buffer);

  /// Time when this FOxID generated.
  DateTime get time =>
      DateTime.fromMillisecondsSinceEpoch(timestamp, isUtc: true);

  /// Sets the time when this FOxID generated.
  set time(DateTime value) => timestamp = value.toUtc().millisecondsSinceEpoch;

  /// The number of milliseconds since the start of the epoch.
  int get timestamp => _view.getUint(FOxIDDataMap.timestamp, _endian);

  /// Sets the timestamp of the current FOxID.
  set timestamp(int value) =>
      _view.setUint(FOxIDDataMap.timestamp, value, _endian);

  /// The identifier of the generator that created this FOxID.
  int get generator => _view.getUint(FOxIDDataMap.generator, _endian);

  /// Sets identifier of the generator that created this FOxID.
  set generator(int value) =>
      _view.setUint(FOxIDDataMap.generator, value, _endian);

  /// The identifier of the datacenter that created this FOxID.
  int get datacenter => _view.getUint(FOxIDDataMap.datacenter, _endian);

  /// Sets identifier of the datacenter that created this FOxID.
  set datacenter(int value) =>
      _view.setUint(FOxIDDataMap.datacenter, value, _endian);

  /// The identifier of the worker that created this FOxID.
  int get worker => _view.getUint(FOxIDDataMap.worker, _endian);

  /// Sets identifier of the worker that created this FOxID.
  set worker(int value) => _view.setUint(FOxIDDataMap.worker, value, _endian);

  /// Counter that incremented each time when new FOxID is created.
  int get counter => _view.getUint(FOxIDDataMap.counter, _endian);

  /// Sets the value of the counter, which should be incremented each time a new FOxID is created.
  set counter(int value) => _view.setUint(FOxIDDataMap.counter, value, _endian);

  /// Random value obtained at the time of identifier generation.
  int get random => _view.getUint(FOxIDDataMap.random, _endian);

  /// Sets of random value that is normally obtained at the time when identifier is generated.
  set random(int value) => _view.setUint(FOxIDDataMap.random, value, _endian);

  /// Encode this FOxID to string.
  String toJson() => base32.encode(payload, encoding: _stringEncoding);
}
