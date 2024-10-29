import 'package:flutter/material.dart';
import 'screen/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Peta Penyakit',
      theme: ThemeData(
        primaryColor: Color(0xFF2D2F39),
        scaffoldBackgroundColor: Color(0xFF2D2F39),
        accentColor: Colors.white,
        textTheme: TextTheme(
          bodyText1: TextStyle(color: Colors.white),
          bodyText2: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        appBarTheme: AppBarTheme(
          color: Color(0xFF2D2F39),
          iconTheme: IconThemeData(color: Colors.white),
          textTheme: TextTheme(
            headline6: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: Color(0xFF009966), // Tombol biru BPJS
          ),
        ),
      ),
      home: SplashScreen(),
    );
  }
}
