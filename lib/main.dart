import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'app.dart';

void main() {
  // initializeDateFormatting('de_DE', null).then((_) => runApp(App()));
  WidgetsFlutterBinding.ensureInitialized();
  // define which orientations are allowed for this app
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.landscapeLeft,
  //   DeviceOrientation.landscapeRight,
  //   DeviceOrientation.portraitDown,
  //   DeviceOrientation.portraitUp,
  // ]);
  runApp(App());
}
