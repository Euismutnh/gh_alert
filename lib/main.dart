//import 'package:cobaan/screen/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screen/splash_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        //ChangeNotifierProvider(create: (_) => DashboardScreen()),
      ],
      child: const MyApp(),
    ),
  );
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
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.white),
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        appBarTheme: AppBarTheme(
          color: Color(0xFF2D2F39),
          iconTheme: IconThemeData(color: Colors.white),
        ),
      ),
      home: SplashScreen(),
    );
  }
}
