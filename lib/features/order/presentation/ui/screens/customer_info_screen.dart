import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomerInfoScreen extends StatelessWidget {
  const CustomerInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Customer Info')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            context.go('/package-details'); // Navigate to Step 2
          },
          child: const Text('Next'),
        ),
      ),
    );
  }
}
