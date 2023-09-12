import 'package:banking_app/models/customer_model.dart';
import 'package:banking_app/models/transaction_model.dart';
import 'package:banking_app/presentation/constants.dart';
import 'package:banking_app/presentation/functions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class CustomerProvider with ChangeNotifier {
  late Database _database;
  String path = 'sparks.db';
  Database get database => _database;

  List<Customer> _customers = [];
  List<Customer> get allCustomers => _customers;

  List<TransactionItem> _transactions = [];
  List<TransactionItem> get transactions => _transactions;

  // Drop down menu
  String _selectedCustomer = AppStrings.initValue;
  String get selectedCustomer => _selectedCustomer;

  List<DropdownMenuItem<String>> _items = [];
  List<DropdownMenuItem<String>> get items => _items;

  void getDropDownList(String source, BuildContext context) {
    _items = [];
    // Add empty item
    _items.add(buildDropDownItem(
      AppStrings.initValue,
      context,
      color: ColorManager.black,
    ));
    for (var customer in _customers) {
      if (customer.name != source) {
        _items.add(buildDropDownItem(customer.name, context));
      }
    }
  }

  void updateValue(String name) {
    _selectedCustomer = name;
    notifyListeners();
  }

  Future<void> createDatabase() async {
    try {
      await openDatabase(
        path,
        version: 1,
        onCreate: (db, version) async {
          _database = db;

          // Create customers table
          String customersQuery = 'CREATE TABLE customers ('
              'name TEXT PRIMARY KEY,'
              'email TEXT,'
              'currentBalance REAL'
              ')';
          await db.execute(customersQuery);

          // Create transactions table
          String transactionsQuery = 'CREATE TABLE transactions ('
              'source TEXT,'
              'dest TEXT,'
              'amount REAL'
              ')';
          await db.execute(transactionsQuery);

          // Load customers initial data
          for (var customer in initCustomersList) {
            String sql =
                'INSERT INTO customers(name, email, currentBalance) VALUES('
                '"${customer.name}",'
                '"${customer.email}",'
                '${customer.currentBalance}'
                ')';
            insertRow(sql);
          }

          await getAllData(getCustomers: true);
        },
        onOpen: (db) async {
          _database = db;

          // Get customers data
          await getAllData(getCustomers: true);

          // Get transactions data
          await getAllData(getCustomers: false);
        },
      );
    } catch (error) {
      if (kDebugMode) print('Error in opening $path: $error');
    }
  }

  Future<void> insertRow(String sql) async {
    try {
      await _database.execute(sql);
    } catch (error) {
      if (kDebugMode) {
        print('Error while inserting row with query: $sql \nerror is: $error');
      }
    }
  }

  Future<void> getAllData({required bool getCustomers}) async {
    try {
      String sql = getCustomers
          ? 'SELECT * FROM customers'
          : 'SELECT * FROM transactions';

      // Clear before adding new data
      getCustomers ? _customers = [] : _transactions = [];

      var value = await _database.rawQuery(sql);
      for (var item in value) {
        if (getCustomers) {
          _customers.add(
            Customer(
              name: item['name'] as String,
              email: item['email'] as String,
              currentBalance: item['currentBalance'] as double,
            ),
          );
        } else {
          // transactions
          _transactions.add(
            TransactionItem(
              from: item['source'] as String,
              to: item['dest'] as String,
              amount: item['amount'] as double,
            ),
          );
        }
      }

      notifyListeners();
    } catch (error) {
      if (kDebugMode) {
        print(
            'Error while getting all ${getCustomers ? 'customers' : 'transactions'} data: $error');
      }
    }
  }

  Future<void> updateCustomerRow({
    required String name,
    required double newBalance,
  }) async {
    try {
      String sql =
          'UPDATE customers SET currentBalance = "$newBalance" WHERE name = "$name"';

      await _database.rawUpdate(sql);

      await getAllData(getCustomers: true);

      notifyListeners();
    } catch (error) {
      if (kDebugMode) print('Error while updating row $name: $error');
    }
  }

  void makeTransaction({
    required String source,
    required String dest,
    required double amount,
  }) async {
    // Decrease amount from source
    int sourceIdx = getCustomerByIndex(source);
    await updateCustomerRow(
      name: source,
      newBalance: _customers[sourceIdx].currentBalance - amount,
    );

    // Increase amount in destination
    int destIdx = getCustomerByIndex(dest);
    await updateCustomerRow(
      name: dest,
      newBalance: _customers[destIdx].currentBalance + amount,
    );

    String sql = 'INSERT INTO transactions(source, dest, amount) VALUES('
        '"$source",'
        '"$dest",'
        '$amount'
        ')';

    await insertRow(sql);

    await getAllData(getCustomers: false);

    resetValue();

    notifyListeners();
  }

  bool validateAmount({
    required String source,
    required double amount,
  }) {
    int idx = getCustomerByIndex(source);
    return (idx != -1 && _customers[idx].currentBalance >= amount);
  }

  int getCustomerByIndex(String name) {
    for (var i = 0; i < _customers.length; i++) {
      if (_customers[i].name == name) {
        return i;
      }
    }
    return -1;
  }

  void resetValue() {
    _selectedCustomer = AppStrings.initValue;
    notifyListeners();
  }
}
