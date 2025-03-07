import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final void Function(String) onRemove;

  TransactionList(this.transactions, this.onRemove, {super.key});

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(
          builder: (ctx, constraints) {
            return Column(
              children: <Widget>[
                SizedBox(height: constraints.maxHeight * 0.05),
                Container(
                  height: constraints.maxHeight * 0.2,
                  child: Text(
                    'No transactions registered',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                SizedBox(height: constraints.maxHeight * 0.05),
                Container(
                  height: constraints.maxHeight * 0.5,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            );
          },
        )
        : ListView.builder(
          itemCount: transactions.length,
          itemBuilder: (ctx, index) {
            final tr = transactions[index];
            return Card(
              elevation: 5,
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
              child: ListTile(
                leading: CircleAvatar(
                  radius: 30,
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  child: Padding(
                    padding: const EdgeInsets.all(6),
                    child: FittedBox(child: Text('R\$${tr.value}')),
                  ),
                ),
                title: Text(
                  tr.title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                subtitle: Text(DateFormat('d MMM y').format(tr.date)),
                trailing: IconButton(
                  onPressed: () => onRemove(tr.id),
                  color: Theme.of(context).colorScheme.error,
                  icon: Icon(Icons.delete),
                ),
              ),
            );
          },
        );
  }
}
