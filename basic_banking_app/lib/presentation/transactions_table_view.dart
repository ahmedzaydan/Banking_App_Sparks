import 'package:basic_banking_app/presentation/constants.dart';
import 'package:basic_banking_app/presentation/customer_provider.dart';
import 'package:basic_banking_app/presentation/functions.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TransactionsTable extends StatelessWidget {
  const TransactionsTable({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: context.read<CustomerProvider>().getAllData(getCustomers: false),
      builder: (context2, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        var list = context2.watch<CustomerProvider>().transactions;
        if (kDebugMode) print('Transactions: $list');
        return ConditionalBuilder(
          condition: list.isNotEmpty,
          builder: (_) {
            return ListView.builder(
              itemCount: list.length,
              itemBuilder: (_, index) => _buildTransactionItem(index, context2),
            );
          },
          fallback: (_) {
            return Center(
              child: customText(
                context: context2,
                text: AppStrings.emptyData,
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildTransactionItem(index, BuildContext context) {
    final list = context.read<CustomerProvider>().transactions;
    return Padding(
      padding: const EdgeInsets.only(
        left: AppSize.s20,
        right: AppSize.s20,
        top: AppSize.s12,
      ),
      child: Container(
        padding: const EdgeInsets.all(AppSize.s12),
        decoration: BoxDecoration(
          color: ColorManager.primary,
          borderRadius: BorderRadius.circular(AppSize.s20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // From
            customText(
              context: context,
              text: "From: ${list[index].from}",
              color: ColorManager.white,
            ),

            // To
            customText(
              context: context,
              text: "To: ${list[index].to}",
              color: ColorManager.white,
            ),

            // Amount
            customText(
              context: context,
              text: "Amount: ${list[index].amount.toString()}",
              color: ColorManager.white,
            ),
          ],
        ),
      ),
    );
  }
}
