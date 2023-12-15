import 'package:flutter/material.dart';

void pushNamed({required String routeName, required BuildContext ctx}) {
  Navigator.of(ctx).pushNamed(routeName);
  return;
}

void popAndPushNamed({required String routeName, required BuildContext ctx}) {
  Navigator.of(ctx).popAndPushNamed(routeName);
  return;
}
