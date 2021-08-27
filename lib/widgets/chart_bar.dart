import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double amount;
  final double percentage;

  const ChartBar({Key? key, required this.label, required this.amount, required this.percentage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final locale = Localizations.localeOf(context);

    return LayoutBuilder(
      builder: (context, constraint) => Column(
        children: [
          Container(
            height: constraint.maxHeight * 0.12,
            child: FittedBox(
              child: Text(
                '${_formatAmount(locale, amount)}',
                style: TextStyle(fontSize: 10 * mediaQuery.textScaleFactor),
              ),
            ),
          ),
          SizedBox(height: constraint.maxHeight * 0.04),
          Container(
            height: constraint.maxHeight * 0.68,
            width: 16,
            child: Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1),
                    // borderRadius: BorderRadius.circular(20),
                    color: Color.fromRGBO(220, 220, 220, 1),
                  ),
                ),
                FractionallySizedBox(
                  heightFactor: percentage,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      // borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: constraint.maxHeight * 0.04),
          Container(
            height: constraint.maxHeight * 0.12,
            child: FittedBox(
              child: Text(
                '$label',
                style: TextStyle(fontSize: 10 * mediaQuery.textScaleFactor),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatAmount(Locale locale, double amount) {
    final currencyFormatter = NumberFormat.simpleCurrency(
      locale: locale.toString(),
      decimalDigits: 0,
    );
    return currencyFormatter.format(amount);
  }
}
