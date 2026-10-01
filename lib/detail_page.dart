import 'package:flutter/material.dart';
import 'food_item.dart';

// ==========================================
// HALAMAN DETAIL (DetailPage)
// ==========================================
// Halaman ini menerima objek data (FoodItem) dari halaman sebelumnya.
// Pengguna dapat melihat detail lengkap dan mengubah jumlah porsi yang dipesan.
class DetailPage extends StatefulWidget {
  // Properti untuk menampung data yang dikirim dari HomePage
  final FoodItem foodItem;

  const DetailPage({super.key, required this.foodItem});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  // State untuk menyimpan jumlah porsi yang sedang diedit
  late int _quantity;

  // Controller untuk mengontrol isi teks pada widget TextField
  late TextEditingController _controller;

  // ==========================================
  // LIFECYCLE: initState()
  // ==========================================
  // Dipanggil tepat satu kali saat halaman pertama kali dibuat.
  // Sangat cocok untuk menginisialisasi nilai awal state dan controller.
  @override
  void initState() {
    super.initState();
    // Mengambil nilai quantity awal dari objek yang dikirim melalui widget.foodItem
    _quantity = widget.foodItem.quantity;

    // Menyetel teks awal pada TextField dengan angka quantity saat ini
    _controller = TextEditingController(text: _quantity.toString());
  }

  // ==========================================
  // LIFECYCLE: dispose()
  // ==========================================
  // Dipanggil saat halaman ditutup/dihancurkan dari memori.
  // WAJIB me-release controller agar tidak terjadi kebocoran memori (memory leak).
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Menghitung total harga secara real-time (jumlah porsi * harga satuan)
    final total = _quantity * widget.foodItem.price;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.foodItem.name), // Judul AppBar sesuai nama makanan
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),
      // SingleChildScrollView mencegah error 'RenderFlex overflowed' saat keyboard muncul
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar makanan berukuran besar di bagian atas
            Image.network(
              widget.foodItem.imageUrl,
              height: 220,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) => Container(
                height: 220,
                color: Colors.orange.shade100,
                child: const Center(
                  child: Icon(Icons.fastfood, size: 60, color: Colors.orange),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Nama makanan
                  Text(
                    widget.foodItem.name,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),

                  // Harga per porsi
                  Text(
                    '${formatRupiah(widget.foodItem.price)} / porsi',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.orange,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Deskripsi lengkap
                  Text(
                    widget.foodItem.description,
                    style: const TextStyle(color: Colors.grey, height: 1.4),
                  ),
                  const SizedBox(height: 20),

                  // ==========================================
                  // INPUT TEXT FIELD (JUMLAH PORSI)
                  // ==========================================
                  TextField(
                    controller: _controller,
                    // Menampilkan keyboard angka di perangkat mobile
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.menu_book, color: Colors.orange),
                      border: OutlineInputBorder(),
                      labelText: 'Jumlah Porsi',
                    ),
                    // Dipanggil setiap kali pengguna mengetik atau menghapus angka
                    onChanged: (val) {
                      setState(() {
                        // Mengonversi input teks ke integer, jika kosong/tidak valid set ke 0
                        _quantity = int.tryParse(val) ?? 0;
                      });
                    },
                  ),
                  const SizedBox(height: 16),

                  // ==========================================
                  // TAMPILAN TOTAL HARGA
                  // ==========================================
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        formatRupiah(total),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // ==========================================
                  // TOMBOL SIMPAN (KEMBALIKAN DATA KE HOME)
                  // ==========================================
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      icon: const Icon(Icons.shopping_bag),
                      label: const Text(
                        'Simpan Pemesanan',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      // Saat tombol ditekan, tutup halaman dan kirim _quantity kembali ke HomePage
                      onPressed: () {
                        Navigator.pop(context, _quantity);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
