// Утилита: Валидация QR (Single Responsibility)
String? validateQRCode(String code) {
  if (code.startsWith('food')) {
    return 'food';
  } else if (code.startsWith('beauty')) {
    return 'beauty';
  }
  return null;
}
