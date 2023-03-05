// ignore_for_file: depend_on_referenced_packages

import 'package:clean_architecture_utils/utils.dart';
import 'package:flutter/material.dart';

class Trackers extends ITrackersHelper {
  @override
  initPageTrack(String pageName) {
    debugPrint('INIT_PAGE: $pageName');
  }

  @override
  stopPageTrack(String pageName, {Map<String, Object>? infos}) {
    debugPrint('STOP_PAGE: $pageName');
  }

  @override
  trackCustomEvent(String eventName, {required Map<String, Object> infos}) {
    debugPrint('CUSTOM_EVENT: $eventName');
  }

  @override
  Widget trackedPrimaryButton({
    required String btnId,
    required String btnTitle,
    required VoidCallback? onPress,
    Map<String, Object>? infosToTrack,
  }) {
    final action = onPress == null
        ? null
        : () {
            debugPrint('TRACK_BUTTON_CLICK: $btnId');
            onPress.call();
          };

    return ElevatedButton(
      onPressed: action,
      style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
      key: Key(btnId),
      child: Text(
        btnTitle,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  @override
  Widget trackedSecondaryButton({
    required String btnId,
    required String btnTitle,
    required VoidCallback? onPress,
    Map<String, Object>? infosToTrack,
  }) {
    return Container();
  }
}
