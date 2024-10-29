import 'package:flutter/material.dart';
import 'package:gh_cas/screen/notifications_screen.dart';
import 'package:gh_cas/widgets/map_widget.dart';

import '../widgets/chart_batang.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Background putih untuk keseluruhan body
      appBar: PreferredSize(
        preferredSize:
            const Size.fromHeight(40), // Ukuran appBar yang lebih kecil
        child: AppBar(
          backgroundColor: const Color(0xFF3167F2),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          flexibleSpace: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 20), // Padding kiri-kanan 20px
            child: Row(
              children: [
                // Logo besar di sebelah kiri
                Image.network(
                  'https://res.cloudinary.com/dgcpujd5s/image/upload/v1730192934/Logo_GHCAS_icon_cohqyv.png',
                  height: 65, // Menyesuaikan tinggi logo
                ),
                const Spacer(), // Mengisi ruang agar elemen di kanan bergerak ke kanan
                // Ikon Notifikasi
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20), // Mengatur padding kanan
                  child: IconButton(
                    icon: const Icon(
                      Icons.notifications,
                      color: Colors.white,
                      size: 25, // Ukuran ikon yang sesuai
                    ),
                    onPressed: () {
                      // Navigasi ke halaman notifikasi
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const NotificationsScreen(),
                        ),
                      );
                    },
                  ),
                ),
                // Profil dengan Nama dan Lokasi di sebelah kanan
                Row(
                  children: [
                    const Icon(
                      Icons.account_circle,
                      color: Colors.white,
                      size: 30,
                    ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'Roye Team',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Lampung',
                          style: TextStyle(
                            color: Color(0xFFA7B0D1),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.white,
              // Menghapus padding berlebih
              child: Column(
                children: const [
                  ChartBatang(),
                  SizedBox(
                    height: 20,
                  ),
                  MapWidget(),
                  SizedBox(
                    height: 20,
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
