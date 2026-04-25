import 'package:flutter/material.dart';

class BackupPage extends StatelessWidget {
  const BackupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Backup Management"),
        backgroundColor: Colors.orange,
      ),
      body: Center(
        child: Text("Welcome to Backup Page"),
      ),
    );
  }
}

