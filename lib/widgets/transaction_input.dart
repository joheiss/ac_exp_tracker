import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../widgets/adaptive_elevated_button.dart';
import '../widgets/adaptive_icon_button.dart';

class TransactionInput extends StatefulWidget {
  final Function onAdd;
  const TransactionInput({Key? key, required this.onAdd}) : super(key: key);

  @override
  _TransactionInputState createState() => _TransactionInputState();
}

class _TransactionInputState extends State<TransactionInput> {
  final TextEditingController _titleInput = TextEditingController();
  final TextEditingController _amountInput = TextEditingController();
  DateTime? _dateInput;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final locale = Localizations.localeOf(context).toString();
    final l10n = AppLocalizations.of(context);

    var dateText = l10n?.dateInputLabel ?? 'Pick a date';
    if (_dateInput != null) {
      dateText = _formatDate(locale: locale, date: _dateInput!);
    }

    return SingleChildScrollView(
      child: Card(
        elevation: 4,
        child: Container(
          margin: EdgeInsets.only(
            top: 16,
            right: 16,
            left: 16,
            bottom: mediaQuery.viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                controller: _titleInput,
                decoration: InputDecoration(labelText: l10n?.titleInputLabel),
              ),
              TextField(
                controller: _amountInput,
                decoration: InputDecoration(
                  labelText: l10n?.amountInputLabel,
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onSubmitted: (_) => this._submit(locale),
              ),
              Container(
                height: 64,
                child: Row(
                  children: [
                    Text(
                      dateText,
                      style: TextStyle(fontSize: 16 * mediaQuery.textScaleFactor, color: Colors.black54),
                    ),
                    AdaptiveIconButton(
                      icon:
                          Platform.isIOS ? const Icon(CupertinoIcons.calendar_today) : const Icon(Icons.calendar_today),
                      onPressed: _showDatePicker,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              AdaptiveElevatedButton(
                child: Text(l10n?.addButtonCaption ?? 'Add Transaction'),
                onPressed: _isReadyToSubmit() ? () => this._submit(locale) : null,
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate({required String locale, required DateTime date}) {
    final dateFormatter = DateFormat.yMd(locale);
    return dateFormatter.format(date);
  }

  bool _isReadyToSubmit() {
    return (_titleInput.text.isNotEmpty && _amountInput.text.isNotEmpty);
    // return true;
  }

  double _parseAmount({required String locale, required String text}) {
    print('... starting tryParse ...');
    final amount = double.tryParse(text);
    if (amount != null) return amount;

    print('... parsing with NF: $text');
    NumberFormat formatter = NumberFormat.decimalPattern(locale);
    return formatter.parse(text).toDouble();
  }

  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(Duration(days: 90)),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) return;
      setState(() => _dateInput = pickedDate);
    });
  }

  void _submit(String locale) {
    final title = _titleInput.text;
    final amount = _parseAmount(locale: locale, text: _amountInput.text);
    final date = _dateInput;

    if (title.isEmpty || amount <= 0) return;

    this.widget.onAdd(title, amount, date);
  }
}
