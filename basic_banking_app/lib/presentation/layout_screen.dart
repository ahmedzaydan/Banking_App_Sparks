import 'package:banking_app/presentation/constants.dart';
import 'package:banking_app/presentation/functions.dart';
import 'package:banking_app/presentation/home_view.dart';
import 'package:banking_app/presentation/transactions_table_view.dart';
import 'package:flutter/material.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({super.key});

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  List<Widget> screens = [
    const HomeScreen(),
    const TransactionsTable(),
  ];

  List<String> titles = [
    AppStrings.homeScreen,
    AppStrings.history,
  ];
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: customText(
          context: context,
          text: titles[currentIndex],
          color: ColorManager.white,
        ),
        centerTitle: true,
        backgroundColor: ColorManager.primary,
      ),
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: ColorManager.primary,
          selectedItemColor: ColorManager.white,
          selectedFontSize: AppSize.s16,
          unselectedItemColor: ColorManager.white.withOpacity(0.5),
          currentIndex: currentIndex,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: AppStrings.homeScreen,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history),
              label: AppStrings.history,
            ),
          ],
          onTap: (index) {
            setState(() => currentIndex = index);
          }),
    );
  }
}
