import 'package:flutter/material.dart';
import '../models/customer.dart';
import '../services/database_service.dart';

class CustomerAddandEdit extends StatefulWidget {
  final int customerId;
  const CustomerAddandEdit({super.key, required this.customerId});

  @override
  State<CustomerAddandEdit> createState() => _CustomerAddandEditState();
}

class _CustomerAddandEditState extends State<CustomerAddandEdit> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  Customer? _currentCustomer;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadCustomer();
  }

  Future<void> _loadCustomer() async {
    if (widget.customerId > 0) {
      final customers = await DatabaseService().cusgetAll();
      _currentCustomer = customers.firstWhere(
        (c) => c.id == widget.customerId,
        orElse: () => throw Exception('Customer not found'),
      );
      _nameController.text = _currentCustomer!.name;
      _emailController.text = _currentCustomer!.email;
      _phoneController.text = _currentCustomer!.phone;
    }
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _saveCustomer() async {
    if (_formKey.currentState!.validate()) {
      final customer = Customer(
        id: widget.customerId > 0 ? widget.customerId : 0, // 0 for insert
        name: _nameController.text,
        email: _emailController.text,
        phone: _phoneController.text,
      );

      try {
        if (widget.customerId > 0) {
          await DatabaseService().cusupdate(customer);
        } else {
          await DatabaseService().cussave(customer);
        }
        if (mounted) {
          Navigator.pop(context, true);
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error saving customer: $e')),
        );
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.customerId > 0;
    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'Edit Customer' : 'Add Customer'),
        backgroundColor: Colors.orange,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: 'Name *',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter customer name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _phoneController,
                      decoration: const InputDecoration(
                        labelText: 'Phone',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 32),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _saveCustomer,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: Text(
                          isEdit ? 'Update Customer' : 'Add Customer',
                          style: const TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

