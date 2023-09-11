import 'package:banking_app/app.dart';
import 'package:banking_app/presentation/customer_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final customerProvider = CustomerProvider();
  await customerProvider.createDatabase();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<CustomerProvider>.value(value: customerProvider),
      ],
      child: const MyApp(),
    ),
  );
}
