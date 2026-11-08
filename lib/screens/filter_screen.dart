// Filter Screen
import 'package:flutter/material.dart';

class FilterScreen extends StatelessWidget {
  const FilterScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Filter Expenses')),
      body: const Center(child: Text('Filter by Category')),
    );
  }
}
