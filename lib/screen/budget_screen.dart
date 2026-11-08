import 'package:flutter/material.dart';

// Budget Screen - Shows Monthly Budget Progress
class BudgetCard extends StatelessWidget {
  final double totalSpent;
  final double monthlyBudget;
  final VoidCallback onEdit;

  const BudgetCard({
    super.key,
    required this.totalSpent,
    required this.monthlyBudget,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    double remaining = monthlyBudget - totalSpent;
    double progress = totalSpent / monthlyBudget;
    if (progress > 1) progress = 1;

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.teal.shade50,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Monthly Budget',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              GestureDetector(
                onTap: onEdit,
                child: const Text('Edit ✏️',
                    style: TextStyle(color: Colors.teal)),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text('Spent: ₹${totalSpent.toStringAsFixed(0)} / ₹${monthlyBudget.toStringAsFixed(0)}'),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.grey.shade300,
            color: remaining < 0 ? Colors.red : Colors.teal,
          ),
          const SizedBox(height: 8),
          Text(
            remaining >= 0
                ? 'Remaining: ₹${remaining.toStringAsFixed(0)}'
                : 'Over Budget by ₹${(-remaining).toStringAsFixed(0)} !',
            style: TextStyle(
              color: remaining < 0 ? Colors.red : Colors.green,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
