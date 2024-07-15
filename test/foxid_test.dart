import 'package:foxid/foxid.dart';
import 'package:test/test.dart';

Future<void> main() async {
  group(FOxID, () {
    test('should create empty FOxID', () {
      final FOxID foxid = FOxID.empty();

      expect(foxid.timestamp, 0);
      expect(foxid.datacenter, 0);
      expect(foxid.worker, 0);
      expect(foxid.counter, 0);
      expect(foxid.random, 0);
    });

    test('should decode valid FOxID from string', () {
      final FOxID foxid = FOxID.fromJson('065DTQHTA65T6JGMGBCTXT9P1M');

      expect(foxid.timestamp, 1695931054673);
      expect(foxid.datacenter, 35747);
      expect(foxid.worker, 18964);
      expect(foxid.counter, 8575406);
      expect(foxid.random, 15283725);
    });

    test('should not decode invalid FOxID from string', () {
      expect(() => FOxID.fromJson(''), throwsFormatException);
    });

    test('should generate FOxID with predefined variables', () {
      final FOxID foxid = FOxID.generate(
        datacenter: 10,
        worker: 20,
        counter: 30,
        random: 40,
      );

      expect(foxid.datacenter, 10);
      expect(foxid.worker, 20);
      expect(foxid.counter, 30);
      expect(foxid.random, 40);
    });

    test('should detect that FOxIDs are not equal', () {
      final FOxID first = FOxID.empty();
      final FOxID second = FOxID.generate();

      expect(first != second, true);
    });

    test('should detect that FOxIDs are equal', () {
      const String canonical = '065DTQHTA65T6JGMGBCTXT9P1M';

      final FOxID first = FOxID.fromJson(canonical);
      final FOxID second = FOxID.fromJson(canonical);

      expect(first == second, true);
    });
  });
}
