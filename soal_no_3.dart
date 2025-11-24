// Ubah string jadi list digit secara rekursif
List<int> stringKeDigit(String s, int index, List<int> hasil) {
  if (index >= s.length) return hasil;
  hasil.add(int.parse(s[index]));
  return stringKeDigit(s, index + 1, hasil);
}

// Ubah list digit jadi string secara rekursif
String digitKeString(List<int> digits, int index) {
  if (index >= digits.length) return '';
  String sisanya = digitKeString(digits, index + 1);
  return sisanya.isEmpty ? '${digits[index]}' : '${digits[index]}$sisanya';
}

// Tahap 1: Buat palindrome minimal, catat posisi yang diubah
int buatPalindrome(List<int> digits, int kiri, int kanan, List<bool> diubah) {
  if (kiri >= kanan) return 0;

  if (digits[kiri] == digits[kanan]) {
    return buatPalindrome(digits, kiri + 1, kanan - 1, diubah);
  }

  // Ubah yang lebih kecil jadi yang lebih besar
  if (digits[kiri] > digits[kanan]) {
    digits[kanan] = digits[kiri];
    diubah[kanan] = true;
  } else {
    digits[kiri] = digits[kanan];
    diubah[kiri] = true;
  }

  return 1 + buatPalindrome(digits, kiri + 1, kanan - 1, diubah);
}

// Tahap 2: Maksimalkan jadi 9 dengan sisa perubahan
int maksimalKe9(
  List<int> digits,
  int kiri,
  int kanan,
  List<bool> diubah,
  int sisa,
) {
  if (kiri > kanan) return sisa;

  // Untuk posisi tengah di string ganjil
  if (kiri == kanan) {
    if (sisa > 0 && digits[kiri] != 9) {
      digits[kiri] = 9;
      sisa--;
    }
    return sisa;
  }

  // Kalo udah 9 semua, skip
  if (digits[kiri] == 9 && digits[kanan] == 9) {
    return maksimalKe9(digits, kiri + 1, kanan - 1, diubah, sisa);
  }

  // Kalo salah satu udah diubah di tahap 1, cuma perlu 1 perubahan lagi
  if (diubah[kiri] || diubah[kanan]) {
    if (sisa >= 1) {
      digits[kiri] = 9;
      digits[kanan] = 9;
      sisa--;
    }
  } else {
    // Kalo belum diubah sama sekali, perlu 2 perubahan
    if (sisa >= 2) {
      digits[kiri] = 9;
      digits[kanan] = 9;
      sisa -= 2;
    }
  }

  return maksimalKe9(digits, kiri + 1, kanan - 1, diubah, sisa);
}

String highestPalindrome(String s, int k) {
  List<int> digits = stringKeDigit(s, 0, []);
  List<bool> diubah = List.filled(digits.length, false);

  // Tahap 1: buat palindrome dulu
  int perubahanMinimal = buatPalindrome(digits, 0, digits.length - 1, diubah);

  // Kalo perubahan minimal lebih besar dari k, ga mungkin
  if (perubahanMinimal > k) return '-1';

  // Tahap 2: maksimalkan digit jadi 9 dengan sisa k
  int sisaPerubahan = k - perubahanMinimal;
  maksimalKe9(digits, 0, digits.length - 1, diubah, sisaPerubahan);

  return digitKeString(digits, 0);
}

void main() {
  print('=== Program Highest Palindrome ===\n');

  // Test case 1 (dari soal)
  print('Test Case 1:');
  String s1 = '3943';
  int k1 = 1;
  String hasil1 = highestPalindrome(s1, k1);
  print('Input: s="$s1", k=$k1');
  print('Output: $hasil1');
  print('Expected: 3993 ${hasil1 == '3993' ? '✓' : '✗'}\n');

  // Test case 2 (dari soal)
  print('Test Case 2:');
  String s2 = '932239';
  int k2 = 2;
  String hasil2 = highestPalindrome(s2, k2);
  print('Input: s="$s2", k=$k2');
  print('Output: $hasil2');
  print('Expected: 992299 ${hasil2 == '992299' ? '✓' : '✗'}\n');

  // Test case 3
  print('Test Case 3:');
  String s3 = '12321';
  int k3 = 1;
  String hasil3 = highestPalindrome(s3, k3);
  print('Input: s="$s3", k=$k3');
  print('Output: $hasil3\n');
}
