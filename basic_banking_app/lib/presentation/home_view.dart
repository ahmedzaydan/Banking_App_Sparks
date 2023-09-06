import 'package:basic_banking_app/presentation/all_customers_view.dart';
import 'package:basic_banking_app/presentation/functions.dart';
import 'package:basic_banking_app/presentation/constants.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(AppSize.s20),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: ColorManager.primary,
                borderRadius: BorderRadius.circular(AppSize.s24),
              ),
              padding: const EdgeInsets.all(AppSize.s12),
              child: customText(
                context: context,
                text: AppStrings.introText,
                color: ColorManager.white,
                fontSize: AppSize.s30,
              ),
            ),

            const SizedBox(height: AppSize.s18),

            // Developer name
            Container(
              decoration: BoxDecoration(
                color: ColorManager.primary,
                borderRadius: BorderRadius.circular(AppSize.s24),
              ),
              padding: const EdgeInsets.all(AppSize.s12),
              child: customText(
                context: context,
                text: AppStrings.myName,
                color: ColorManager.white,
                fontSize: AppSize.s30,
              ),
            ),

            const SizedBox(height: AppSize.s18),

            Image.asset(
              'assets/bank_image_1.jpg',
              height: AppSize.s300,
              width: AppSize.s300,
            ),

            // View all customers
            customElevatedButton(
              fontSize: AppSize.s30,
              context: context,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AllCustomersScreen()),
                );
              },
              text: AppStrings.viewAllCustomers,
            ),
          ],
        ),
      );
    });
  }
}
