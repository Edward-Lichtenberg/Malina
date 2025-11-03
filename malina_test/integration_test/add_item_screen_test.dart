// integration_test/add_item_screen_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:malina/main.dart' as app;
import 'package:mobile_scanner/mobile_scanner.dart';
import 'dart:typed_data';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('AddItemScreen QR Flow', () {
    testWidgets('should detect valid QR and show snackbar', (tester) async {
      // ЗАПУСК ПРИЛОЖЕНИЯ
      app.main();
      await tester.pumpAndSettle();

      // ПЕРЕХОД НА КОРЗИНУ (CartScreen)
      await tester.tap(find.byIcon(Icons.shopping_cart));
      await tester.pumpAndSettle();

      // ПЕРЕХОД НА AddItemScreen
      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();

      // НАЖАТЬ "СКАНИРОВАТЬ QR"
      await tester.tap(find.text('Сканировать QR'));
      await tester.pumpAndSettle();

      // НАЙТИ MobileScanner
      final scannerFinder = find.byType(MobileScanner);
      final mobileScanner = tester.widget<MobileScanner>(scannerFinder);
      final onDetect = mobileScanner.onDetect;

      // СИМУЛИРОВАТЬ QR
      onDetect!(
        BarcodeCapture(
          barcodes: [
            Barcode(
              rawValue: 'food://banana',
              format: BarcodeFormat.qrCode,
              rawBytes: Uint8List.fromList([]),
            ),
          ],
        ),
      );

      await tester.pumpAndSettle();

      // ПРОВЕРКА
      expect(find.text('QR валиден: категория "food"'), findsOneWidget);
    });
  });
}
