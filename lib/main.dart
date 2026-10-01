import 'package:flutter/material.dart';
import 'home_page.dart';

// ==========================================
// TITIK MASUK UTAMA APLIKASI (Entry Point)
// ==========================================
// Fungsi main() adalah fungsi pertama yang dieksekusi saat aplikasi dijalankan.
void main() {
  runApp(const RestoOrderApp());
}

// Widget root (akar) aplikasi yang bertipe StatelessWidget
// Digunakan untuk konfigurasi global seperti Tema, Judul Aplikasi, dan Rute Awal.
class RestoOrderApp extends StatelessWidget {
  const RestoOrderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Judul aplikasi (biasanya muncul di switcher aplikasi Android/iOS)
      title: 'Aplikasi Pemesanan Resto',

      // Menyembunyikan banner "DEBUG" di pojok kanan atas layar
      debugShowCheckedModeBanner: false,

      // Konfigurasi tema global aplikasi (Warna, Font, AppBar, dll.)
      theme: ThemeData(
        // Menentukan warna utama aplikasi menggunakan seedColor (di sini oranye)
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        useMaterial3: true, // Mengaktifkan desain Material 3

        // Konfigurasi seragam untuk seluruh AppBar di dalam aplikasi
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.orange,
          foregroundColor: Colors.white, // Warna teks dan ikon pada AppBar
          centerTitle: true,             // Membuat judul AppBar selalu berada di tengah
        ),
      ),

      // Halaman pertama yang ditampilkan saat aplikasi dibuka
      home: const HomePage(),
    );
  }
}
