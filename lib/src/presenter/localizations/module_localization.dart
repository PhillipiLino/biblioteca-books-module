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
  final deleteBookDilog = _DeleteBookDialog();
  final details = _DetailsPage();
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

class _DetailsPage {
  String get detailsPageTitle => Intl.message('', name: 'detailsPageTitle');
  String get detailsPageFieldNameHint =>
      Intl.message('', name: 'detailsPageFieldNameHint');
  String get detailsPageFieldAuthorHint =>
      Intl.message('', name: 'detailsPageFieldAuthorHint');
  String get detailsPageFieldPagesHint =>
      Intl.message('', name: 'detailsPageFieldPagesHint');
  String get detailsPageFieldReadPagesHint =>
      Intl.message('', name: 'detailsPageFieldReadPagesHint');
  String get detailsPageSaveButton =>
      Intl.message('', name: 'detailsPageSaveButton');
}
