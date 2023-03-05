import 'package:clean_architecture_utils/events.dart';

import 'app_widget_store.dart';

class EventController {
  final EventBus _eventBus;
  final AppWidgetStore? _appWidgetStore;

  EventController(this._eventBus, this._appWidgetStore) {
    _eventBus.on().listen((event) {
      if (event is EventInfo) _parseData(event);
    });
  }

  _parseData(EventInfo info) {
    switch (info.name) {
      case DefaultEvents.showSuccessMessageEvent:
        _appWidgetStore?.showSuccessMessage(info.data);
        break;
      case DefaultEvents.showErrorMessageEvent:
        _appWidgetStore?.showErrorMessage(info.data);
        break;
      case DefaultEvents.showAppLoaderEvent:
        _appWidgetStore?.showLoaderApp();
        break;
      case DefaultEvents.hideAppLoaderEvent:
        _appWidgetStore?.hideLoaderApp();
        break;
      default:
    }
  }
}
