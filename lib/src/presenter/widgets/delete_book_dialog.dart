import 'package:clean_architecture_utils/modular.dart';
import 'package:clean_architecture_utils/utils.dart';
import 'package:flutter/material.dart';

import '../localizations/module_localization.dart';

class DeleteBookDialog extends StatelessWidget {
  final ITrackersHelper trackersHelper = Modular.get();
  final Function(dynamic value) onClose;

  DeleteBookDialog(
    this.onClose, {
    super.key,
  });

  Future show(BuildContext context) async {
    final result = await showGeneralDialog(
      barrierLabel: 'delete_dialog_barrier',
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 300),
      context: context,
      pageBuilder: (_, __, ___) => this,
      transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position: Tween(
            begin: const Offset(0, 1),
            end: const Offset(0, 0),
          ).animate(anim),
          child: child,
        );
      },
    );

    onClose.call(result);
    return result;
  }

  @override
  Widget build(BuildContext context) {
    final localization = ModuleLocalizations().deleteBookDilaog;

    return AlertDialog(
      title: Text(localization.deleteDialogTitle),
      content: Text(localization.deleteDialogMessage),
      actions: [
        TextButton(
          child: Text(localization.deleteDialogNegativeButton),
          onPressed: () {
            Navigator.of(context).pop();
            onClose.call(false);
          },
        ),
        TextButton(
          child: Text(localization.deleteDialogPositiveButton),
          onPressed: () {
            Navigator.of(context).pop();
            onClose.call(true);
          },
        ),
      ],
    );
  }
}
