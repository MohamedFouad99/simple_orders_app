import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PackageDetailsScreen extends StatelessWidget {
  const PackageDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Package Details')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            context.go('/payment'); // Navigate to Step 3
          },
          child: const Text('Next'),
        ),
      ),
    );
  }
}
