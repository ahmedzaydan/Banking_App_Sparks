class Customer {
  String name;
  String email;
  double currentBalance;

  Customer({
    required this.name,
    required this.email,
    required this.currentBalance,
  });
}

List<Customer> initCustomersList = [
  Customer(
    name: 'John Doe',
    email: 'john@gmail.com',
    currentBalance: 1000.0,
  ),
  Customer(
    name: 'Jane Smith',
    email: 'jane@gmail.com',
    currentBalance: 750.0,
  ),
  Customer(
    name: 'Alice Johnson',
    email: 'alice@gmail.com',
    currentBalance: 1200.0,
  ),
  Customer(
    name: 'Bob Brown',
    email: 'bob@gmail.com',
    currentBalance: 850.0,
  ),
  Customer(
    name: 'Eva Williams',
    email: 'eva@gmail.com',
    currentBalance: 950.0,
  ),
  Customer(
    name: 'Michael Lee',
    email: 'michael@gmail.com',
    currentBalance: 1100.0,
  ),
  Customer(
    name: 'Olivia Davis',
    email: 'olivia@gmail.com',
    currentBalance: 800.0,
  ),
  Customer(
    name: 'David Wilson',
    email: 'david@gmail.com',
    currentBalance: 1300.0,
  ),
  Customer(
    name: 'Sophia Martinez',
    email: 'sophia@gmail.com',
    currentBalance: 700.0,
  ),
  Customer(
    name: 'William Anderson',
    email: 'william@gmail.com',
    currentBalance: 1050.0,
  ),
];
