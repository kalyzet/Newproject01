#include <stdio.h>
#include <string.h>

// Struktur data untuk ruang
typedef struct {
    int id;
    char nama[50];
    int tersedia; // 1 untuk tersedia, 0 untuk sudah dipesan
    char peminjam[20]; // Nama peminjam
    int waktuMulai;    // Waktu mulai peminjaman dalam format HHMM (contoh: 800 = 08:00)
    int durasi;        // Durasi peminjaman dalam menit
} Ruang;

// Fungsi untuk menampilkan daftar ruang
void tampilkanRuang(Ruang ruang[], int jumlah) {
    printf("\nDaftar Ruang:\n");
    printf("===========================================================\n");
    for (int i = 0; i < jumlah; i++) {
        printf("ID: %d | Nama: %s | Status: %s | Peminjam: %s | Waktu: %02d:%02d - %02d:%02d\n",
               ruang[i].id,
               ruang[i].nama,
               ruang[i].tersedia ? "Tersedia" : "Dipesan",
               ruang[i].tersedia ? "-" : ruang[i].peminjam,
               ruang[i].tersedia ? 0 : ruang[i].waktuMulai / 100,
               ruang[i].tersedia ? 0 : ruang[i].waktuMulai % 100,
               ruang[i].tersedia ? 0 : (ruang[i].waktuMulai + ruang[i].durasi) / 100,
               ruang[i].tersedia ? 0 : (ruang[i].waktuMulai + ruang[i].durasi) % 100);
    }
    printf("===========================================================\n");
}

// Fungsi untuk memesan ruang
void pesanRuang(Ruang ruang[], int jumlah) {
    int id, waktuMulai, durasi;
    char namaPeminjam[20];

    printf("\nMasukkan ID ruang yang ingin dipesan: ");
    scanf("%d", &id);

    for (int i = 0; i < jumlah; i++) {
        if (ruang[i].id == id) {
            if (ruang[i].tersedia) {
                printf("Masukkan nama peminjam (maks 20 karakter): ");
                scanf(" %[^\n]s", namaPeminjam);

                printf("Masukkan waktu mulai peminjaman (HHMM, antara 0800 hingga 2100): ");
                scanf("%d", &waktuMulai);
                if (waktuMulai < 800 || waktuMulai >= 2100) {
                    printf("Waktu mulai harus antara 08:00 hingga 21:00.\n");
                    return;
                }

                printf("Masukkan durasi peminjaman (maksimal 240 menit): ");
                scanf("%d", &durasi);
                if (durasi > 240 || durasi <= 0) {
                    printf("Durasi harus antara 1 hingga 240 menit.\n");
                    return;
                }

                // Hitung waktu selesai dalam format menit
                int waktuSelesai = waktuMulai / 100 * 60 + waktuMulai % 100 + durasi; 
                int jamSelesai = waktuSelesai / 60; // Konversi kembali ke jam
                int menitSelesai = waktuSelesai % 60;

                // Validasi waktu selesai
                if (jamSelesai > 21 || (jamSelesai == 21 && menitSelesai > 0)) {
                    printf("Waktu selesai harus sebelum 21:30 (termasuk jeda pembersihan 30 menit).\n");
                    return;
                }

                ruang[i].tersedia = 0;
                strncpy(ruang[i].peminjam, namaPeminjam, 20);
                ruang[i].waktuMulai = waktuMulai;
                ruang[i].durasi = durasi;

                printf("Ruang '%s' berhasil dipesan oleh '%s' dari %02d:%02d hingga %02d:%02d.\n",
                       ruang[i].nama, ruang[i].peminjam,
                       waktuMulai / 100, waktuMulai % 100,
                       jamSelesai, menitSelesai);
                return;
            } else {
                printf("Ruang sudah dipesan oleh '%s'.\n", ruang[i].peminjam);
                return;
            }
        }
    }
    printf("ID ruang tidak ditemukan.\n");
}

// Fungsi untuk membatalkan pemesanan ruang
void batalPesanRuang(Ruang ruang[], int jumlah) {
    int id;
    printf("\nMasukkan ID ruang yang ingin dibatalkan: ");
    scanf("%d", &id);

    for (int i = 0; i < jumlah; i++) {
        if (ruang[i].id == id) {
            if (!ruang[i].tersedia) {
                ruang[i].tersedia = 1;
                strcpy(ruang[i].peminjam, "-");
                ruang[i].waktuMulai = 0;
                ruang[i].durasi = 0;
                printf("Pemesanan ruang '%s' berhasil dibatalkan.\n", ruang[i].nama);
                return;
            } else {
                printf("Ruang belum dipesan.\n");
                return;
            }
        }
    }
    printf("ID ruang tidak ditemukan.\n");
}

int main() {
    Ruang ruang[5] = {
        {1, "Ruang Meeting A", 1, "-", 0, 0},
        {2, "Ruang Meeting B", 1, "-", 0, 0},
        {3, "Ruang Seminar", 1, "-", 0, 0},
        {4, "Ruang Kelas 101", 1, "-", 0, 0},
        {5, "Ruang Lab Komputer", 1, "-", 0, 0}
    };

    int pilihan;

    do {
        printf("\n=== Aplikasi Peminjaman Ruang ===\n");
        printf("1. Tampilkan Ruang\n");
        printf("2. Pesan Ruang\n");
        printf("3. Batalkan Pemesanan\n");
        printf("4. Keluar\n");
        printf("Pilih menu: ");
        scanf("%d", &pilihan);

        switch (pilihan) {
            case 1:
                tampilkanRuang(ruang, 5);
                break;
            case 2:
                pesanRuang(ruang, 5);
                break;
            case 3:
                batalPesanRuang(ruang, 5);
                break;
            case 4:
                printf("Terima kasih telah menggunakan aplikasi peminjaman ruang!\n");
                break;
            default:
                printf("Pilihan tidak valid. Silakan coba lagi.\n");
        }
    } while (pilihan != 4);

    return 0;
}
