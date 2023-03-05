import 'dart:developer';

import 'package:biblioteca_books_module/biblioteca_books_module.dart';
import 'package:clean_architecture_utils/events.dart';
import 'package:example/persist_list_helper.dart';

import 'app_widget_store.dart';
import 'image_helper.dart';

class EventController {
  final EventBus _eventBus;
  final AppWidgetStore? _appWidgetStore;
  final PersistListHelper _persistList;

  EventController(
    this._eventBus,
    this._appWidgetStore,
    this._persistList,
  ) {
    _eventBus.on().listen((event) {
      if (event is EventInfo) _parseData(event);
    });
  }

  _parseData(EventInfo info) async {
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
      case BooksModuleEvents.getBooks:
        _eventBus.fire(EventInfo(
          name: BooksModuleEvents.updateHomeBooks,
          data: [..._persistList.list],
        ));
        break;
      case BooksModuleEvents.saveBook:
        final data = info.data as BookToSaveEntity?;
        if (data == null) return;

        if (data.imageFile != null) {
          log('BBBBBBBB');
          await ImageHelper.saveImage(
            data.imageFile!,
            data.book.imagePath ?? '',
          );
        }

        log('AAAAAAAA');
        List<BookEntity> newList = [..._persistList.list];
        newList.add(data.book);
        log('NEW_LIST: $newList');
        _persistList.list = newList;

        _eventBus.fire(
          const EventInfo(name: BooksModuleEvents.bookSavedSuccess),
        );
        break;
      case BooksModuleEvents.deleteBook:
        final data = info.data as BookEntity?;
        if (data == null) return;

        List<BookEntity> newList = [..._persistList.list];
        newList.remove(data);
        _persistList.list = newList;

        _eventBus.fire(EventInfo(
          name: BooksModuleEvents.updateHomeBooks,
          data: [..._persistList.list],
        ));
        break;
      default:
    }
  }
}
