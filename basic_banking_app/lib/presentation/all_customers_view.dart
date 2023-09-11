import 'package:banking_app/presentation/constants.dart';
import 'package:banking_app/presentation/customer_provider.dart';
import 'package:banking_app/presentation/customer_view.dart';
import 'package:banking_app/presentation/functions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllCustomersScreen extends StatelessWidget {
  const AllCustomersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorManager.primary,
        elevation: AppSize.s0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: ColorManager.white,
          ),
        ),
      ),
      body: FutureBuilder<void>(
        future: context.read<CustomerProvider>().getAllData(getCustomers: true),
        builder: (context2, _) {
          return Padding(
            padding: const EdgeInsets.all(AppSize.s20),
            child: ListView.builder(
              itemCount: context2.watch<CustomerProvider>().allCustomers.length,
              itemBuilder: (_, index) => _buildCustomer(index, context2),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCustomer(index, BuildContext context) {
    var customerWatcher = context.watch<CustomerProvider>();
    var customerReader = context.read<CustomerProvider>();
    return Padding(
      padding: const EdgeInsets.only(top: AppSize.s14),
      child: InkWell(
        onTap: () {
          context.read<CustomerProvider>().resetValue();
          context.read<CustomerProvider>().getDropDownList(
                customerReader.allCustomers[index].name,
                context,
              );
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => CustomerView(
                    customer: customerWatcher.allCustomers[index])),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(AppSize.s12),
          decoration: BoxDecoration(
            color: ColorManager.primary,
            borderRadius: BorderRadius.circular(AppSize.s20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Name
              customText(
                fontSize: AppSize.s24,
                context: context,
                text: customerWatcher.allCustomers[index].name,
                color: ColorManager.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
