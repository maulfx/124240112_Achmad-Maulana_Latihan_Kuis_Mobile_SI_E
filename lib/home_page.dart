import 'package:flutter/material.dart';
import 'food_item.dart';
import 'detail_page.dart';
import 'profile_page.dart';

// ==========================================
// HALAMAN UTAMA (HomePage)
// ==========================================
// Menggunakan StatefulWidget karena halaman ini memiliki state yang berubah-ubah:
// 1. Indeks tab aktif pada BottomNavigationBar (_currentIndex)
// 2. Data makanan beserta jumlah pesanan yang bisa diperbarui dari halaman detail
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Variabel untuk menyimpan indeks tab navigasi yang sedang aktif (0: Menu, 1: Profil)
  int _currentIndex = 0;

  // Mengambil daftar data awal dari model FoodItem
  final List<FoodItem> _foodItems = FoodItem.getInitialData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Percabangan tampilan body berdasarkan tab yang dipilih pada BottomNavigationBar:
      // Jika _currentIndex == 0 -> tampilkan daftar menu (_buildMenuList())
      // Jika _currentIndex == 1 -> tampilkan halaman profil (ProfilePage())
      body: _currentIndex == 0 ? _buildMenuList() : const ProfilePage(),

      // ==========================================
      // BOTTOM NAVIGATION BAR
      // ==========================================
      // Komponen navigasi di bagian bawah layar untuk beralih antar tab/halaman
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex, // Menentukan tab mana yang sedang aktif
        selectedItemColor: Colors.orange, // Warna ikon dan label ketika dipilih
        // Ketika salah satu item di-klik, perbarui _currentIndex dengan setState()
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant_menu),
            label: 'Menu',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }

  // ==========================================
  // WIDGET DAFTAR MENU (ListView.builder)
  // ==========================================
  // Method pembantu (helper) untuk membangun halaman daftar makanan
  Widget _buildMenuList() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu Resto'),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),
      // ListView.builder digunakan untuk menampilkan daftar item dalam jumlah banyak secara efisien (lazy loading)
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: _foodItems.length, // Menentukan berapa banyak item yang akan dirender
        itemBuilder: (context, index) {
          // Mengambil objek item makanan pada indeks saat ini
          final item = _foodItems[index];

          return Card(
            elevation: 2, // Efek bayangan kartu
            margin: const EdgeInsets.only(bottom: 12),
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              // ==========================================
              // NAVIGASI KE HALAMAN DETAIL (KIRIM & TERIMA DATA)
              // ==========================================
              // Pola ini sangat umum keluar di kuis / ujian:
              // 1. Mengirim data item ke DetailPage
              // 2. Menunggu hasil kembalian (pop result) menggunakan await
              // 3. Mengupdate state dengan setState() jika ada data baru
              onTap: () async {
                final updated = await Navigator.push<int>(
                  context,
                  MaterialPageRoute(
                    // Mengirim objek 'item' ke constructor DetailPage
                    builder: (_) => DetailPage(foodItem: item),
                  ),
                );

                // Jika pengguna menekan "Simpan" di DetailPage, 'updated' berisi jumlah porsi baru
                if (updated != null) {
                  setState(() => item.quantity = updated); // Refresh tampilan dengan data terbaru
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    // Gambar makanan dengan sudut membulat
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        item.imageUrl,
                        width: 75,
                        height: 75,
                        fit: BoxFit.cover,
                        // Menangani jika gambar gagal dimuat (misal: koneksi offline)
                        errorBuilder: (_, _, _) => Container(
                          width: 75,
                          height: 75,
                          color: Colors.orange.shade50,
                          child: const Icon(Icons.fastfood, color: Colors.orange),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),

                    // Expanded agar teks mengisi sisa ruang secara fleksibel tanpa overflow error
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Nama item makanan
                          Text(
                            item.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(height: 4),

                          // Deskripsi makanan (dibatasi maksimal 2 baris agar rapi)
                          Text(
                            item.description,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          const SizedBox(height: 6),

                          // Baris informasi: jumlah porsi dan harga satuan
                          Row(
                            children: [
                              Text(
                                '${item.quantity} porsi',
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                '${formatRupiah(item.price)}/porsi',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),

                    // Total harga pesanan untuk item ini (quantity * price)
                    Text(
                      formatRupiah(item.totalPrice),
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        // Beri warna oranye jika sudah dipesan (>0), abu-abu jika masih 0
                        color: item.quantity > 0 ? Colors.orange : Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
