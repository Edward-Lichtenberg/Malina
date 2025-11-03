// test/add_item_screen_widget_test.dart
// ТЕСТ: Сканирование QR в AddItemScreen
// ЦЕЛЬ: Проверить, что при валидном QR показывается SnackBar
// ИСПОЛЬЗУЕТСЯ: integration_test + мок MobileScanner

import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:malina/main.dart' as app;
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'mocks/mobile_scanner_mock.dart';

@GenerateMocks([MobileScannerController])
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('AddItemScreen QR Flow', () {
    late MockMobileScannerController mockController;

    setUp(() {
      mockController = MockMobileScannerController();
    });

    testWidgets('should detect valid QR and show snackbar', (
      WidgetTester tester,
    ) async {
      // ЗАПУСК ПРИЛОЖЕНИЯ
      app.main();
      await tester.pumpAndSettle();

      // ПЕРЕХОД НА ЭКРАН ДОБАВЛЕНИЯ ТОВАРА
      // (предполагается, что на главном экране есть кнопка "Добавить")
      await tester.tap(find.text('Добавить'));
      await tester.pumpAndSettle();

      // НАЖАТИЕ НА КНОПКУ "СКАНИРОВАТЬ QR"
      await tester.tap(find.text('Сканировать QR'));
      await tester.pumpAndSettle();

      // НАХОДИМ ВИДЖЕТ MobileScanner
      final scannerFinder = find.byType(MobileScanner);
      expect(scannerFinder, findsOneWidget);

      // ПОЛУЧАЕМ callback onDetect
      final mobileScanner = tester.widget<MobileScanner>(scannerFinder);
      final onDetect = mobileScanner.onDetect;

      // СИМУЛИРУЕМ СКАНИРОВАНИЕ QR
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

      // ЖДЁМ ОБНОВЛЕНИЯ UI
      await tester.pumpAndSettle();

      // ПРОВЕРКА: ДОЛЖЕН ПОЯВИТЬСЯ SnackBar
      expect(find.text('QR валиден: категория "food"'), findsOneWidget);
    });

    // ДОПОЛНИТЕЛЬНЫЙ ТЕСТ: Невалидный QR
    testWidgets('should show error for invalid QR', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      await tester.tap(find.text('Добавить'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Сканировать QR'));
      await tester.pumpAndSettle();

      final scannerFinder = find.byType(MobileScanner);
      final mobileScanner = tester.widget<MobileScanner>(scannerFinder);
      final onDetect = mobileScanner.onDetect;

      onDetect!(
        BarcodeCapture(
          barcodes: [
            Barcode(
              rawValue: 'invalid://123',
              format: BarcodeFormat.qrCode,
              rawBytes: Uint8List.fromList([]),
            ),
          ],
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('Невалидный QR'), findsOneWidget);
    });
  });
}
