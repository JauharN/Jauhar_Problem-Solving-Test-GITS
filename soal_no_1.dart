import 'dart:io';

// Rumus A000124: a(n) = 1 + (n-1)*n/2
List<int> generateA000124(int n) {
  if (n <= 0) return [];

  List<int> hasil = [];
  for (int i = 1; i <= n; i++) {
    int nilai = 1 + ((i - 1) * i) ~/ 2;
    hasil.add(nilai);
  }
  return hasil;
}

void main() {
  print('=== Program A000124 Sequence ===\n');

  // Demo 3 test case
  print('--- Demo Output ---');
  List<int> demoInputs = [7, 3, 10];
  for (int input in demoInputs) {
    List<int> sequence = generateA000124(input);
    print('Input: $input -> Output: ${sequence.join('-')}');
  }

  // Input dinamis
  print('\n--- Mode Input Dinamis ---');
  stdout.write('Masukkan nilai n (atau ketik "exit" untuk keluar): ');

  while (true) {
    String? input = stdin.readLineSync();

    if (input == null || input.trim().toLowerCase() == 'exit') {
      print('Program selesai.');
      break;
    }

    int? n = int.tryParse(input.trim());
    if (n == null || n <= 0) {
      stdout.write('Input tidak valid. Masukkan angka positif: ');
      continue;
    }

    List<int> sequence = generateA000124(n);
    print('Output: ${sequence.join('-')}');
    stdout.write('\nMasukkan nilai n lagi (atau "exit"): ');
  }
}
