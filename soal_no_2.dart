List<int> denseRanking(List<int> leaderboard, List<int> skorGits) {
  // Ambil nilai unik dari leaderboard (descending)
  List<int> skorUnik = [];
  for (int skor in leaderboard) {
    if (skorUnik.isEmpty || skorUnik.last != skor) {
      skorUnik.add(skor);
    }
  }

  // Cari ranking tiap skor pake binary search
  int cariRank(int skor) {
    int kiri = 0;
    int kanan = skorUnik.length - 1;
    int posisi = skorUnik.length;

    while (kiri <= kanan) {
      int tengah = (kiri + kanan) ~/ 2;
      if (skorUnik[tengah] <= skor) {
        posisi = tengah;
        kanan = tengah - 1;
      } else {
        kiri = tengah + 1;
      }
    }

    return posisi == skorUnik.length ? posisi + 1 : posisi + 1;
  }

  List<int> hasilRanking = [];
  for (int skor in skorGits) {
    hasilRanking.add(cariRank(skor));
  }

  return hasilRanking;
}

void main() {
  print('======= Program Dense Ranking =======\n');

  // Test case 1 (dari soal)
  print('Test Case 1:');
  List<int> leaderboard1 = [100, 100, 50, 40, 40, 20, 10];
  List<int> skorGits1 = [5, 25, 50, 120];
  List<int> ranking1 = denseRanking(leaderboard1, skorGits1);
  print('Leaderboard: $leaderboard1');
  print('Skor GITS: $skorGits1');
  print('Ranking: ${ranking1.join(' ')}\n');

  // Test case 2
  print('Test Case 2:');
  List<int> leaderboard2 = [300, 200, 200, 100];
  List<int> skorGits2 = [50, 100, 200, 350];
  List<int> ranking2 = denseRanking(leaderboard2, skorGits2);
  print('Leaderboard: $leaderboard2');
  print('Skor GITS: $skorGits2');
  print('Ranking: ${ranking2.join(' ')}\n');

  // Test case 3
  print('Test Case 3:');
  List<int> leaderboard3 = [90, 90, 80, 75, 60];
  List<int> skorGits3 = [60, 76, 90];
  List<int> ranking3 = denseRanking(leaderboard3, skorGits3);
  print('Leaderboard: $leaderboard3');
  print('Skor GITS: $skorGits3');
  print('Ranking: ${ranking3.join(' ')}\n');
}
