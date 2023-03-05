// coverage:ignore-file

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'messages/messages_all.dart';

class ModuleLocalizations {
  static Future<ModuleLocalizations> load(Locale locale) {
    final String name =
        locale.countryCode == null ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);

    return initializeMessages(localeName).then((bool _) {
      Intl.defaultLocale = localeName;
      return ModuleLocalizations();
    });
  }

  static ModuleLocalizations? of(BuildContext context) {
    return Localizations.of<ModuleLocalizations>(context, ModuleLocalizations);
  }

  final home = _HomePage();
  final deleteBookDilaog = _DeleteBookDialog();
}

class _HomePage {
  String get homeTitle => Intl.message('', name: 'homeTitle');
  String get homeEmptyListTitle => Intl.message('', name: 'homeEmptyListTitle');
  String get homeEmptyListMessage =>
      Intl.message('', name: 'homeEmptyListMessage');
  String get homeEmptyListButton =>
      Intl.message('', name: 'homeEmptyListButton');
  String get homeSearchBarHint => Intl.message('', name: 'homeSearchBarHint');
  String get homeProgressTitle => Intl.message('', name: 'homeProgressTitle');
  String homeProgressMessage(int read, int total) =>
      Intl.message('', name: 'homeProgressMessage', args: [read, total]);
}

class _DeleteBookDialog {
  String get deleteDialogTitle => Intl.message('', name: 'deleteDialogTitle');
  String get deleteDialogMessage =>
      Intl.message('', name: 'deleteDialogMessage');
  String get deleteDialogNegativeButton =>
      Intl.message('', name: 'deleteDialogNegativeButton');
  String get deleteDialogPositiveButton =>
      Intl.message('', name: 'deleteDialogPositiveButton');
}
