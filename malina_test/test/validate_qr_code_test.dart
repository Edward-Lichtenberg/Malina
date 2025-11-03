import 'package:flutter_test/flutter_test.dart';
import 'package:malina/src/feature/screens/add_item_screen/data/utils/validate_qr_code.dart';

void main() {
  group('validateQRCode', () {
    test('should return "food" for food:// QR', () {
      expect(validateQRCode('food://apple'), equals('food'));
    });

    test('should return "beauty" for beauty:// QR', () {
      expect(validateQRCode('beauty://cream'), equals('beauty'));
    });

    test('should return null for invalid QR', () {
      expect(validateQRCode('invalid://123'), isNull);
      expect(validateQRCode(''), isNull);
      expect(validateQRCode('food'), isNull); // не начинается с 'food://'
    });

    test('should be case-sensitive', () {
      expect(validateQRCode('FOOD://apple'), isNull);
      expect(validateQRCode('Beauty://cream'), isNull);
    });
  });
}
