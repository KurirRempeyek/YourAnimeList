import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomerService extends StatefulWidget {
  const CustomerService({super.key});

  @override
  State<CustomerService> createState() => _CustomerServiceState();
}

class _CustomerServiceState extends State<CustomerService> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Customer Service',
          style: GoogleFonts.poppins(fontSize: 25),
        ),
        backgroundColor: const Color.fromARGB(255, 103, 80, 164),
        centerTitle: true,
      ),
      body: Center(
        child: Text('Customer Service'),
      ),
    );
  }
}
