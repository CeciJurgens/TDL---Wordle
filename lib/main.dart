import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordle/constants/colors.dart';
import 'pages/menu_page.dart';
import 'controller.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => Controller())],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Controller>(
      builder: (context, controller, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Wordle - El juego de las palabras",
          theme: ThemeData(
            primaryColorLight: lightThemeLightShade,
            primaryColorDark: lightThemeDarkShade,
            //primarySwatch: Colors.blue,
            brightness: Brightness.light,
            appBarTheme: const AppBarTheme(
              titleTextStyle: TextStyle(
                color: Colors.black,
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
            textTheme: const TextTheme().copyWith(
              bodyMedium: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          darkTheme: ThemeData(
            primaryColorLight: darkThemeLightShade,
            primaryColorDark: darkThemeDarkShade,
            //primarySwatch: Colors.blue,
            brightness: Brightness.dark,
            appBarTheme: const AppBarTheme(
              titleTextStyle: TextStyle(
                color: Colors.white,
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
            textTheme: const TextTheme().copyWith(
              bodyMedium: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          themeMode: controller.isDarkMode ? ThemeMode.dark : ThemeMode.light,
          home: MenuPage(),
        );
      },
    );
  }
}