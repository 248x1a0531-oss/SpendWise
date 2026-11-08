import 'package:flutter/material.dart';
import '../models/expense.dart';

// Expense Card Widget
class ExpenseCard extends StatelessWidget {
  final Expense expense;
  final VoidCallback onDelete;

  const ExpenseCard({super.key, required this.expense, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.teal.shade100,
          child: Text(expense.category[0]),
        ),
        title: Text(expense.title),
        subtitle: Text(expense.category),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('₹${expense.amount.toStringAsFixed(0)}',
                style: const TextStyle(fontWeight: FontWeight.bold)),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red, size: 20),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}
