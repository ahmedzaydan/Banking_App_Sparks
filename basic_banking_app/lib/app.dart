import 'package:banking_app/presentation/constants.dart';
import 'package:banking_app/presentation/layout_screen.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppStrings.homeScreen,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: ColorManager.primary),
        useMaterial3: true,
      ),
      home: const LayoutScreen(),
      // home:
    );
  }
}
