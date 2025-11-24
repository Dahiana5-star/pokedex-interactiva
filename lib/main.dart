import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'pages/home_page.dart';

// Notificador global para manejar el tema
final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.system);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: themeNotifier,
      builder: (context, ThemeMode mode, _) {
        return MaterialApp(
          title: 'Mi Pokédex',
          debugShowCheckedModeBanner: false,

          themeMode: mode,

          // Tema CLARO
          theme: ThemeData(
            scaffoldBackgroundColor: const Color(0xFFEDE7FF),
            appBarTheme: const AppBarTheme(
              backgroundColor: Color(0xFF6C5CE7),
              foregroundColor: Colors.white,
            ),
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF6C5CE7),
              secondary: Color(0xFFA29BFE),
            ),
            textTheme: GoogleFonts.pressStart2pTextTheme(),
          ),

          // Tema OSCURO
          darkTheme: ThemeData(
            scaffoldBackgroundColor: const Color(0xFF2D2B55),
            appBarTheme: const AppBarTheme(
              backgroundColor: Color(0xFF5A4EBF),
              foregroundColor: Colors.white,
            ),
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFF5A4EBF),
              secondary: Color(0xFF9C88FF),
            ),
            textTheme: GoogleFonts.pressStart2pTextTheme()
                .apply(bodyColor: Colors.white),
          ),

          home: const HomePage(),
        );
      },
    );
  }
}
