import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordle/constants/colors.dart';
import 'pages/home_page.dart';
import 'controller.dart';

void main() {
  runApp(MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => Controller())],
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Wordle",
        theme: ThemeData(
          primaryColorLight: lightThemeLightShade,
          primaryColorDark: lightThemeDarkShade,
          appBarTheme: const AppBarTheme(
            titleTextStyle: TextStyle(
              color: Colors.black,
              fontSize: 40,
              fontWeight: FontWeight.bold,
            )
          ),
          //scaffoldBackgroundColor: Colors.white,
          textTheme: const TextTheme().copyWith(
            bodyMedium: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black
            )
          )
        ),
        home: const HomePage());
  }
}
