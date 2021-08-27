import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'l10n/l10n.dart';
import 'pages/transactions_page.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return Platform.isIOS
    //     ? CupertinoApp(
    //         title: 'Expense Tracker 1.0',
    //         theme: CupertinoThemeData(
    //           primaryColor: Colors.deepPurple,
    //           primaryContrastingColor: Colors.white,
    //         ),
    //         home: TransactionPage(),
    //         supportedLocales: L10n.all,
    //         localizationsDelegates: [
    //           AppLocalizations.delegate,
    //           GlobalMaterialLocalizations.delegate,
    //           GlobalCupertinoLocalizations.delegate,
    //           GlobalWidgetsLocalizations.delegate,
    //         ],
    //       )
    // : MaterialApp(
    return MaterialApp(
      title: 'Expense Tracker 1.0',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        accentColor: Colors.teal,
        fontFamily: 'Quicksand',
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(fontFamily: 'OpenSans', fontSize: 20.0),
              ),
        ),
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                fontFamily: 'Quicksand',
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
      ),
      home: TransactionPage(),
      supportedLocales: L10n.all,
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
    );
  }
}
