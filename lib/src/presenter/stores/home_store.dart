import 'dart:async';

import 'package:biblioteca_books_module/src/presenter/module_router.dart';
import 'package:clean_architecture_utils/events.dart';
import 'package:clean_architecture_utils/utils.dart';

import '../../domain/entities/book_entity.dart';
import '../events.dart';

class HomeStore extends MainStore<List<BookEntity>> {
  final ModuleRouter _routes;

  final StreamController<bool> isEmptyController = StreamController<bool>();
  Stream<bool> get isEmptyStream => isEmptyController.stream;

  HomeStore(
    this._routes,
    EventBus? eventBus,
  ) : super(eventBus, []);

  getBooks() async {
    eventBus?.fire(const EventInfo(name: BooksModuleEvents.getBooks));
    eventBus?.on().listen((event) {
      if (event is EventInfo) _parseData(event);
    });
  }

  openDetails([BookEntity? book]) => _routes.openDetails(book);

  _parseData(EventInfo info) {
    switch (info.name) {
      case BooksModuleEvents.updateHomeBooks:
        final books = (info.data as List<BookEntity>?) ?? [];
        isEmptyController.sink.add(books.isEmpty);
        update(books);
        break;
      default:
    }
  }
}
