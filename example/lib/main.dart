// ignore_for_file: depend_on_referenced_packages

import 'package:clean_architecture_utils/modular.dart';
import 'package:example/app_widget.dart';
import 'package:flutter/material.dart';

import 'app_module.dart';

void main() {
  final app = ModularApp(
    module: AppModule(),
    child: const AppWidget(),
  );

  runApp(app);
  Modular.setInitialRoute(Modular.initialRoute);
}
