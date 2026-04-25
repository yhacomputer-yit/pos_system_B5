import 'package:flutter/material.dart';

class CustomerPage extends StatelessWidget {
  const CustomerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Customer Management"),
        backgroundColor: Colors.orange,
      ),
      body: Center(
        child: Text("Welcome to Customer Page"),
      ),
    );
  }
}

