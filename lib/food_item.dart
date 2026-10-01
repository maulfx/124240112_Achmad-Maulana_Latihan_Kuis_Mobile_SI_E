// ==========================================
// MODEL DATA (Entity/Class Objek Makanan)
// ==========================================
// Class ini digunakan sebagai blueprint / cetak biru data yang akan ditampilkan di aplikasi.
// Jika di soal kuis temanya diganti (misal: Buku, Wisata, Rental Kendaraan),
// cukup ubah nama class dan atribut-atribut di dalamnya sesuai kebutuhan.
class FoodItem {
  // Properti / atribut dari objek
  final String name; // Nama makanan/item
  final String description; // Deskripsi singkat makanan/item
  final String imageUrl; // URL gambar makanan/item dari internet
  final int price; // Harga satuan (menggunakan tipe data int agar mudah dihitung)
  int quantity; // Jumlah porsi/item yang dipesan (bukan final karena nilainya bisa berubah)

  // Constructor: digunakan untuk membuat instance/objek baru dari FoodItem
  FoodItem({
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.price,
    this.quantity = 0, // Default nilai quantity awal adalah 0
  });

  // Getter: Menghitung total harga secara otomatis (quantity * harga satuan)
  int get totalPrice => quantity * price;

  // ==========================================
  // DUMMY DATA / DATA AWAL
  // ==========================================
  // Method static ini menyediakan daftar data awal (mock data) untuk ditampilkan di ListView.
  // Kamu bisa menambah, menghapus, atau mengganti item di dalam List ini.
  static List<FoodItem> getInitialData() {
    return [
      FoodItem(
        name: 'Nasi Goreng',
        description: 'Nasi goreng spesial dengan telur, ayam, dan kerupuk.',
        imageUrl:
            'https://images.unsplash.com/photo-1512058564366-18510be2db19?w=800&q=80&auto=format&fit=crop',
        price: 15000,
      ),
      FoodItem(
        name: 'Mie Goreng',
        description: 'Mie goreng jawa dengan bumbu khas dan sayuran segar.',
        imageUrl:
            'https://images.unsplash.com/photo-1473093295043-cdd812d0e601?w=800&q=80&auto=format&fit=crop',
        price: 12000,
      ),
      FoodItem(
        name: 'Ayam Bakar',
        description: 'Ayam bakar bumbu kecap disajikan dengan sambal dan lalapan.',
        imageUrl:
            'https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=800&q=80&auto=format&fit=crop',
        price: 25000,
      ),
      FoodItem(
        name: 'Es Teh',
        description: 'Teh manis dingin yang menyegarkan.',
        imageUrl:
            'https://images.unsplash.com/photo-1544787219-7f47ccb76574?w=800&q=80&auto=format&fit=crop',
        price: 5000,
      ),
      FoodItem(
        name: 'Es Jeruk',
        description: 'Jeruk peras asli dingin dengan es batu.',
        imageUrl:
            'https://images.unsplash.com/photo-1600271886742-f049cd451bba?w=800&q=80&auto=format&fit=crop',
        price: 6000,
      ),
    ];
  }
}

// ==========================================
// FUNGSI FORMATTER RUPIAH
// ==========================================
// Fungsi helper untuk mengubah angka int menjadi format mata uang Rupiah (contoh: 15000 -> "Rp 15.000").
// Menggunakan Regular Expression (RegExp) untuk menyisipkan titik setiap 3 digit angka.
String formatRupiah(int number) {
  return 'Rp ${number.toString().replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
        (m) => '${m[1]}.',
      )}';
}
