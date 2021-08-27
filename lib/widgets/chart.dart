import 'package:ac_exp_tracker/model/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;
  const Chart({Key? key, required this.recentTransactions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final total = getGroupedTransactionValues(context)
        .map((v) => v['amount'] as double)
        .fold(0.0, (num sum, double amount) => sum + amount);

    return Card(
      elevation: 8,
      margin: EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: getGroupedTransactionValues(context).map((data) {
            final label = data['day'] as String;
            final amount = data['amount'] as double;
            final percentage = total > 0 ? amount / total : 0.0;
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(label: label, amount: amount, percentage: percentage),
            );
          }).toList(),
        ),
      ),
    );
  }

  List<Map<String, Object>> getGroupedTransactionValues(BuildContext context) {
    final locale = Localizations.localeOf(context).toString();
    final dateFormatter = DateFormat.E(locale);

    return List.generate(7, (index) {
      final weekDayIndex = DateTime.now().subtract(Duration(days: 6 - index));
      final weekDay = dateFormatter.format(weekDayIndex);
      // sum up expenses of the day
      final day = weekDayIndex.day;
      final total = recentTransactions
          .where((t) => t.date.day == day)
          .map((t) => t.amount)
          .fold(0.0, (num acc, double cur) => acc + cur);
      print('$weekDay: $total');
      return {'day': weekDay, 'amount': total};
    });
  }
}
