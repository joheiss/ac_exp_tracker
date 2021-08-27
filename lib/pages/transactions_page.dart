import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../widgets/transaction_list.dart';
import '../widgets/chart.dart';
import '../widgets/transaction_input.dart';

import '../services/data_service.dart';

class TransactionPage extends StatefulWidget {
  TransactionPage({Key? key}) : super(key: key);

  @override
  _TransactionPageState createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  final DataService data = DataService();
  bool _switch = false;

  @override
  Widget build(BuildContext context) {
    final appBar = _buildAppBar(context);

    return Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: appBar as ObstructingPreferredSizeWidget,
            child: _buildList(context, appBar.preferredSize.height),
          )
        : Scaffold(
            appBar: appBar,
            body: Center(
              child: _buildList(context, appBar.preferredSize.height),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    onPressed: () => _openTransactionInput(context),
                    tooltip: AppLocalizations.of(context)?.addButtonTooltip,
                    child: Icon(Icons.add),
                  ),
          );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text(_getAppTitle(context)),
            trailing: CupertinoButton(
              child: Icon(CupertinoIcons.add),
              onPressed: () => _openTransactionInput(context),
              padding: EdgeInsets.zero,
            ),
          )
        : AppBar(
            title: Text(_getAppTitle(context)),
            actions: [
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () => _openTransactionInput(context),
              ),
            ],
          ) as PreferredSizeWidget;
  }

  Widget _buildList(BuildContext context, double appBarHeight) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final showChart = !isLandscape || _switch;
    final showList = !isLandscape || !_switch;
    final chartSize = isLandscape ? 0.8 : 0.2;

    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (isLandscape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppLocalizations.of(context)?.switchLabel ?? 'Show chart',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Switch.adaptive(
                    activeColor: Theme.of(context).accentColor,
                    value: _switch,
                    onChanged: (val) => setState(() => _switch = val),
                  ),
                ],
              ),
            if (showChart)
              Container(
                height: (mediaQuery.size.height - appBarHeight - mediaQuery.padding.top) * chartSize,
                child: Chart(
                  recentTransactions: data.recentTransactions,
                ),
              ),
            if (showList)
              Container(
                height: (mediaQuery.size.height - appBarHeight - mediaQuery.padding.top) * 0.8,
                margin: EdgeInsets.symmetric(horizontal: 16),
                child: TransactionList(
                  data: data,
                  onDelete: _deleteTransaction,
                ),
              ),
          ],
        ),
      ),
    );
  }

  String _getAppTitle(BuildContext context) {
    return AppLocalizations.of(context)?.appTitle ?? 'Expense Tracker';
  }

  void _addTransaction(String title, double amount, DateTime? date) {
    setState(() {
      data.addTransaction(title, amount, date);
    });
    Navigator.of(context).pop();
  }

  void _deleteTransaction(String id) {
    setState(() {
      data.deleteTransaction(id);
    });
  }

  void _openTransactionInput(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return TransactionInput(onAdd: _addTransaction);
      },
    );
  }
}
