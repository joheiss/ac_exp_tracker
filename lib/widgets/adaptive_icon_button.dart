import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveIconButton extends StatelessWidget {
  final Icon icon;
  final VoidCallback? onPressed;
  const AdaptiveIconButton({Key? key, required this.icon, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            child: icon,
            onPressed: onPressed,
            padding: EdgeInsets.zero,
          )
        : IconButton(
            icon: icon,
            color: Theme.of(context).primaryColor,
            onPressed: onPressed,
          );
  }
}
