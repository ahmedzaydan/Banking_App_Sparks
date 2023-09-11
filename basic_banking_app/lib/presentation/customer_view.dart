import 'package:banking_app/models/customer_model.dart';
import 'package:banking_app/presentation/constants.dart';
import 'package:banking_app/presentation/customer_provider.dart';
import 'package:banking_app/presentation/functions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomerView extends StatelessWidget {
  final Customer customer;
  CustomerView({Key? key, required this.customer}) : super(key: key);
  final TextEditingController _amountController = TextEditingController();
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppSize.s8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Name
              Container(
                padding: const EdgeInsets.symmetric(vertical: AppSize.s6),
                margin: const EdgeInsets.only(top: AppSize.s20),
                width: AppSize.infinity,
                decoration: BoxDecoration(
                  color: ColorManager.primary,
                  borderRadius: BorderRadius.circular(AppSize.s18),
                ),
                child: Center(
                  child: customText(
                    fontSize: AppSize.s24,
                    context: context,
                    text: "Name: ${customer.name}",
                    color: ColorManager.white,
                  ),
                ),
              ),

              const SizedBox(height: AppSize.s12),

              // Email
              Container(
                padding: const EdgeInsets.symmetric(vertical: AppSize.s6),
                width: AppSize.infinity,
                margin: const EdgeInsets.only(top: AppSize.s8),
                decoration: BoxDecoration(
                  color: ColorManager.primary,
                  borderRadius: BorderRadius.circular(AppSize.s18),
                ),
                child: Center(
                  child: customText(
                    fontSize: AppSize.s24,
                    context: context,
                    text: "Email : ${customer.email}",
                    color: ColorManager.white,
                  ),
                ),
              ),

              const SizedBox(height: AppSize.s12),

              // Current balance
              Container(
                width: AppSize.infinity,
                padding: const EdgeInsets.symmetric(vertical: AppSize.s6),
                margin: const EdgeInsets.only(top: AppSize.s8),
                decoration: BoxDecoration(
                  color: ColorManager.primary,
                  borderRadius: BorderRadius.circular(AppSize.s18),
                ),
                child: Center(
                  child: customText(
                    fontSize: AppSize.s24,
                    context: context,
                    text: "Current Balance: ${customer.currentBalance}",
                    color: ColorManager.white,
                  ),
                ),
              ),

              const SizedBox(height: AppSize.s12),

              // Drop down menu + amount
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Drop down menu
                  Container(
                    decoration: BoxDecoration(
                      color: ColorManager.white,
                      borderRadius: BorderRadius.circular(AppSize.s24),
                      border: Border.all(
                        color: ColorManager.primary,
                        width: AppSize.s1_5,
                      ),
                    ),
                    child: DropdownButton<String>(
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: ColorManager.primary,
                        size: AppSize.s40,
                      ),
                      hint: const Text(
                        "Hint",
                        style: TextStyle(color: Colors.red),
                      ),
                      underline: Container(),
                      // isExpanded: true,
                      borderRadius: BorderRadius.circular(AppSize.s20),
                      value: context.watch<CustomerProvider>().selectedCustomer,
                      items: context.watch<CustomerProvider>().items,
                      onChanged: (value) {
                        context.read<CustomerProvider>().updateValue(value!);
                      },
                    ),
                  ),

                  const SizedBox(width: AppSize.s8),

                  // Amount
                  Expanded(
                    child: Container(
                      height: AppSize.s60,
                      margin: const EdgeInsets.only(top: AppSize.s8),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: _amountController,
                        decoration: InputDecoration(
                          errorStyle: const TextStyle(color: Colors.red),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(AppSize.s40),
                          ),
                          labelText: AppStrings.amount,
                          contentPadding: const EdgeInsets.only(
                            left: AppSize.s8,
                            right: AppSize.s4,
                          ),
                          // errorText: AppStrings.error,
                          // errorStyle: TextStyle(color: ColorManager.red),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: AppSize.s12),

              // Confirm button
              customElevatedButton(
                context: context,
                onPressed: () {
                  var reader = context.read<CustomerProvider>();
                  if (kDebugMode) print("Confirm button pressed");
                  if (_amountController.text.isNotEmpty) {
                    bool valid = reader.validateAmount(
                      source: customer.name,
                      amount: double.parse(_amountController.text),
                    );
                    if (valid) {
                      // Make transaction
                      reader.makeTransaction(
                        source: customer.name,
                        dest: context
                            .read<CustomerProvider>()
                            .selectedCustomer
                            .toString(),
                        amount: double.parse(_amountController.text),
                      );

                      // Show success toast
                      showToast(
                        message: AppStrings.success,
                        background: ColorManager.white,
                        textColor: ColorManager.primary,
                      );

                      // Pop the screen
                      Navigator.pop(context);
                    } else {
                      // Show error toast
                      showToast(
                        message: AppStrings.invalidAmount,
                        background: ColorManager.red,
                      );
                    }
                  } else {
                    // Show error toast
                    showToast(
                      message: AppStrings.invalidAmount,
                      background: ColorManager.red,
                    );
                  }
                },
                text: AppStrings.confirm,
                fontSize: AppSize.s24,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
