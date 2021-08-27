import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveElevatedButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  const AdaptiveElevatedButton({Key? key, required this.child, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Platform.isIOS
        ? CupertinoButton(
            child: child,
            onPressed: onPressed,
            color: theme.primaryColor,
            // padding: EdgeInsets.zero,
          )
        : ElevatedButton(
            child: child,
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              primary: theme.primaryColor,
            ),
          );
  }
}
