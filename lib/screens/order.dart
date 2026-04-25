import 'package:flutter/material.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order History"),
        backgroundColor: Colors.orange,
      ),
      body: Center(
        child: Text("Welcome to Order Page"),
      ),
    );
  }
}

