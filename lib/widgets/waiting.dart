import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Waiting extends StatelessWidget {
  const Waiting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          AppLocalizations.of(context)?.noDataText ?? 'No data found',
          style: Theme.of(context).textTheme.headline6,
        ),
        SizedBox(height: 16.0),
        Image.asset(
          'assets/images/waiting.png',
          height: MediaQuery.of(context).size.height * 0.5,
          fit: BoxFit.cover,
        ),
      ],
    );
  }
}
