import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../model/transaction.dart';
import 'package:flutter/material.dart';

class TransactionTile extends StatelessWidget {
  final Transaction transaction;
  final Function onDelete;

  const TransactionTile({Key? key, required this.transaction, required this.onDelete}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final theme = Theme.of(context);
    final locale = Localizations.localeOf(context).toString();
    final l10n = AppLocalizations.of(context);

    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(horizontal: 0, vertical: 8),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Container(
              height: 20,
              child: FittedBox(
                child: Text(
                  '${this._formatAmount(locale: locale, amount: transaction.amount)}',
                  style: TextStyle(
                    fontSize: 16 * mediaQuery.textScaleFactor,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
        title: Text(
          '${transaction.title}',
          style: theme.textTheme.headline6,
        ),
        subtitle: Text(
          '${this._formatDate(locale: locale, date: transaction.date)}',
          style: TextStyle(
            fontSize: 9 * mediaQuery.textScaleFactor,
          ),
        ),
        trailing: MediaQuery.of(context).size.width > 480
            ? TextButton.icon(
                icon: Icon(Icons.delete),
                label: Text(l10n?.deleteButton ?? 'Delete'),
                onPressed: () => onDelete(transaction.id),
                style: TextButton.styleFrom(
                  primary: theme.errorColor,
                ))
            : IconButton(
                icon: Icon(Icons.delete),
                color: theme.errorColor,
                onPressed: () => onDelete(transaction.id),
              ),
      ),
    );
  }

  String _formatAmount({required String locale, required double amount}) {
    final currencyFormatter = NumberFormat.simpleCurrency(locale: locale);
    return currencyFormatter.format(amount);
  }

  String _formatDate({required String locale, required DateTime date}) {
    final dateFormatter = DateFormat.yMMMEd(locale);
    return dateFormatter.format(date);
  }
}
