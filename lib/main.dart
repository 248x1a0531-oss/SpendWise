import 'package:flutter/material.dart';

void main() => runApp(SpendWiseApp());

class Expense {
  final String title, category;
  final double amount;
  final DateTime date;
  Expense({required this.title, required this.category, required this.amount, required this.date});
}

class SpendWiseApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'SpendWise', theme: ThemeData(primarySwatch: Colors.teal, useMaterial3: true), debugShowCheckedModeBanner: false, home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Expense> expenses = [
    Expense(title: "Lunch", category: "Food", amount: 150, date: DateTime.now()),
    Expense(title: "Bus Ticket", category: "Travel", amount: 50, date: DateTime.now()),
    Expense(title: "Notebook", category: "Study", amount: 120, date: DateTime.now()),
  ];
  String filter = "All";
  List<String> cats = ["All", "Food", "Travel", "Study", "Shopping", "Other"];
  double budget = 5000;

  double get totalSpent => expenses.fold(0, (sum, e) => sum + e.amount);
  double get balance => budget - totalSpent;

  void addExpense() {
    String title = "";
    String amountStr = "";
    String selectedCat = "Food";
    showDialog(context: context, builder: (ctx) => AlertDialog(
      title: Text("Add Expense"),
      content: Column(mainAxisSize: MainAxisSize.min, children: [
        TextField(onChanged: (v) => title = v, decoration: InputDecoration(labelText: "Title - Ex: Lunch")),
        TextField(onChanged: (v) => amountStr = v, keyboardType: TextInputType.number, decoration: InputDecoration(labelText: "Amount")),
        DropdownButton<String>(value: selectedCat, isExpanded: true, items: ["Food", "Travel", "Study", "Shopping", "Other"].map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(), onChanged: (v) => setState(() => selectedCat = v!)),
      ]),
      actions: [
        TextButton(onPressed: () => Navigator.pop(ctx), child: Text("Cancel")),
        ElevatedButton(onPressed: () {
          if (title.isNotEmpty && amountStr.isNotEmpty) {
            setState(() => expenses.insert(0, Expense(title: title, category: selectedCat, amount: double.tryParse(amountStr) ?? 0, date: DateTime.now())));
            Navigator.pop(ctx);
          }
        }, child: Text("Add")),
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    List<Expense> filtered = filter == "All" ? expenses : expenses.where((e) => e.category == filter).toList();
    return Scaffold(
      appBar: AppBar(title: Text("💰 SpendWise"), backgroundColor: Colors.teal, foregroundColor: Colors.white, centerTitle: true),
      body: Column(children: [
        Container(margin: EdgeInsets.all(12), padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.teal, borderRadius: BorderRadius.circular(16)), child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Column(children: [Text("Budget", style: TextStyle(color: Colors.white70)), Text("₹${budget.toStringAsFixed(0)}", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold))]),
          Column(children: [Text("Spent", style: TextStyle(color: Colors.white70)), Text("₹${totalSpent.toStringAsFixed(0)}", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold))]),
          Column(children: [Text("Balance", style: TextStyle(color: Colors.white70)), Text("₹${balance.toStringAsFixed(0)}", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold))]),
        ])),
        Container(height: 40, child: ListView(scrollDirection: Axis.horizontal, children: cats.map((c) => Padding(padding: EdgeInsets.symmetric(horizontal: 4), child: ChoiceChip(label: Text(c), selected: filter == c, onSelected: (_) => setState(() => filter = c), selectedColor: Colors.teal.shade200))).toList())),
        Expanded(child: filtered.isEmpty ? Center(child: Text("No expenses")) : ListView.builder(itemCount: filtered.length, itemBuilder: (ctx, i) {
          var e = filtered[i];
          return Card(margin: EdgeInsets.symmetric(horizontal: 12, vertical: 5), child: ListTile(leading: CircleAvatar(child: Text(e.category[0]), backgroundColor: Colors.teal.shade100), title: Text(e.title, style: TextStyle(fontWeight: FontWeight.bold)), subtitle: Text(e.category), trailing: Row(mainAxisSize: MainAxisSize.min, children: [Text("₹${e.amount}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)), IconButton(icon: Icon(Icons.delete, color: Colors.red, size: 20), onPressed: () => setState(() => expenses.remove(e)))])));
        })),
      ]),
      floatingActionButton: FloatingActionButton(onPressed: addExpense, backgroundColor: Colors.teal, child: Icon(Icons.add, color: Colors.white)),
    );
  }
}
